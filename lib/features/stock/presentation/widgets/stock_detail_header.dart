import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../shared/presentation/widgets/stock_logo.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../providers/chart_range_provider.dart';

class StockDetailHeader extends ConsumerWidget {
  final Stock stock;

  const StockDetailHeader({super.key, required this.stock});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRange = ref.watch(chartRangeProvider);
    final historyAsync = ref.watch(stockDetailChartProvider(stock.ticker));

    double currentPrice = stock.currentPrice;
    double startPrice = stock.previousPrice;

    if (historyAsync.hasValue && historyAsync.value != null) {
      if (selectedRange == '1D') {
        startPrice = stock.previousPrice;
      } else {
        final sliced = sliceHistory(historyAsync.value!, selectedRange);
        if (sliced.isNotEmpty) {
          startPrice = sliced.first.open;
        }
      }
    }

    final diff = currentPrice - startPrice;
    final percent = startPrice == 0 ? 0.0 : (diff / startPrice) * 100;
    final isPositive = diff >= 0;

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                Text(
                  stock.ticker,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: .bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  isPositive ? '▲' : '▼',
                  style: TextStyle(
                    fontSize: 28,
                    color: isPositive
                        ? AppColors.greenNormal
                        : AppColors.redNormal,
                  ),
                ),
              ],
            ),
            Text(
              currentPrice.toIdr(withPrefix: false),
              style: TextStyle(
                fontSize: 32,
                fontWeight: .bold,
                color: AppColors.textHeading,
              ),
            ),
            Row(
              children: [
                Text(
                  '${isPositive ? '+' : ''}${diff.abs().toIdr(withPrefix: false)}',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
                SizedBox(width: 8),
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  '${percent.abs().toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
              ],
            ),
          ],
        ),
        StockLogo(ticker: stock.ticker, size: 80),
      ],
    );
  }
}
