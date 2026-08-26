import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/widgets/vestory_popup.dart';

class StockSuccessDialog extends StatelessWidget {
  final bool isBuy;

  const StockSuccessDialog({super.key, required this.isBuy});

  @override
  Widget build(BuildContext context) {
    return VestoryPopup(
      content: Column(
        children: [
          Text(
            isBuy ? 'Pembelian Berhasil!' : 'Penjualan Berhasil!',
            textAlign: .center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: .bold,
              color: AppColors.textHeading,
            ),
          ),
        ],
      ),
      confirmText: 'Lanjut',
      onConfirm: () {
        context.pop();
        context.pop();
      },
    );
  }
}
