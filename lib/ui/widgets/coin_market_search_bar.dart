import 'package:flutter/material.dart';

class CoinSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSearchTap;

  const CoinSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Pesquisar moeda',
        hintText: 'Ex. BTC,ETH,SOL,BNB..',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        onChanged(value);
        if (value.isEmpty) {
          onSearchTap();
        }
      },
      onSubmitted: (_) => onSearchTap(),
    );
  }
}