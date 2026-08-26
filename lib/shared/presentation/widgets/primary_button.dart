import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color? color;
  final bool isOutlined;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = .infinity,
    this.height = 50,
    this.color,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      final effectiveColor = color ?? AppColors.greenNormal;
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: effectiveColor, width: 2),
            shape: RoundedRectangleBorder(borderRadius: .circular(28)),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w600,
              color: effectiveColor,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.greenNormal,
          shape: RoundedRectangleBorder(borderRadius: .circular(28)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: .w600,
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }
}
