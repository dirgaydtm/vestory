import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/mission/presentation/pages/mission_page.dart';
import '../../features/more/presentation/pages/more_page.dart';
import '../../features/notification/presentation/pages/notification_page.dart';
import '../../features/onboarding/presentation/pages/onboarding1_page.dart';
import '../../features/onboarding/presentation/pages/onboarding2_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/stock/presentation/pages/stock_buy_page.dart';
import '../../features/stock/presentation/pages/stock_detail_page.dart';
import '../../features/stock/presentation/pages/stock_sell_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/onboarding1',
      builder: (context, state) => Onboarding1Page(),
    ),
    GoRoute(
      path: '/onboarding2',
      builder: (context, state) => Onboarding2Page(),
    ),
    GoRoute(path: '/search', builder: (context, state) => SearchPage()),
    GoRoute(path: '/portfolio', builder: (context, state) => PortfolioPage()),
    GoRoute(path: '/more', builder: (context, state) => MorePage()),
    GoRoute(
      path: '/stock/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return StockDetailPage(id: id);
      },
    ),
    GoRoute(
      path: '/stock/:id/buy',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return StockBuyPage(id: id);
      },
    ),
    GoRoute(
      path: '/stock/:id/sell',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return StockSellPage(id: id);
      },
    ),
    GoRoute(path: '/mission', builder: (context, state) => MissionPage()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsPage()),
    GoRoute(
      path: '/notification',
      builder: (context, state) => NotificationPage(),
    ),
  ],
);
