import '../../core/database/app_database.dart';
import '../../shared/data/constants/stock_constants.dart';

extension StockAnalytics on Stock {
  double get diff => currentPrice - previousPrice;
  double get percent => previousPrice == 0 ? 0 : (diff / previousPrice) * 100;
  bool get isPositive => diff >= 0;

  String get companyName => StockConstants.companyInfo[ticker]?.name ?? name;
  String get logoUrl => StockConstants.companyInfo[ticker]?.logoUrl ?? '';
}
