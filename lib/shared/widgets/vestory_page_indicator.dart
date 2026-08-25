import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class VestoryPageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const VestoryPageIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Row(
        mainAxisAlignment: .center,
        children: List.generate(
          itemCount,
          (index) => _buildDot(active: index == currentIndex),
        ),
      ),
    );
  }

  Widget _buildDot({required bool active}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: .symmetric(horizontal: 4),
      width: active ? 16 : 16,
      height: active ? 16 : 10,
      decoration: BoxDecoration(
        color: active
            ? AppColors.greenNormal
            : AppColors.neutralNormal.withValues(alpha: 0.5),
        borderRadius: active ? .circular(99) : .circular(4),
      ),
    );
  }
}
