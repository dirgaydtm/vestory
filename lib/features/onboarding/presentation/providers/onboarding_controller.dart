import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/repositories/user_repository.dart';
import '../../../../shared/data/models/user_model.dart';

final onboardingControllerProvider =
    AsyncNotifierProvider.autoDispose<OnboardingController, void>(
      OnboardingController.new,
    );

class OnboardingController extends AutoDisposeAsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepositoryProvider);
  }

  Future<void> finishOnboarding(String name, String playStyle) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = UserModel(name: name, playStyle: playStyle);
      await _repository.saveUserProfile(user);
      await _repository.setOnboardingSeen();
    });
  }
}
