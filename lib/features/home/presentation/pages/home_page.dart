import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/balance_section.dart';
import '../widgets/stock_market_section.dart';
import '../widgets/trending_section.dart';
import '../../../../shared/presentation/widgets/vestory_popup.dart';
import '../../../notification/presentation/providers/notification_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = .new();

  static bool _hasShownReward = false;

  @override
  void initState() {
    super.initState();
    if (!_hasShownReward) {
      _hasShownReward = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showFirstDayReward(context);
      });
    }
  }

  void _showFirstDayReward(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return VestoryPopup(
          confirmText: 'Ambil',
          onConfirm: () {
            Navigator.of(context).pop();
          },
          content: Column(
            mainAxisSize: .min,
            children: [
              Text(
                'Bonus First Day\nReward',
                textAlign: .center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Rp10.000.000',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: .w900,
                  color: AppColors.greenNormal,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Selamat\nBereksplorasi!',
                textAlign: .center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Keep notification observer alive while on Home
    ref.watch(missionNotificationObserverProvider);

    return Scaffold(
      backgroundColor: AppColors.greenNormal,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.baseWhite,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: TextField(
                        readOnly: true,
                        onTap: () => context.push('/search'),
                        decoration: InputDecoration(
                          hintText: 'Cari Saham',
                          hintStyle: TextStyle(
                            color: AppColors.neutralDark,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.search,
                              color: AppColors.baseBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => context.push('/notification'),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.baseWhite,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.notifications_none,
                          color: AppColors.greenNormal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Padding(
                              padding: .symmetric(horizontal: 24),
                              child: BalanceSection(),
                            ),
                            SizedBox(height: 24),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.baseWhite,
                                  borderRadius: BorderRadius.only(
                                    topLeft: .circular(32),
                                    topRight: .circular(32),
                                  ),
                                ),
                                padding: .only(top: 24, bottom: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StockMarketSection(),
                                    SizedBox(height: 24),
                                    TrendingSection(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
