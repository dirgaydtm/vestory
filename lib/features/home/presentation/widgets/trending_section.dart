import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/widgets/stock_list_tile.dart';

class TrendingSection extends ConsumerWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(marketStocksProvider);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .symmetric(horizontal: 24),
          child: Text(
            'Trending',
            style: TextStyle(
              fontSize: 16,
              fontWeight: .bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(height: 16),
        stocksAsync.when(
          data: (stocks) {
            final randomStocks = stocks.toList()..shuffle();
            return Padding(
              padding: .symmetric(horizontal: 24),
              child: Column(
                children: [
                  ...randomStocks
                      .take(5)
                      .map((stock) => StockListTile(stock: stock)),
                ],
              ),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text('Error')),
        ),
      ],
    );
  }
}
