import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class StockLogo extends StatelessWidget {
  final String ticker;
  final double size;

  const StockLogo({super.key, required this.ticker, this.size = 64});

  String _getImagePath(String ticker) {
    final lower = ticker.toLowerCase().replaceAll('.jk', '');
    if (lower == 'goto') return 'assets/images/stocks/$lower.jpg';
    if (lower == 'bmri') return 'assets/images/stocks/$lower.webp';
    return 'assets/images/stocks/$lower.png';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: .circle, color: AppColors.neutralNormal),
      clipBehavior: .antiAlias,
      child: Image.asset(
        _getImagePath(ticker),
        fit: .cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
              ticker.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontSize: size * 0.4,
                fontWeight: .bold,
                color: AppColors.textPrimary,
              ),
            ),
          );
        },
      ),
    );
  }
}
