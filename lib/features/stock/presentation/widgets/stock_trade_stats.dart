import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';

class StockTradeStats extends StatelessWidget {
  final Stock stock;

  const StockTradeStats({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: AppColors.greenNormal, thickness: 2),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _stat('Open', stock.previousPrice)),
            Expanded(child: _stat('Vol', stock.volume / 1000, suffix: 'K')),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _stat('High', stock.currentPrice * 1.02)),
            Expanded(
              child: _stat(
                'Val',
                stock.volume * stock.currentPrice / 1000000,
                suffix: 'M',
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _stat('Low', stock.currentPrice * 0.98)),
            Expanded(
              child: _stat(
                'Avg',
                (stock.currentPrice + stock.previousPrice) / 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(color: AppColors.greenNormal, thickness: 2),
      ],
    );
  }

  Widget _stat(String label, double value, {String suffix = ''}) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: .bold,
            color: AppColors.textPrimary,
          ),
        ),
        Padding(
          padding: .only(right: 16.0),
          child: Text(
            '${value.toInt()}$suffix',
            style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
