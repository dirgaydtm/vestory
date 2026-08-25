import 'package:flutter/material.dart';

class StockBuyPage extends StatelessWidget {
  final String? id;

  const StockBuyPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Stock Buy Page ${id ?? ""}')));
  }
}
