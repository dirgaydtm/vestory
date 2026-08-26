import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'primary_button.dart';

class VestoryPopup extends StatelessWidget {
  final Widget content;
  final String confirmText;
  final VoidCallback onConfirm;
  final String? rejectText;
  final VoidCallback? onReject;
  final Color? rejectColor;

  const VestoryPopup({
    super.key,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
    this.rejectText,
    this.onReject,
    this.rejectColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: .circular(24)),
      backgroundColor: AppColors.greenLight,
      child: Padding(
        padding: .all(24.0),
        child: Column(
          mainAxisSize: .min,
          children: [
            content,
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(text: confirmText, onPressed: onConfirm),
                ),
                if (rejectText != null && onReject != null) ...[
                  SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      text: rejectText!,
                      onPressed: onReject!,
                      color: rejectColor ?? AppColors.redNormal,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
