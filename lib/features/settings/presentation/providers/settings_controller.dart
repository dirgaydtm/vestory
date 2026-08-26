import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/debouncer.dart';
import '../../../../shared/data/repositories/system_repository.dart';
import '../../../../shared/data/repositories/user_repository.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/providers/user_provider.dart';

final settingsControllerProvider = Provider<SettingsController>((ref) {
  return SettingsController(ref);
});

class SettingsController {
  final Ref _ref;
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  SettingsController(this._ref);

  void updateProfileDebounced({String? name, String? playStyle}) {
    _debouncer.run(() async {
      final user = _ref.read(userProfileProvider).value;
      if (user == null) return;

      final updatedUser = user.copyWith(name: name, playStyle: playStyle);
      await _ref.read(userRepositoryProvider).saveUserProfile(updatedUser);
    });
  }

  Future<void> resetData() async {
    await _ref.read(systemRepositoryProvider).resetAllData();

    _ref.invalidate(marketRepositoryProvider);
    _ref.invalidate(marketStocksProvider);
    _ref.invalidate(marketPortfoliosProvider);
    _ref.invalidate(userProfileProvider);
  }
}
