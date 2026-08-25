import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'style_selection_card.dart';

class Onboarding2StyleStep extends StatelessWidget {
  final String? selectedStyle;
  final ValueChanged<String> onStyleSelected;

  const Onboarding2StyleStep({
    super.key,
    required this.selectedStyle,
    required this.onStyleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Apa Gaya Mainmu?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: .bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Kamu lebih suka investasi seperti apa?',
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
        SizedBox(height: 32),
        StyleSelectionCard(
          title: 'The Planner',
          description: 'Fokus awal pada instrumen berisiko rendah.',
          imagePath: 'assets/images/onboarding/planner.webp',
          isSelected: selectedStyle == 'planner',
          onTap: () => onStyleSelected('planner'),
        ),
        SizedBox(height: 16),
        StyleSelectionCard(
          title: 'The Risk Taker',
          description: 'Fokus pada aset dengan fluktuasi tinggi.',
          imagePath: 'assets/images/onboarding/risk.webp',
          isSelected: selectedStyle == 'risk',
          onTap: () => onStyleSelected('risk'),
        ),
      ],
    );
  }
}
