import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/models/stock_history_model.dart';

final chartRangeProvider = StateProvider.autoDispose<String>((ref) => '1W');

List<StockHistoryModel> sliceHistory(
  List<StockHistoryModel> history,
  String selectedRange,
) {
  if (history.isEmpty) return [];

  int takeCount = history.length;
  switch (selectedRange) {
    case '1D':
      takeCount = 2;
      break;
    case '1W':
      takeCount = 7;
      break;
    case '1M':
      takeCount = 30;
      break;
    case '3M':
      takeCount = 90;
      break;
    case 'ALL':
    default:
      takeCount = history.length;
  }

  if (takeCount > history.length) takeCount = history.length;
  return history.sublist(history.length - takeCount);
}
