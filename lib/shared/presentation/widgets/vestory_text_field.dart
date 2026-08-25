import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class VestoryTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? errorText;

  const VestoryTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: .w500,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColors.neutralNormal.withValues(alpha: 0.5),
            ),
            contentPadding: .symmetric(horizontal: 24, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: .circular(24),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red
                    : AppColors.greenNormal.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: .circular(24),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : AppColors.greenNormal,
                width: 1.5,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: .only(top: 8, right: 16),
            child: Align(
              alignment: .centerRight,
              child: Text(
                errorText!,
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ),
          ),
      ],
    );
  }
}
