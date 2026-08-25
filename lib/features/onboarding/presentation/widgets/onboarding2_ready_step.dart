import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class Onboarding2ReadyStep extends StatelessWidget {
  const Onboarding2ReadyStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Image.asset(
          'assets/images/onboarding/ilustrration-end.webp',
          fit: .contain,
          height: 240,
        ),
        SizedBox(height: 32),
        Text(
          'Anda Sudah Siap!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: .bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Siapkah kamu memulai perjalanan bersama Vestory?',
          textAlign: .center,
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
        SizedBox(height: 48),
      ],
    );
  }
}
