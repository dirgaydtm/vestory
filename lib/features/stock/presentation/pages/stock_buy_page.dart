import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../../../core/utils/stock_utils.dart';
import '../../../../shared/presentation/widgets/vestory_back_button.dart';
import '../widgets/stock_confirmation_dialog.dart';
import '../widgets/stock_order_book.dart';
import '../widgets/stock_trade_header.dart';
import '../widgets/stock_trade_order_card.dart';
import '../widgets/stock_trade_stats.dart';

class StockBuyPage extends ConsumerStatefulWidget {
  final String? id;

  const StockBuyPage({super.key, this.id});

  @override
  ConsumerState<StockBuyPage> createState() => _StockBuyPageState();
}

class _StockBuyPageState extends ConsumerState<StockBuyPage> {
  int _lots = 10;
  double _price = 0;
  bool _isInit = false;

  void _showConfirmation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StockConfirmationDialog(
        ticker: widget.id!,
        isBuy: true,
        price: _price,
        lots: _lots,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id == null) {
      return Scaffold(body: Center(child: Text('Not found')));
    }

    final stocksAsync = ref.watch(marketStocksProvider);

    return Scaffold(
      backgroundColor: AppColors.baseBackground,
      body: stocksAsync.when(
        data: (stocks) {
          final stock = stocks.firstWhere(
            (s) => s.ticker == widget.id,
            orElse: () => throw Exception('Stock not found'),
          );

          if (!_isInit) {
            _price = stock.currentPrice;
            _isInit = true;
          }

          final investment = _price * 100 * _lots;
          final brokerFee = investment * 0.00342;
          final exchangeFee = investment * 0.00117;
          final total = investment + brokerFee + exchangeFee;

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
                              widget.id!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: .bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        StockTradeHeader(stock: stock),
                        SizedBox(height: 16),
                        StockTradeOrderCard(
                          isBuy: true,
                          total: total,
                          price: _price.toInt(),
                          lots: _lots,
                          onPriceDecrement: () => setState(() {
                            _price = stock
                                .getPreviousPrice(_price.toInt())
                                .toDouble();
                          }),
                          onPriceIncrement: () => setState(() {
                            _price = stock
                                .getNextPrice(_price.toInt())
                                .toDouble();
                          }),
                          onLotsDecrement: () => setState(() {
                            if (_lots > 1) _lots--;
                          }),
                          onLotsIncrement: () => setState(() {
                            _lots++;
                          }),
                        ),
                        SizedBox(height: 24),
                        StockTradeStats(stock: stock),
                        SizedBox(height: 16),
                        StockOrderBook(
                          stock: stock,
                          accent: AppColors.greenNormal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: .symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.baseBackground,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.baseBlack.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: Offset(0, -8),
                      ),
                    ],
                  ),
                  child: PrimaryButton(
                    text: 'Beli',
                    color: AppColors.greenNormal,
                    onPressed: _showConfirmation,
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
