import 'package:flutter/material.dart';

class StockSellPage extends StatelessWidget {
  final String? id;

  const StockSellPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Stock Sell Page ${id ?? ""}')));
  }
}
