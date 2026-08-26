import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';

class StockTradeOrderCard extends StatelessWidget {
  final bool isBuy;
  final double total;
  final int price;
  final int lots;
  final VoidCallback onPriceDecrement;
  final VoidCallback onPriceIncrement;
  final VoidCallback onLotsDecrement;
  final VoidCallback onLotsIncrement;

  const StockTradeOrderCard({
    super.key,
    required this.isBuy,
    required this.total,
    required this.price,
    required this.lots,
    required this.onPriceDecrement,
    required this.onPriceIncrement,
    required this.onLotsDecrement,
    required this.onLotsIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        border: .all(color: AppColors.greenLightActive),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    isBuy ? 'Investasi' : 'Estimasi Hasil',
                    style: TextStyle(
                      fontWeight: .bold,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    isBuy ? '(Tambah ongkos)' : '(Kurang ongkos)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                total.toIdr(withPrefix: true),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .bold,
                  color: AppColors.textHeading,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _counterRow('Harga', price, onPriceDecrement, onPriceIncrement),
          SizedBox(height: 16),
          _counterRow(
            '${isBuy ? 'Beli' : 'Jual'} Order Lot',
            lots,
            onLotsDecrement,
            onLotsIncrement,
          ),
        ],
      ),
    );
  }

  Widget _counterRow(
    String label,
    int value,
    VoidCallback dec,
    VoidCallback inc,
  ) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: .bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        Row(
          children: [
            IconButton(icon: Icon(Icons.remove), onPressed: dec),
            SizedBox(
              width: 60,
              child: Text(
                value.toString(),
                textAlign: .center,
                style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
              ),
            ),
            IconButton(icon: Icon(Icons.add), onPressed: inc),
          ],
        ),
      ],
    );
  }
}
