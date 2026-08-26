import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';

class NotificationState extends Notifier<bool> {
  @override
  bool build() {
    return ref
            .read(sharedPreferencesProvider)
            .getBool('notifications_enabled') ??
        true;
  }

  void toggle(bool value) {
    state = value;
    ref.read(sharedPreferencesProvider).setBool('notifications_enabled', value);
  }
}

final notificationStateProvider = NotifierProvider<NotificationState, bool>(() {
  return NotificationState();
});
