import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/danger_zone.dart';
import '../widgets/preferences_section.dart';
import '../widgets/profile_section.dart';
import '../widgets/simulation_actions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .all(24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Setelan',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: .bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 24),
              ProfileSection(),
              SizedBox(height: 32),
              PreferencesSection(),
              SizedBox(height: 24),
              SimulationActions(),
              SizedBox(height: 24),
              Divider(color: AppColors.greenNormal, thickness: 1),
              SizedBox(height: 8),
              Divider(color: AppColors.greenNormal, thickness: 1),
              SizedBox(height: 24),
              DangerZone(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
