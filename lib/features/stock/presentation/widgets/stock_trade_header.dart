import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/utils/stock_utils.dart';
import '../../../../shared/data/constants/stock_constants.dart';
import '../../../../shared/presentation/widgets/stock_logo.dart';

class StockTradeHeader extends StatelessWidget {
  final Stock stock;

  const StockTradeHeader({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final companyName =
        StockConstants.companyInfo[stock.ticker]?.name ?? stock.name;
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        border: .all(color: AppColors.greenLightActive),
      ),
      child: Row(
        children: [
          StockLogo(ticker: stock.ticker, size: 48),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  stock.ticker,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: .bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: .end,
            children: [
              Text(
                stock.currentPrice.toIdr(withPrefix: false),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .bold,
                  color: AppColors.textHeading,
                ),
              ),
              Text(
                '${stock.isPositive ? '+' : ''}${stock.percent.abs().toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: .bold,
                  color: stock.isPositive
                      ? AppColors.greenNormal
                      : AppColors.redNormal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
