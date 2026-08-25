import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:vestory/core/database/app_database.dart';
import 'package:vestory/shared/data/models/stock_history_model.dart';
import 'package:vestory/shared/data/services/market_local_datasource.dart';
import 'package:vestory/shared/data/repositories/market_repository.dart';

// Mock Data Source that overrides JSON loading to use dummy data
class TestMarketDataSource extends MarketLocalDataSource {
  TestMarketDataSource(super.db);

  @override
  Future<Map<String, List<StockHistoryModel>>> loadJsonHistory() async {
    return {
      'ANTM.JK': [
        StockHistoryModel(
          date: DateTime(2025, 1, 1),
          open: 1000,
          high: 1100,
          low: 900,
          close: 1050,
          volume: 10000,
        ),
        StockHistoryModel(
          date: DateTime(2025, 1, 2),
          open: 1050,
          high: 1200,
          low: 1000,
          close: 1150,
          volume: 20000,
        ),
      ],
    };
  }
}

void main() {
  late AppDatabase db;
  late TestMarketDataSource dataSource;
  late MarketRepository repository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dataSource = TestMarketDataSource(db.marketDao);
    repository = MarketRepository(dataSource);

    // Seed initial user profile
    await db
        .into(db.userProfile)
        .insert(
          UserProfileCompanion.insert(
            name: 'Test User',
            playStyle: 'Aggressive',
            balance: const drift.Value(10000000.0), // $10m balance
            currentSimulationDate: drift.Value(DateTime(2025, 1, 1)),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'nextDay should advance simulation date and update stock prices',
    () async {
      await repository.init();

      // Initial check
      var user = await dataSource.getUserProfile();
      expect(user?.currentSimulationDate, DateTime(2025, 1, 1));

      // Execute Next Day
      await repository.nextDay();

      // Verify Date advanced
      user = await dataSource.getUserProfile();
      expect(user?.currentSimulationDate, DateTime(2025, 1, 2));

      // Verify Stock updated in DB
      final stock = await dataSource.getStock('ANTM.JK');
      expect(stock, isNotNull);
      expect(stock?.currentPrice, 1150); // Close price of 2025-01-02
    },
  );

  test('buyStock should deduct balance and add to portfolio', () async {
    await repository.init();
    await repository.nextDay(); // advance to 2025-01-02 where price is 1150

    // Buy 10 lots (1 lot = 100 shares)
    // 10 * 100 * 1150 = 1,150,000
    await repository.buyStock('ANTM.JK', 10);

    final user = await dataSource.getUserProfile();
    expect(user?.balance, 10000000.0 - 1150000.0);

    final portfolio = await dataSource.getPortfolio('ANTM.JK');
    expect(portfolio?.totalLots, 10);
    expect(portfolio?.averageBuyPrice, 1150);
  });

  test('sellStock should increase balance and reduce portfolio lots', () async {
    await repository.init();
    await repository.nextDay(); // Price is 1150

    // First, buy 10 lots
    await repository.buyStock('ANTM.JK', 10);

    // Then sell 5 lots
    // Revenue: 5 * 100 * 1150 = 575,000
    await repository.sellStock('ANTM.JK', 5);

    final user = await dataSource.getUserProfile();
    // 10000000 - 1150000 + 575000
    expect(user?.balance, 10000000.0 - 1150000.0 + 575000.0);

    final portfolio = await dataSource.getPortfolio('ANTM.JK');
    expect(portfolio?.totalLots, 5); // 10 - 5 = 5
  });

  test('buyStock should throw if insufficient balance', () async {
    await repository.init();
    await repository.nextDay(); // Price is 1150

    // Try to buy 100,000 lots (cost: 11.5 Billion, balance only 10 Million)
    expect(
      () async => await repository.buyStock('ANTM.JK', 100000),
      throwsException,
    );
  });

  test('sellStock should throw if not enough lots in portfolio', () async {
    await repository.init();
    await repository.nextDay(); // Price is 1150

    // Buy 5 lots
    await repository.buyStock('ANTM.JK', 5);

    // Try to sell 10 lots
    expect(
      () async => await repository.sellStock('ANTM.JK', 10),
      throwsException,
    );
  });

  test('buyStock twice should average out the buy price', () async {
    await repository.init();

    // Day 1: Price is 1050 (simulated by not calling nextDay, assuming default or mock provides it)
    // Wait, let's inject a specific price manually for testing average
    await dataSource.updateStockPrices([
      const StocksCompanion(
        ticker: drift.Value('ANTM.JK'),
        name: drift.Value('ANTM.JK'),
        currentPrice: drift.Value(1000.0),
        previousPrice: drift.Value(1000.0),
        volume: drift.Value(1000),
      ),
    ]);

    // Buy 10 lots at 1000
    await repository.buyStock('ANTM.JK', 10);

    // Change price to 2000
    await dataSource.updateStockPrices([
      const StocksCompanion(
        ticker: drift.Value('ANTM.JK'),
        name: drift.Value('ANTM.JK'),
        currentPrice: drift.Value(2000.0),
        previousPrice: drift.Value(2000.0),
        volume: drift.Value(1000),
      ),
    ]);

    // Buy 10 more lots at 2000
    await repository.buyStock('ANTM.JK', 10);

    // Average price should be 1500
    final portfolio = await dataSource.getPortfolio('ANTM.JK');
    expect(portfolio?.totalLots, 20);
    expect(portfolio?.averageBuyPrice, 1500.0);
  });

  test('getChartData should return only past data up to the limit', () async {
    await repository.init();
    await repository.nextDay(); // Moves to 2025-01-02

    // We should only see data up to 2025-01-02
    final chartData = await repository.getChartData('ANTM.JK', 30);

    expect(chartData.length, 2);
    expect(chartData.last.date, DateTime(2025, 1, 2));
  });
}
