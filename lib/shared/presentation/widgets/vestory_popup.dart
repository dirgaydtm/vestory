import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'primary_button.dart';

class VestoryPopup extends StatelessWidget {
  final Widget content;
  final String confirmText;
  final VoidCallback onConfirm;
  final String? rejectText;
  final VoidCallback? onReject;

  const VestoryPopup({
    super.key,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
    this.rejectText,
    this.onReject,
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
                if (rejectText != null && onReject != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.greenNormal,
                        side: BorderSide(
                          color: AppColors.greenNormal,
                          width: 2,
                        ),
                        padding: .symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(24),
                        ),
                      ),
                      child: Text(
                        rejectText!,
                        style: TextStyle(fontSize: 16, fontWeight: .bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
                Expanded(
                  child: PrimaryButton(text: confirmText, onPressed: onConfirm),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
