import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/widgets/stock_list_tile.dart';
import '../../../../shared/presentation/widgets/vestory_back_button.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(marketStocksProvider);

    return Scaffold(
      backgroundColor: AppColors.baseWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: .all(24.0),
              child: Row(
                children: [
                  VestoryBackButton(onTap: () => context.pop()),
                  SizedBox(width: 16),
                  Text(
                    'Stock Market',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: .bold,
                      color: AppColors.baseBlack,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: stocksAsync.when(
                data: (stocks) {
                  return ListView.builder(
                    padding: .symmetric(horizontal: 24.0),
                    itemCount: stocks.length,
                    itemBuilder: (context, index) {
                      return StockListTile(stock: stocks[index]);
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (_, _) => Center(child: Text('Error loading stocks')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
