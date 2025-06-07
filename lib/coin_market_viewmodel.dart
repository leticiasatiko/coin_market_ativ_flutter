import 'package:flutter/material.dart';
import 'coin_market_repository.dart';

class CoinMarketViewModel extends ChangeNotifier {
  final CoinMarketRepository _repository;
  List<Map<String, dynamic>> _coins = [];
  bool _loading = false;
  String _error = '';

  List<Map<String, dynamic>> get coins => _coins;
  bool get loading => _loading;
  String get error => _error;

  CoinMarketViewModel(this._repository);

  Future<void> fetchCoins({String? search}) async {
    _loading = true;
    _error = '';
    notifyListeners();

    try {
      _coins = await _repository.getCoins(search: search);
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }
}