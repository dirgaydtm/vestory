import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../../../shared/presentation/widgets/vestory_popup.dart';

class SimulationActions extends ConsumerWidget {
  const SimulationActions({super.key});

  void _showMaju1HariConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return VestoryPopup(
          content: Column(
            mainAxisSize: .min,
            children: [
              Text(
                'Apakah kamu yakin\ningin maju 1 hari?',
                textAlign: .center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Setelah dimajukan,\nperubahan tidak dapat\ndikembalikan',
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
            _executeMaju1Hari(context, ref);
          },
        );
      },
    );
  }

  void _executeMaju1Hari(BuildContext context, WidgetRef ref) {
    ref.read(marketRepositoryProvider).nextDay();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return VestoryPopup(
          content: Column(
            mainAxisSize: .min,
            children: [
              Text(
                'Perubahan\ndisimpan!',
                textAlign: .center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          confirmText: 'Baik',
          onConfirm: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        PrimaryButton(
          text: 'Maju 1 Hari',
          onPressed: () => _showMaju1HariConfirmation(context, ref),
        ),
        SizedBox(height: 12),
        Text(
          '*Tombol ini digunakan untuk melihat perkembangan saham anda dari hari-ke-hari.',
          style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
