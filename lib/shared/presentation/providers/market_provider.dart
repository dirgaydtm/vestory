import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../data/repositories/market_repository.dart';
import '../../data/services/market_local_datasource.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/stock_history_model.dart';

final marketLocalDataSourceProvider = Provider<MarketLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return MarketLocalDataSource(db.marketDao);
});

final marketRepositoryProvider = Provider<MarketRepository>((ref) {
  final dataSource = ref.watch(marketLocalDataSourceProvider);
  final userRepo = ref.watch(userRepositoryProvider);
  final repo = MarketRepository(dataSource, userRepo);
  repo.init();
  return repo;
});

final marketStocksProvider = StreamProvider((ref) async* {
  final repo = ref.watch(marketRepositoryProvider);
  await repo.init();
  yield* ref.watch(marketLocalDataSourceProvider).watchAllStocks();
});

final marketPortfoliosProvider = StreamProvider((ref) async* {
  yield* ref.watch(marketLocalDataSourceProvider).watchAllPortfolios();
});

final marketTransactionsProvider = StreamProvider((ref) async* {
  yield* ref.watch(marketLocalDataSourceProvider).watchAllTransactions();
});

final stockChartProvider =
    FutureProvider.family<List<StockHistoryModel>, String>((ref, ticker) async {
      final repo = ref.watch(marketRepositoryProvider);
      return repo.getChartData(ticker, 7);
    });

final stockDetailChartProvider =
    FutureProvider.family<List<StockHistoryModel>, String>((ref, ticker) async {
      final repo = ref.watch(marketRepositoryProvider);
      return repo.getChartData(ticker, 1000);
    });
