import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinMarketDataSource {
  final String _url =
      'https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest';
  final String _apiKey = '10f88a7d-10f2-41c8-8624-f14c549417b0';

  Future<List<Map<String, dynamic>>> fetchCoins({
    String symbols =
        'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO',
    String? search,
  }) async {
    final urlUSD = '$_url?symbol=$symbols&convert=USD';
    final responseUSD = await http.get(
      Uri.parse(urlUSD),
      headers: {
        'X-CMC_PRO_API_KEY': _apiKey,
        'Accept': 'application/json',
      },
    );

    final urlBRL = '$_url?symbol=$symbols&convert=BRL';
    final responseBRL = await http.get(
      Uri.parse(urlBRL),
      headers: {
        'X-CMC_PRO_API_KEY': _apiKey,
        'Accept': 'application/json',
      },
    );

    if (responseUSD.statusCode == 200 && responseBRL.statusCode == 200) {
      final Map<String, dynamic> dataUSD = jsonDecode(responseUSD.body)['data'];
      final Map<String, dynamic> dataBRL = jsonDecode(responseBRL.body)['data'];

      List<Map<String, dynamic>> coinList = [];

      for (var symbol in symbols.split(',')) {
        final coinUSD = dataUSD[symbol];
        final coinBRL = dataBRL[symbol];

        if (coinUSD != null && coinBRL != null) {
          final coinInfo = coinUSD[0]; 
          final quoteUSD = coinInfo['quote']['USD'];
          final quoteBRL = coinBRL[0]['quote']['BRL'];

          final coin = {
            'symbol': coinInfo['symbol'],
            'name': coinInfo['name'],
            'date_added': coinInfo['date_added'],
            'price_usd': quoteUSD['price'],
            'price_brl': quoteBRL['price'],
          };

          if (search == null ||
              coin['name'].toString().toLowerCase().contains(search.toLowerCase()) ||
              coin['symbol'].toString().toLowerCase().contains(search.toLowerCase())) {
            coinList.add(coin);
          }
        }
      }

      return coinList;
    } else {
      throw Exception('Erro ao buscar dados da CoinMarketCap');
    }
  }
}