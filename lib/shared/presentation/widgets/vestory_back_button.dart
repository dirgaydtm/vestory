import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class VestoryBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const VestoryBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: .circle,
          border: .all(color: AppColors.greenNormal.withValues(alpha: 0.5)),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
