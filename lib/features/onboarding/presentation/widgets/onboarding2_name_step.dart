import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/widgets/vestory_text_field.dart';

class Onboarding2NameStep extends StatelessWidget {
  final TextEditingController nameController;
  final String? errorText;

  const Onboarding2NameStep({
    super.key,
    required this.nameController,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Mari Kenalan!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: .bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Siapa namamu?',
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
        SizedBox(height: 32),
        VestoryTextField(
          label: 'Nama',
          hintText: 'Masukkan nama anda',
          controller: nameController,
          errorText: errorText,
        ),
      ],
    );
  }
}
