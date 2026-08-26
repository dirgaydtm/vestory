class CompanyInfo {
  final String name;
  final String logoUrl;
  final String description;

  const CompanyInfo(
    this.name,
    this.logoUrl, {
    this.description =
        'Perusahaan publik yang terdaftar di Bursa Efek Indonesia.',
  });
}

class StockConstants {
  static const Map<String, CompanyInfo> companyInfo = {
    'ADRO': CompanyInfo(
      'Adaro Energy',
      'assets/images/stocks/adro.png',
      description: 'PT Adaro Energy Indonesia Tbk adalah perusahaan tambang batu bara terbesar kedua di Indonesia. Grup Adaro beroperasi dalam pertambangan, logistik, daya, dan energi terbarukan.',
    ),
    'ANTM': CompanyInfo(
      'Aneka Tambang',
      'assets/images/stocks/antm.png',
      description: 'PT Aneka Tambang Tbk beroperasi di bidang pertambangan dan pengolahan mineral terintegrasi, mulai dari eksplorasi, penambangan, hingga pemurnian. ANTM memproduksi feronikel, emas, perak, dan bauksit.',
    ),
    'ASII': CompanyInfo(
      'Astra International',
      'assets/images/stocks/asii.png',
      description: 'PT Astra International Tbk didirikan di Jakarta pada tahun 1957 sebagai sebuah perusahaan perdagangan umum dengan nama Astra International Inc. Pada tahun 1990, telah dilakukan perubahan nama menjadi PT Astra International Tbk, dalam rangka penawaran umum perdana saham Perseroan kepada masyarakat.',
    ),
    'BBCA': CompanyInfo(
      'Bank Central Asia',
      'assets/images/stocks/bbca.png',
      description: 'PT Bank Central Asia Tbk merupakan salah satu bank swasta terbesar di Indonesia yang menyediakan berbagai layanan perbankan komersial dan personal, dengan fokus kuat pada transaksi perbankan dan perbankan digital.',
    ),
    'BBRI': CompanyInfo(
      'Bank Rakyat Indonesia',
      'assets/images/stocks/bbri.png',
      description: 'PT Bank Rakyat Indonesia (Persero) Tbk adalah salah satu bank milik pemerintah terbesar di Indonesia. BRI secara khusus memfokuskan layanannya pada sektor usaha mikro, kecil, dan menengah (UMKM).',
    ),
    'BMRI': CompanyInfo(
      'Bank Mandiri',
      'assets/images/stocks/bmri.webp',
      description: 'PT Bank Mandiri (Persero) Tbk adalah bank BUMN terbesar di Indonesia berdasarkan aset. Bank Mandiri melayani berbagai segmen korporasi, komersial, mikro, dan ritel.',
    ),
    'BUMI': CompanyInfo(
      'Bumi Resources',
      'assets/images/stocks/bumi.png',
      description: 'PT Bumi Resources Tbk adalah perusahaan induk dari beberapa perusahaan pertambangan batu bara di Indonesia, yang berfokus utamanya pada produksi batu bara termal.',
    ),
    'GOTO': CompanyInfo(
      'GoTo Gojek Tokopedia',
      'assets/images/stocks/goto.jpg',
      description: 'PT GoTo Gojek Tokopedia Tbk adalah ekosistem digital terbesar di Indonesia yang menyediakan layanan on-demand (mobilitas, pesan-antar makanan), e-commerce (Tokopedia), dan financial technology (GoPay).',
    ),
    'ICBP': CompanyInfo(
      'Indofood CBP',
      'assets/images/stocks/icbp.png',
      description: 'PT Indofood CBP Sukses Makmur Tbk merupakan salah satu produsen produk konsumen bermerek terkemuka di Indonesia, yang memproduksi mi instan, produk susu, makanan ringan, dan penyedap makanan.',
    ),
    'TLKM': CompanyInfo(
      'Telkom Indonesia',
      'assets/images/stocks/tlkm.png',
      description: 'PT Telkom Indonesia (Persero) Tbk adalah perusahaan informasi dan komunikasi serta penyedia jasa dan jaringan telekomunikasi secara lengkap di Indonesia.',
    ),
  };
}
