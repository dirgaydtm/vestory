import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../shared/presentation/providers/portfolio_provider.dart';
import '../../../../shared/presentation/providers/user_provider.dart';

class BalanceSection extends ConsumerStatefulWidget {
  const BalanceSection({super.key});

  @override
  ConsumerState<BalanceSection> createState() => _BalanceSectionState();
}

class _BalanceSectionState extends ConsumerState<BalanceSection> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProfileProvider);
    final perf = ref.watch(portfolioPerformanceProvider);

    return Column(
      children: [
        Center(
          child: userAsync.when(
            data: (user) => Text(
              'Selamat datang, ${user?.name ?? 'User'}!',
              style: TextStyle(
                color: AppColors.baseWhite,
                fontSize: 16,
                fontWeight: .bold,
              ),
            ),
            loading: () => SizedBox(height: 20),
            error: (_, _) => SizedBox(height: 20),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: .all(12),
          decoration: BoxDecoration(
            color: AppColors.baseWhite,
            borderRadius: .circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.baseBlack.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'Saldo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/portfolio'),
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
              SizedBox(height: 16),
              Container(
                padding: .all(16),
                decoration: BoxDecoration(
                  color: AppColors.greenLightActive,
                  borderRadius: .circular(16),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          _isBalanceVisible
                              ? (perf?.totalEquity ?? 0.0).toIdr()
                              : 'Rpxxx.xxx',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: .bold,
                            color: AppColors.textHeading,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                            });
                          },
                          child: Icon(
                            _isBalanceVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textHeading,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.greenNormalActive),
                    if (perf != null)
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            '${perf.isPositive ? '+' : ''}${perf.diff.toIdr(withPrefix: true)}',
                            style: TextStyle(
                              color: perf.isPositive
                                  ? AppColors.greenNormal
                                  : AppColors.redNormal,
                              fontWeight: .bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            perf.isPositive
                                ? Icons.show_chart
                                : Icons.stacked_line_chart,
                            color: perf.isPositive
                                ? AppColors.greenNormal
                                : AppColors.redNormal,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${perf.isPositive ? '+' : ''}${perf.diffPercent.toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: perf.isPositive
                                  ? AppColors.greenNormal
                                  : AppColors.redNormal,
                              fontWeight: .bold,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
