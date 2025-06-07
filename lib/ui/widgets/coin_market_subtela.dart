import 'package:flutter/material.dart';

class CoinListTile extends StatelessWidget {
  final Map<String, dynamic> coin;
  final VoidCallback onTap;

  const CoinListTile({
    super.key,
    required this.coin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${coin['name']} (${coin['symbol']})'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('USD: \$${coin['price_usd']?.toStringAsFixed(2) ?? '--'}'),
          Text('BRL: R\$${coin['price_brl']?.toStringAsFixed(2) ?? '--'}'),
        ],
      ),
      onTap: onTap,
    );
  }
}