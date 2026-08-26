import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../../../shared/presentation/widgets/vestory_back_button.dart';
import '../widgets/stock_chart_section.dart';
import '../widgets/stock_detail_header.dart';
import '../widgets/stock_detail_stats.dart';
import '../widgets/stock_detail_about.dart';

class StockDetailPage extends ConsumerWidget {
  final String? id;

  const StockDetailPage({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id == null) return Scaffold(body: Center(child: Text('Not found')));

    final stocksAsync = ref.watch(marketStocksProvider);

    return Scaffold(
      backgroundColor: AppColors.baseBackground,
      body: stocksAsync.when(
        data: (stocks) {
          final stock = stocks.firstWhere(
            (s) => s.ticker == id,
            orElse: () => throw Exception('Stock not found'),
          );

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: .all(24),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          crossAxisAlignment: .center,
                          children: [
                            VestoryBackButton(onTap: () => context.pop()),
                            SizedBox(width: 16),
                            Text(
                              stock.ticker,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: .bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        StockDetailHeader(stock: stock),
                        SizedBox(height: 32),
                        StockChartSection(ticker: stock.ticker),
                        SizedBox(height: 24),
                        StockDetailStats(stock: stock),
                        SizedBox(height: 32),
                        StockDetailAbout(stock: stock),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: .all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: 'Jual',
                          isOutlined: true,
                          color: AppColors.redNormal,
                          onPressed: () =>
                              context.push('/stock/${stock.ticker}/sell'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: PrimaryButton(
                          text: 'Beli',
                          onPressed: () =>
                              context.push('/stock/${stock.ticker}/buy'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Failed to load stock data')),
      ),
    );
  }
}
