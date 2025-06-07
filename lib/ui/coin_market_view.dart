import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_cripto/coin_market_repository.dart';
import 'package:api_cripto/coin_market_datasource.dart';
import 'package:api_cripto/coin_market_viewmodel.dart';
import 'package:api_cripto/ui/widgets/coin_market_body.dart';

class CoinMarketView extends StatelessWidget {
  const CoinMarketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoinMarketViewModel(
        CoinMarketRepository(
          CoinMarketDataSource(),
        ),
      )..fetchCoins(),
      child: const CoinMarketBody(),
    );
  }
}