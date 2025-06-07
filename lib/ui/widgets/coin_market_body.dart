import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_cripto/coin_market_viewmodel.dart';
import 'package:api_cripto/ui/widgets/coin_market_search_bar.dart';
import 'package:api_cripto/ui/widgets/coin_market_list.dart';
import 'package:api_cripto/ui/widgets/coin_market_sheet.dart';

class CoinMarketBody extends StatefulWidget {
  const CoinMarketBody({Key? key}) : super(key: key);

  @override
  State<CoinMarketBody> createState() => _CoinMarketBodyState();
}

class _CoinMarketBodyState extends State<CoinMarketBody> {
  final TextEditingController _searchController = TextEditingController();

  void _fetchCoins() {
    context
        .read<CoinMarketViewModel>()
        .fetchCoins(search: _searchController.text.trim());
  }

  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      _fetchCoins(); 
    }
  }

  void _showCoinDetails(BuildContext context, Map<String, dynamic> coin) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CoinDetailSheet(coin: coin),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coin Market')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CoinSearchBar(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onSearchTap: _fetchCoins,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<CoinMarketViewModel>(
                builder: (context, vm, child) {
                  if (vm.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (vm.error.isNotEmpty) {
                    return Center(child: Text('Erro: ${vm.error}'));
                  }
                  if (vm.coins.isEmpty) {
                    return const Center(child: Text('Nenhuma moeda encontrada.'));
                  }
                  return CoinList(
                    coins: vm.coins,
                    onTap: (coin) => _showCoinDetails(context, coin),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}