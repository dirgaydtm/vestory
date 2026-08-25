import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../data/repositories/market_repository.dart';
import '../../data/services/market_local_datasource.dart';

final marketLocalDataSourceProvider = Provider<MarketLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return MarketLocalDataSource(db.marketDao);
});

final marketRepositoryProvider = Provider<MarketRepository>((ref) {
  final dataSource = ref.watch(marketLocalDataSourceProvider);
  final repo = MarketRepository(dataSource);
  repo.init();
  return repo;
});
