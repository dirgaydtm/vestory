import '../../core/database/app_database.dart';
import '../../shared/data/constants/stock_constants.dart';

extension StockAnalytics on Stock {
  double get diff => currentPrice - previousPrice;
  double get percent => previousPrice == 0 ? 0 : (diff / previousPrice) * 100;
  bool get isPositive => diff >= 0;

  String get companyName => StockConstants.companyInfo[ticker]?.name ?? name;
  String get logoUrl => StockConstants.companyInfo[ticker]?.logoUrl ?? '';
  String get companyDescription =>
      StockConstants.companyInfo[ticker]?.description ?? '';

  double _getLimitPercentage() {
    if (currentPrice < 200) {
      return 0.35;
    }
    if (currentPrice < 5000) {
      return 0.25;
    }
    return 0.20;
  }

  int getNextPrice(int inputPrice) {
    double limit = _getLimitPercentage();
    int maxPrice = (currentPrice * (1 + limit)).floor();

    if (inputPrice >= maxPrice) return maxPrice;

    int next;
    if (inputPrice < 200) {
      next = inputPrice + 1;
    } else if (inputPrice < 500) {
      next = inputPrice + 2;
    } else if (inputPrice < 2000) {
      next = inputPrice + 5;
    } else if (inputPrice < 5000) {
      next = inputPrice + 10;
    } else {
      next = inputPrice + 25;
    }

    return next > maxPrice ? maxPrice : next;
  }

  int getPreviousPrice(int inputPrice) {
    double limit = _getLimitPercentage();
    int minPrice = (currentPrice * (1 - limit)).ceil();
    if (minPrice < 50) minPrice = 50;

    if (inputPrice <= minPrice) return minPrice;

    int prev;
    if (inputPrice <= 200) {
      prev = inputPrice - 1;
    } else if (inputPrice <= 500) {
      prev = inputPrice - 2;
    } else if (inputPrice <= 2000) {
      prev = inputPrice - 5;
    } else if (inputPrice <= 5000) {
      prev = inputPrice - 10;
    } else {
      prev = inputPrice - 25;
    }

    return prev < minPrice ? minPrice : prev;
  }
}
