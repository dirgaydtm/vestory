import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../core/database/app_database.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final debouncedQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final isSearchingProvider = Provider.autoDispose<bool>(
  (ref) => ref.watch(searchQueryProvider) != ref.watch(debouncedQueryProvider),
);

final debouncerProvider = Provider.autoDispose((ref) {
  final query = ref.watch(searchQueryProvider);
  final timer = Timer(
    Duration(milliseconds: 500),
    () => ref.read(debouncedQueryProvider.notifier).state = query,
  );
  ref.onDispose(timer.cancel);
});

class SearchHistoryNotifier extends Notifier<List<String>> {
  static const _historyKey = 'search_history';

  @override
  List<String> build() {
    final json = ref.watch(sharedPreferencesProvider).getString(_historyKey);
    if (json == null) return [];
    try {
      return (jsonDecode(json) as List).map((e) => e.toString()).toList();
    } catch (_) {
      return [];
    }
  }

  void addHistory(String query) {
    if (query.trim().isEmpty) return;
    state = [query, ...state.where((e) => e != query)].take(5).toList();
    ref
        .read(sharedPreferencesProvider)
        .setString(_historyKey, jsonEncode(state));
  }
}

final searchHistoryProvider =
    NotifierProvider<SearchHistoryNotifier, List<String>>(
      SearchHistoryNotifier.new,
    );

final searchResultsProvider = Provider.autoDispose<List<Stock>>((ref) {
  ref.watch(debouncerProvider);
  final query = ref.watch(debouncedQueryProvider).toLowerCase();
  if (query.isEmpty) return [];

  final stocks = ref.watch(marketStocksProvider).valueOrNull ?? [];
  return stocks
      .where(
        (s) =>
            s.ticker.toLowerCase().contains(query) ||
            s.name.toLowerCase().contains(query),
      )
      .toList();
});
