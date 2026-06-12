import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/motor_model.dart';
import 'konfirmasi_screen.dart'; // Buka komentar ini jika file sudah siap

class QrisScreen extends StatelessWidget {
  final Motor motor;

  const QrisScreen({super.key, required this.motor});

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
    int totalHarga = _getHargaMotor() * 2; // Asumsi 2 hari sewa seperti form sebelumnya
    
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF), // Background terang seragam
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pembayaran QRIS',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // --- KARTU QRIS ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header Card (Logo QRIS & GPN Dummy)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'QRIS',
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, letterSpacing: -1, color: Color(0xFFE11D48)), // Warna merah khas QRIS
                          ),
                          Text(
                            'QR Code Standar\nPembayaran Nasional',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF1D4ED8), size: 22), 
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Nama Merchant & Total Bayar (Data Nyambung)
                  Text(
                    'MotorKU Rent',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: darkText),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NMID: ID9360091100241059010',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  
                  // Total Harga
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: primaryPurple.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text('Total Pembayaran', style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text(
                          _formatCurrency(totalHarga),
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: primaryPurple),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // --- GAMBAR QR CODE ---
                  GestureDetector(
                    onTap: () {
                      // Simulasi Pindah ke layar Konfirmasi (Pastikan KonfirmasiScreen juga memakai Map<String, dynamic>)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KonfirmasiScreen(motor: motor),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulasi QR Berhasil discan!')),
                      );
                    },
                    child: Container(
                      width: 220,
                      height: 220,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      // Menggunakan icon sebagai placeholder QR Code
                      child: Icon(Icons.qr_code_2_rounded, size: 190, color: darkText),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Footer Card
                  Text(
                    'Dicetak oleh: 936009110',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade400, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            // --- TEKS STATUS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16, 
                  height: 16, 
                  child: CircularProgressIndicator(strokeWidth: 2.5, color: primaryPurple)
                ),
                const SizedBox(width: 12),
                Text(
                  'Menunggu Pembayaran...',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryPurple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 36),

            // --- TOMBOL BAGIKAN & DOWNLOAD ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                        foregroundColor: darkText,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Bagikan',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: primaryPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Download',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- TOMBOL BATALKAN ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  foregroundColor: Colors.red.shade400,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Batalkan Pesanan',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}