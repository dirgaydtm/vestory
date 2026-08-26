import '../../domain/models/mission_model.dart';

class AppMissions {
  static const List<MissionModel> missions = [
    MissionModel(
      id: 'm1',
      title: 'Raih Investasi sebanyak Rp1.000.000',
      description: 'Lakukan trading atau jual saham hingga mendapatkan 1 juta virtual money profit.',
      type: MissionType.targetProfit,
      targetValue: 1000000.0,
      rewardMoney: 1000000.0,
      achievementName: 'Belajar dari Awal Dulu',
      feedback: 'Langkah pertama yang bagus! Terus kembangkan strategimu.',
    ),
    MissionModel(
      id: 'm2',
      title: 'Raih 10 juta total investasi',
      description: 'Lakukan trading atau jual saham hingga mendapatkan 10 juta virtual money.',
      type: MissionType.targetTotalEquity,
      targetValue: 10000000.0,
      rewardMoney: 1000000.0,
      achievementName: 'Sang Investor Handal',
      feedback: 'Keberhasilan kamu memanfaatkan momentum pergerakan harga pasar saat jual/beli saham membuktikan kamu sudah mulai memahami timing transaksi yang tepat. Kamu tidak hanya asal mengeksekusi order, tapi mampu mengelola modal virtual hingga menyentuh target Rp10.000.000.',
    ),
    MissionModel(
      id: 'm3',
      title: 'Beli saham ANTM 1 kali',
      description: 'Masuk ke Stok Market dan cari saham ANTM, kemudian beli 1 kali (jumlah lot dan harga bebas).',
      type: MissionType.buySpecificStock,
      targetValue: 1.0,
      targetTicker: 'ANTM',
      rewardMoney: 1000000.0,
      achievementName: 'Aku Suka Emas!',
      feedback: 'Kamu berhasil membeli saham ANTM. Emas selalu jadi primadona!',
    ),
  ];
}
