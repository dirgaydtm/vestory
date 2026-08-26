import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import 'stock_market_card.dart';

class StockMarketSection extends ConsumerWidget {
  const StockMarketSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(marketStocksProvider);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'Stok Market',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/more'),
                child: Container(
                  padding: .symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.greenLight,
                    borderRadius: .circular(16),
                  ),
                  child: Text(
                    'More',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: .bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: stocksAsync.when(
            data: (stocks) {
              final randomStocks = stocks.toList()..shuffle();
              final displayStocks = randomStocks.take(3).toList();

              if (displayStocks.isEmpty) {
                return Center(child: Text('Kosong'));
              }
              return ListView.builder(
                scrollDirection: .horizontal,
                padding: .symmetric(horizontal: 24),
                itemCount: displayStocks.length,
                itemBuilder: (context, index) {
                  final stock = displayStocks[index];
                  return StockMarketCard(stock: stock);
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (_, _) => Center(child: Text('Error')),
          ),
        ),
      ],
    );
  }
}
