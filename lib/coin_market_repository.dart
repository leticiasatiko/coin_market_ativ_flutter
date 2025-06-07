import 'package:api_cripto/coin_market_datasource.dart';

class CoinMarketRepository {
  final CoinMarketDataSource _dataSource;
  CoinMarketRepository(this._dataSource);

  Future<List<Map<String, dynamic>>> getCoins({String? search}) {
    return _dataSource.fetchCoins(search: search);
  }
}