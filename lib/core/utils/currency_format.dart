extension CurrencyFormat on double {
  String toIdr({bool withPrefix = true}) {
    final formatted = toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
    return withPrefix ? 'Rp$formatted' : formatted;
  }
}
