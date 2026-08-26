import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../../../shared/presentation/widgets/vestory_popup.dart';
import '../providers/settings_controller.dart';
import 'section_title.dart';

class DangerZone extends ConsumerWidget {
  const DangerZone({super.key});

  void _showResetDataConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return VestoryPopup(
          content: Column(
            mainAxisSize: .min,
            children: [
              Text(
                'Apakah kamu yakin\ningin mereset\ndata?',
                textAlign: .center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Keputusan tidak dapat\ndiubah lagi',
                textAlign: .center,
                style: TextStyle(fontSize: 16, color: AppColors.redNormal),
              ),
            ],
          ),
          confirmText: 'Kembali',
          onConfirm: () => Navigator.of(context).pop(),
          rejectText: 'Ya',
          rejectColor: AppColors.redNormal,
          onReject: () {
            Navigator.of(context).pop();
            _executeResetData(context, ref);
          },
        );
      },
    );
  }

  Future<void> _executeResetData(BuildContext context, WidgetRef ref) async {
    await ref.read(settingsControllerProvider).resetData();

    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return VestoryPopup(
          content: Column(
            mainAxisSize: .min,
            children: [
              Text(
                'Reset Akun berhasil\ndilakukan. Terima\nkasih!',
                textAlign: .center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          confirmText: 'Baik',
          onConfirm: () {
            Navigator.of(context).pop();
            context.go('/onboarding1');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SectionTitle('Zona Bahaya'),
        SizedBox(height: 16),
        PrimaryButton(
          text: 'Reset Data',
          color: AppColors.redNormal,
          onPressed: () => _showResetDataConfirmation(context, ref),
        ),
      ],
    );
  }
}
