import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/preferences_provider.dart';
import '../../../../shared/presentation/widgets/vestory_switch.dart';
import 'section_title.dart';

class PreferencesSection extends ConsumerWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(notificationStateProvider);

    return Column(
      crossAxisAlignment: .start,
      children: [
        SectionTitle('Preferensi'),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'Notifikasi',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            VestorySwitch(
              value: notificationsEnabled,
              onChanged: (value) {
                ref.read(notificationStateProvider.notifier).toggle(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
