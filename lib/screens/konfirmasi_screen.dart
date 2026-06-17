import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/motor_model.dart';
import 'main_screen.dart'; 
import 'riwayat_screen.dart'; // Buka komentar ini jika file riwayat_screen.dart sudah siap

class KonfirmasiScreen extends StatelessWidget {
  final Motor motor;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final int totalPrice;
  final String paymentMethod;

  const KonfirmasiScreen({
    super.key, 
    required this.motor,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.totalPrice,
    required this.paymentMethod,
  });

  // Fungsi untuk mengambil angka harga
  int _getHargaMotor() {
    String priceStr = motor.price;
    String numericOnly = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numericOnly) ?? 0;
  }

  // Format currency ke Rupiah
  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    String startDateFormatted = DateFormat('dd MMM yyyy', 'id_ID').format(startDate);
    String endDateFormatted = DateFormat('dd MMM yyyy', 'id_ID').format(endDate);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF), // Background terang
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFAFBFF),
        centerTitle: true,
        automaticallyImplyLeading: false, // Menghilangkan tombol back bawaan
        title: Text(
          'Transaksi Berhasil',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // --- IKON SUKSES & CONFETTI ---
            SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Potongan Confetti disesuaikan dengan tema warna aplikasi
                  _buildConfetti(top: 10, left: 60, angle: -0.2, color: primaryPurple.withOpacity(0.6)),
                  _buildConfetti(top: 30, right: 30, angle: 0.5, color: Colors.blue.shade300),
                  _buildConfetti(bottom: 40, left: 20, angle: 0.8, color: Colors.blue.shade400),
                  _buildConfetti(top: 60, left: 10, angle: -0.6, color: primaryPurple),
                  _buildConfetti(bottom: 20, right: 50, angle: -0.3, color: primaryPurple.withOpacity(0.8)),
                  _buildConfetti(top: 80, right: 10, angle: 0.3, color: Colors.cyan.shade400),
                  
                  // Lingkaran Centang Hijau Modern
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E), // Hijau cerah sukses
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF22C55E).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 50),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- TEKS STATUS BERHASIL ---
            Text(
              'Sewa Berhasil!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: darkText,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Terima kasih, pembayaran telah diterima.\nMotor siap diambil sesuai jadwal.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 36),

            // --- KARTU DETAIL PENYEWAAN ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Pesanan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
                  ),
                  const SizedBox(height: 20),
                  
                  // Info Motor
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F0FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          motor.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.motorcycle_rounded, size: 30, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              motor.name,
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkText),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              motor.price,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.black12, height: 1, thickness: 1),
                  const SizedBox(height: 10),
                  
                  // Baris Detail Data
                  _buildDetailRow('Tanggal Sewa', '$startDateFormatted - $endDateFormatted', darkText),
                  _buildDetailRow('Lama Sewa', '$durationDays Hari', darkText),
                  _buildDetailRow('Metode Bayar', paymentMethod, darkText),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: Colors.black12, thickness: 1),
                  ),
                  
                  // Total Pembayaran
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Pembayaran', style: TextStyle(color: darkText, fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(
                        _formatCurrency(totalPrice), 
                        style: TextStyle(color: primaryPurple, fontSize: 18, fontWeight: FontWeight.w900),
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
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        color: const Color(0xFFFAFBFF),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol Kembali ke Home
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  'Kembali ke Beranda',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Tombol Riwayat Sewa
            SizedBox(
              width: double.infinity,
              height: 54,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  foregroundColor: primaryPurple,
                ),
                onPressed: () {
                  // Navigasi ke halaman Riwayat Sewa
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RiwayatScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buka halaman Riwayat')),
                  );
                },
                child: const Text(
                  'Lihat Riwayat Pesanan',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat baris detail
  Widget _buildDetailRow(String label, String value, Color darkText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: darkText)),
        ],
      ),
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
          width: 10,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}