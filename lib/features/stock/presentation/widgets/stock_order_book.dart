import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';

class StockOrderBook extends StatelessWidget {
  final Stock stock;
  final Color accent;

  const StockOrderBook({super.key, required this.stock, required this.accent});

  @override
  Widget build(BuildContext context) {
    final cp = stock.currentPrice.toInt();
    final tick = cp < 200
        ? 1
        : cp < 500
        ? 2
        : cp < 2000
        ? 5
        : cp < 5000
        ? 10
        : 25;
    final seed = stock.ticker.codeUnits.reduce((a, b) => a + b);

    int tbLot = 0, tbFreq = 0, taLot = 0, taFreq = 0;
    final dataRows = List.generate(6, (i) {
      final bLot = (seed * (i + 1) * 11) % 50000;
      final bFreq = (seed * (i + 1) * 7) % 500;
      final aLot = (seed * (i + 2) * 13) % 50000;
      final aFreq = (seed * (i + 2) * 3) % 500;
      tbLot += bLot;
      tbFreq += bFreq;
      taLot += aLot;
      taFreq += aFreq;
      return _row(
        bFreq.toString(),
        (bLot / 1000).toStringAsFixed(3),
        '${cp - i * tick}',
        '${cp + (i + 1) * tick}',
        (aLot / 1000).toStringAsFixed(3),
        aFreq.toString(),
      );
    });

    return Container(
      decoration: BoxDecoration(
        border: .all(color: accent.withValues(alpha: 0.2)),
        color: AppColors.baseWhite,
      ),
      child: Table(
        border: .all(color: accent.withValues(alpha: 0.2)),
        children: [
          TableRow(
            decoration: BoxDecoration(color: AppColors.baseWhite),
            children: [
              'Freq',
              'Lot',
              'Bid',
              'Ask',
              'Lot',
              'Freq',
            ].map(_header).toList(),
          ),
          ...dataRows,
          TableRow(
            decoration: BoxDecoration(color: AppColors.baseWhite),
            children: [
              _header(tbFreq.toString()),
              _header((tbLot / 1000).toStringAsFixed(3)),
              _cell(''),
              _cell(''),
              _header((taLot / 1000).toStringAsFixed(3)),
              _header(taFreq.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _header(String t) => Padding(
    padding: .symmetric(vertical: 8, horizontal: 2),
    child: Text(
      t,
      textAlign: .center,
      style: TextStyle(fontSize: 12, fontWeight: .bold),
    ),
  );

  Widget _cell(String t) => Padding(
    padding: .symmetric(vertical: 8, horizontal: 2),
    child: Text(t, textAlign: .center, style: TextStyle(fontSize: 12)),
  );

  TableRow _row(
    String f1,
    String l1,
    String b,
    String a,
    String l2,
    String f2,
  ) => TableRow(children: [f1, l1, b, a, l2, f2].map(_cell).toList());
}
