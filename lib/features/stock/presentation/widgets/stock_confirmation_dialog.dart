import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import 'stock_success_dialog.dart';

class StockConfirmationDialog extends ConsumerStatefulWidget {
  final String ticker;
  final bool isBuy;
  final double price;
  final int lots;

  const StockConfirmationDialog({
    super.key,
    required this.ticker,
    required this.isBuy,
    required this.price,
    required this.lots,
  });

  @override
  ConsumerState<StockConfirmationDialog> createState() =>
      _StockConfirmationDialogState();
}

class _StockConfirmationDialogState
    extends ConsumerState<StockConfirmationDialog> {
  bool _isLoading = false;

  void _onConfirm() async {
    setState(() => _isLoading = true);
    try {
      if (widget.isBuy) {
        await ref
            .read(marketRepositoryProvider)
            .buyStock(widget.ticker, widget.lots);
      } else {
        await ref
            .read(marketRepositoryProvider)
            .sellStock(widget.ticker, widget.lots);
      }
      if (mounted) {
        context.pop();
        showDialog(
          context: context,
          builder: (context) => StockSuccessDialog(isBuy: widget.isBuy),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.redNormal,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.price * AppConstants.stockLotSize * widget.lots;
    final brokerFee = subtotal * AppConstants.brokerFeeRate;
    final exchangeFee = subtotal * AppConstants.exchangeFeeRate;
    final total = widget.isBuy
        ? subtotal + brokerFee + exchangeFee
        : subtotal - brokerFee - exchangeFee;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        borderRadius: .vertical(top: .circular(24)),
      ),
      padding: .all(24),
      child: Column(
        mainAxisSize: .min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: .circular(2),
            ),
          ),
          SizedBox(height: 24),
          Text(
            '${widget.isBuy ? 'Beli' : 'Jual'} ${widget.ticker}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: .bold,
              color: AppColors.textHeading,
            ),
          ),
          SizedBox(height: 32),
          _buildRow('Stok', widget.ticker),
          _buildRow('Harga', widget.price.toIdr(withPrefix: false)),
          _buildRow('Lot', widget.lots.toString()),
          _buildRow(
            widget.isBuy ? 'Investasi' : 'Hasil',
            subtotal.toIdr(withPrefix: true),
          ),
          _buildRow('Ongkos Broker', brokerFee.toIdr(withPrefix: true)),
          _buildRow('Ongkos Pertukaran', exchangeFee.toIdr(withPrefix: true)),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '${widget.isBuy ? 'Investasi' : 'Hasil'} (+Ongkos)',
                style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
              ),
              Text(
                total.toIdr(withPrefix: true),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .bold,
                  color: AppColors.textHeading,
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Batal',
                  isOutlined: true,
                  color: AppColors.redNormal,
                  onPressed: _isLoading ? () {} : () => context.pop(),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : PrimaryButton(
                        text: 'Konfirmasi',
                        color: widget.isBuy
                            ? AppColors.greenNormal
                            : AppColors.redNormal,
                        onPressed: _onConfirm,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: .only(bottom: 4),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
