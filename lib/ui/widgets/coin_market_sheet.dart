import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinDetailSheet extends StatelessWidget {
  final Map<String, dynamic> coin;

  const CoinDetailSheet({super.key, required this.coin});

  String _formatDate(String? date) {
    if (date == null) return "--";
    try {
      final dt = DateTime.parse(date);
      return DateFormat.yMMMMd('pt_BR').format(dt);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final usdFormat = NumberFormat.simpleCurrency(locale: 'en_US', name: 'USD');
    final brlFormat = NumberFormat.simpleCurrency(locale: 'pt_BR', name: 'BRL');
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${coin['name']} (${coin['symbol']})',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (coin['date_added'] != null)
          Text('Data adicionada: ${_formatDate(coin['date_added'])}'),
          Text('Símbolo: ${coin['symbol']}'),
          const SizedBox(height: 16),
          Text('Preço atual em USD: ${coin['price_usd'] != null ? usdFormat.format(coin['price_usd']) : "--"}'),
          Text('Preço atual em BRL: ${coin['price_brl'] != null ? brlFormat.format(coin['price_brl']) : "--"}'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}