import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/widgets/stock_list_tile.dart';
import '../providers/search_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final isSearching = ref.watch(isSearchingProvider);
    final results = ref.watch(searchResultsProvider);
    final history = ref.watch(searchHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.greenNormal,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: .only(left: 24, right: 24, top: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Padding(
                      padding: .only(right: 12),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.baseWhite,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.baseWhite,
                        borderRadius: .circular(32),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Cari Saham',
                          hintStyle: TextStyle(
                            color: AppColors.neutralDark,
                            fontSize: 16,
                          ),
                          border: .none,
                          contentPadding: .symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          suffixIcon: Padding(
                            padding: .only(right: 8),
                            child: Icon(
                              Icons.search,
                              color: AppColors.baseBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              query.isEmpty || isSearching
                  ? 'Mau cari apa hari ini?'
                  : 'Hasil penelusuran: ${results.length}',
              style: TextStyle(
                color: AppColors.baseWhite,
                fontSize: 16,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.baseWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: .circular(32),
                    topRight: .circular(32),
                  ),
                ),
                padding: .only(top: 24, left: 24, right: 24),
                child: _buildContent(
                  query,
                  isSearching,
                  results,
                  history,
                  context,
                  ref,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    String query,
    bool isSearching,
    List<dynamic> results,
    List<String> history,
    BuildContext context,
    WidgetRef ref,
  ) {
    if (query.isEmpty) {
      if (history.isEmpty) {
        return Center(
          child: Text(
            'Belum ada riwayat pencarian',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        );
      }
      return ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final h = history[index];
          return ListTile(
            leading: Icon(Icons.history, color: AppColors.textPrimary),
            title: Text(
              h,
              style: TextStyle(fontWeight: .w600, color: AppColors.textPrimary),
            ),
            onTap: () {
              _searchController.text = h;
            },
          );
        },
      );
    }

    if (isSearching) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(),
                SizedBox(width: 8),
                _buildDot(),
                SizedBox(width: 8),
                _buildDot(),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Melakukan pencarian...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: .w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/search/empty.png', width: 250),
            SizedBox(height: 24),
            Text(
              'Maaf, aset/saham yang kamu\ncari belum tersedia nih...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: .w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final stock = results[index];
        return InkWell(
          onTap: () {
            ref.read(searchHistoryProvider.notifier).addHistory(stock.ticker);
            context.push('/stock/${stock.ticker}');
          },
          child: IgnorePointer(child: StockListTile(stock: stock)),
        );
      },
    );
  }

  Widget _buildDot() => Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
      color: AppColors.greenLight,
      shape: BoxShape.circle,
    ),
  );
}
