import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class StyleSelectionCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const StyleSelectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: .new(milliseconds: 300),
        decoration: BoxDecoration(
          border: .all(
            color: isSelected
                ? AppColors.greenNormal
                : AppColors.neutralNormal.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: .circular(24),
        ),
        child: ClipRRect(
          borderRadius: .circular(24),
          child: Column(
            children: [
              Container(
                height: 120,
                width: .infinity,
                color: Colors.white,
                child: Image.asset(imagePath, fit: .cover),
              ),

              AnimatedContainer(
                duration: .new(milliseconds: 300),
                width: .infinity,
                padding: .all(16),
                color: isSelected
                    ? AppColors.greenNormal.withValues(alpha: 0.15)
                    : AppColors.neutralNormal.withValues(alpha: 0.1),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      textAlign: .center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
