import 'package:flutter/material.dart';

class StockDetailPage extends StatelessWidget {
  final String? id;

  const StockDetailPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Stock Detail Page ${id ?? ""}')));
  }
}
