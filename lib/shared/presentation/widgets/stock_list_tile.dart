import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/utils/stock_utils.dart';
import '../../../../shared/presentation/providers/market_provider.dart';

import 'package:go_router/go_router.dart';

class StockListTile extends ConsumerWidget {
  final Stock stock;

  const StockListTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartAsync = ref.watch(stockChartProvider(stock.ticker));

    return InkWell(
      onTap: () => context.push('/stock/${stock.ticker}'),
      child: Container(
        margin: .only(bottom: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.greenNormal)),
        ),
        padding: .only(bottom: 16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.orangeNormal,
                shape: .circle,
              ),
              child: ClipOval(
                child: stock.logoUrl.isNotEmpty
                    ? Image.asset(
                        stock.logoUrl,
                        fit: .cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.business,
                              color: AppColors.baseWhite,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(Icons.business, color: AppColors.baseWhite),
                      ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    stock.ticker,
                    style: TextStyle(fontSize: 16, fontWeight: .bold),
                  ),
                  Text(
                    stock.companyName.split(' ').take(2).join(' '),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
              height: 40,
              child: chartAsync.when(
                data: (history) {
                  if (history.isEmpty) return SizedBox.shrink();

                  final spots = <FlSpot>[];
                  for (int i = 0; i < history.length; i++) {
                    spots.add(FlSpot(i.toDouble(), history[i].close));
                  }

                  return LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(enabled: false),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        drawHorizontalLine: false,
                        horizontalInterval: 1000,
                        verticalInterval: 1,
                      ),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: false,
                          color: AppColors.blueNormal,
                          barWidth: 2,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.blueNormal.withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (_, _) => Icon(Icons.error, size: 24),
              ),
            ),
            SizedBox(width: 4),
            Column(
              crossAxisAlignment: .end,
              children: [
                Text(
                  stock.currentPrice.toIdr(),
                  style: TextStyle(fontSize: 16, fontWeight: .bold),
                ),
                Text(
                  '${stock.isPositive ? '+' : ''}${stock.diff.toIdr(withPrefix: false)} (${stock.percent.toStringAsFixed(2)}%)',
                  style: TextStyle(
                    fontSize: 12,
                    color: stock.isPositive
                        ? AppColors.greenNormal
                        : AppColors.redNormal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
