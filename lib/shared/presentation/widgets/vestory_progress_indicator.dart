import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class VestoryProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const VestoryProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: .generate(
        totalSteps,
        (index) => Expanded(
          child: AnimatedContainer(
            duration: .new(milliseconds: 300),
            height: 16, // Height of the capsule
            margin: .symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index <= currentStep
                  ? AppColors.greenNormal
                  : AppColors.neutralNormal.withValues(alpha: 0.2),
              borderRadius: .circular(24),
            ),
          ),
        ),
      ),
    );
  }
}
