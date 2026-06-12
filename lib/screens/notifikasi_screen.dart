import 'package:flutter/material.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    // Data Dummy Notifikasi
    final List<Map<String, dynamic>> notifikasiList = [
      {
        'title': 'Pembayaran Berhasil',
        'body': 'Pesanan Honda Vario 125 untuk tanggal 20 Mei telah dikonfirmasi.',
        'time': '10:45 AM',
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF22C55E), // Hijau
      },
      {
        'title': 'Diskon Spesial!',
        'body': 'Dapatkan potongan 20% untuk sewa motor durasi 3 hari. Gunakan kode: HEMAT20.',
        'time': '09:00 AM',
        'icon': Icons.local_offer_rounded,
        'color': const Color(0xFFF59E0B), // Oranye
      },
      {
        'title': 'Reminder Pengembalian',
        'body': 'Jangan lupa, motor Yamaha NMAX harus dikembalikan hari ini sebelum pukul 14:00.',
        'time': 'Kemarin',
        'icon': Icons.alarm_rounded,
        'color': const Color(0xFFEF4444), // Merah
      },
      {
        'title': 'Update Sistem',
        'body': 'Aplikasi MotorKU telah diperbarui ke versi 2.0.1. Cek fitur terbaru kami!',
        'time': '2 Hari lalu',
        'icon': Icons.system_update_rounded,
        'color': const Color(0xFF64748B), // Abu
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifikasi',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Tandai Semua', style: TextStyle(color: primaryPurple, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        itemCount: notifikasiList.length,
        itemBuilder: (context, index) {
          final notif = notifikasiList[index];
          return _buildNotificationCard(
            title: notif['title'],
            body: notif['body'],
            time: notif['time'],
            icon: notif['icon'],
            color: notif['color'],
            darkText: darkText,
          );
        },
      ),
    );
  }

  // Widget Helper: Kartu Notifikasi
  Widget _buildNotificationCard({
    required String title,
    required String body,
    required String time,
    required IconData icon,
    required Color color,
    required Color darkText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}