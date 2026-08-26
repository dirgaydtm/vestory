import 'package:flutter/cupertino.dart';

import '../../../core/theme/app_colors.dart';

class VestorySwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const VestorySwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: AppColors.greenLightActive,
      inactiveTrackColor: AppColors.neutralNormal,
      thumbColor: value ? AppColors.greenDark : AppColors.baseWhite,
    );
  }
}
