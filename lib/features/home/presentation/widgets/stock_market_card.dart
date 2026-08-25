import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/utils/stock_analytics.dart';

class StockMarketCard extends StatelessWidget {
  final Stock stock;

  const StockMarketCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: .only(right: 16, bottom: 8),
      padding: .symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: stock.isPositive
            ? AppColors.greenLightActive
            : AppColors.redLightActive,
        borderRadius: .circular(24),
        border: .all(color: AppColors.greenNormal, width: 2),
        boxShadow: [
          BoxShadow(color: AppColors.greenNormal, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          Text(stock.ticker, style: TextStyle(fontSize: 14, fontWeight: .bold)),
          SizedBox(height: 4),
          Text(
            stock.currentPrice.toIdr(withPrefix: false),
            style: TextStyle(fontSize: 20, fontWeight: .bold),
          ),
          SizedBox(height: 4),
          Text(
            '${stock.isPositive ? '+' : ''}${stock.diff.toIdr(withPrefix: false)}(${stock.percent.toStringAsFixed(2)}%)',
            style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
