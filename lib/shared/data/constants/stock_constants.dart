class CompanyInfo {
  final String name;
  final String logoUrl;

  const CompanyInfo(this.name, this.logoUrl);
}

class StockConstants {
  static const Map<String, CompanyInfo> companyInfo = {
    'ADRO': CompanyInfo('Adaro Energy', 'assets/images/stocks/adro.png'),
    'ANTM': CompanyInfo('Aneka Tambang', 'assets/images/stocks/antm.png'),
    'ASII': CompanyInfo('Astra International', 'assets/images/stocks/asii.png'),
    'BBCA': CompanyInfo('Bank Central Asia', 'assets/images/stocks/bbca.png'),
    'BBRI': CompanyInfo(
      'Bank Rakyat Indonesia',
      'assets/images/stocks/bbri.png',
    ),
    'BMRI': CompanyInfo('Bank Mandiri', 'assets/images/stocks/bmri.webp'),
    'BUMI': CompanyInfo('Bumi Resources', 'assets/images/stocks/bumi.png'),
    'GOTO': CompanyInfo(
      'GoTo Gojek Tokopedia',
      'assets/images/stocks/goto.jpg',
    ),
    'ICBP': CompanyInfo('Indofood CBP', 'assets/images/stocks/icbp.png'),
    'TLKM': CompanyInfo('Telkom Indonesia', 'assets/images/stocks/tlkm.png'),
  };
}
