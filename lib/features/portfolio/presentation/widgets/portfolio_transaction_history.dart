import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../shared/presentation/providers/market_provider.dart';

class PortfolioTransactionHistory extends ConsumerWidget {
  const PortfolioTransactionHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(marketTransactionsProvider);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'Riwayat Transaksi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: .bold,
            color: AppColors.textHeading,
          ),
        ),
        SizedBox(height: 16),
        transactionsAsync.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return Center(
                child: Padding(
                  padding: .all(24.0),
                  child: Text(
                    'Belum ada transaksi',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (context, index) =>
                  Divider(color: AppColors.greenNormal, height: 32),
              itemBuilder: (context, index) {
                final t = transactions[index];
                final date = t.createdAt;
                final dateNum = DateFormat('dd').format(date);
                final monthStr = DateFormat('MMM').format(date);
                final yearStr = DateFormat('yyyy').format(date);

                return Row(
                  crossAxisAlignment: .center,
                  children: [
                    Container(
                      width: 60,
                      padding: .symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.greenLight,
                        borderRadius: .circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            dateNum,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: .bold,
                              color: AppColors.textHeading,
                            ),
                          ),
                          Text(
                            monthStr,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            yearStr,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            t.ticker != null && t.ticker!.isNotEmpty
                                ? '${t.type} ${t.ticker} ${t.lots ?? 0} Lot'
                                : t.type,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: .bold,
                              color: AppColors.textHeading,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            t.totalAmount.toIdr(withPrefix: true),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: .bold,
                              color: AppColors.textHeading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text('Gagal memuat transaksi')),
        ),
      ],
    );
  }
}
