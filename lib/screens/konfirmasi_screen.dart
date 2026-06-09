import 'package:flutter/material.dart';
import 'main_screen.dart'; // Penting untuk fungsi "Kembali Ke Home"
import 'riwayat_screen.dart';

class KonfirmasiScreen extends StatelessWidget {
  final Map<String, String> motor;

  const KonfirmasiScreen({super.key, required this.motor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false, // Menghilangkan tombol back bawaan
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF154DB3), Color(0xFF1D63DC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
          onPressed: () {
            // Arahkan ke Home dan hapus tumpukan layar sebelumnya
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: const Text(
          'Konfirmasi',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            // --- IKON SUKSES & CONFETTI ---
            SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Potongan Confetti (Animasi Statis)
                  _buildConfetti(top: 10, left: 60, angle: -0.2, color: Colors.cyan.shade400),
                  _buildConfetti(top: 30, right: 30, angle: 0.5, color: Colors.cyan.shade400),
                  _buildConfetti(bottom: 40, left: 20, angle: 0.8, color: Colors.cyan.shade400),
                  _buildConfetti(top: 60, left: 10, angle: -0.6, color: Colors.pinkAccent),
                  _buildConfetti(bottom: 20, right: 50, angle: -0.3, color: Colors.pinkAccent),
                  _buildConfetti(top: 80, right: 10, angle: 0.3, color: Colors.cyan.shade400),
                  
                  // Lingkaran Centang Hijau
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4ade80), // Hijau terang
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- TEKS STATUS BERHASIL ---
            const Text(
              'Sewa Berhasil',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Terima kasih, Penyewaan Motor\nberhasil dilakukan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- KARTU DETAIL PENYEWAAN ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Penyewaan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  
                  // Info Motor
                  Row(
                    children: [
                      Image.network(
                        motor['image']!, // DIUBAH: Dihilangkan kata 'widget.'
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.motorcycle_rounded, size: 60, color: Colors.grey),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        motor['name']!, // DIUBAH: Dihilangkan kata 'widget.'
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Baris Detail Data
                  _buildDetailRow('Nama Penyewa', 'Budi Lestari'),
                  _buildDetailRow('Tanggal Sewa', '6 Mei 2026'),
                  _buildDetailRow('Lama Sewa', '2 hari'),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: Colors.black12, thickness: 1),
                  ),
                  
                  // Total Pembayaran
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Pembayaran', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w700)),
                      Text(
                        'Rp 140.000', 
                        style: TextStyle(color: const Color(0xFF1D63DC), fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // --- AREA TOMBOL BAWAH ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        color: const Color(0xFFF8FAFC),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol Kembali ke Home
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D63DC),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                onPressed: () {
                  // Kembali ke halaman awal dan hapus semua history layar sebelumnya
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text(
                  'Kembali Ke Home',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Tombol Riwayat Sewa
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Navigasi ke halaman Riwayat Sewa
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RiwayatScreen()),
                  );
                },
                child: const Text(
                  'Lihat Riwayat Sewa',
                  style: TextStyle(color: Color(0xFF1D63DC), fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat baris detail
  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
            ],
          ),
        ),
        const Divider(color: Colors.black26, height: 1, thickness: 0.5),
      ],
    );
  }

  // Helper untuk membuat elemen visual confetti
  Widget _buildConfetti({double? top, double? bottom, double? left, double? right, required double angle, required Color color}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: 12,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}