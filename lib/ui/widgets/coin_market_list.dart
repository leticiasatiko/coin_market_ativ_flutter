import 'package:flutter/material.dart';
import 'package:api_cripto/ui/widgets/coin_market_subtela.dart';


class CoinList extends StatelessWidget {
  final List<Map<String, dynamic>> coins;
  final ValueChanged<Map<String, dynamic>> onTap;

  const CoinList({
    super.key,
    required this.coins,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final coin = coins[index];
        return CoinListTile(
          coin: coin,
          onTap: () => onTap(coin),
        );
      },
    );
  }
}