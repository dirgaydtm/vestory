import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/user_repository.dart';

final userProfileProvider = StreamProvider((ref) {
  return ref.watch(userRepositoryProvider).watchUserProfile();
});
