import 'package:flutter/material.dart';
import 'konfirmasi_screen.dart'; // Menghubungkan ke halaman konfirmasi sukses

class QrisScreen extends StatelessWidget {
  final Map<String, String> motor;

  const QrisScreen({super.key, required this.motor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih bersih sesuai gambar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Form Pembayaran',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // --- KARTU QRIS ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1D63DC), width: 1), // Border biru tipis
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                      // Mockup Logo QRIS
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'QRIS',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, letterSpacing: -1),
                          ),
                          Text(
                            'QR Code Standar\nPembayaran Nasional',
                            style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      // Mockup Logo GPN
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(5)),
                        child: const Icon(Icons.flight_takeoff_rounded, color: Colors.red, size: 20), // Placeholder logo
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Nama Merchant & NMID
                  const Text(
                    'MotorKU',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'NMID: ID9360091100241059010',
                    style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  
                  // --- GAMBAR QR CODE (Bisa di-klik untuk simulasi sukses) ---
                  GestureDetector(
                    onTap: () {
                      // Simulasi jika QR berhasil discan, pindah ke layar Konfirmasi
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KonfirmasiScreen(motor: motor),
                        ),
                      );
                    },
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.qr_code_2_rounded, size: 200, color: Colors.black87),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  // Footer Card
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dicetak oleh: 936009110',
                        style: TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- TEKS STATUS ---
            const Text(
              'Menunggu Pembayaran.....',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D63DC),
              ),
            ),

            const SizedBox(height: 30),

            // --- TOMBOL BAGIKAN & DOWNLOAD ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        side: const BorderSide(color: Colors.black87, width: 1),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Bagikan',
                        style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF1D63DC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Download',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- TOMBOL BATALKAN ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: const BorderSide(color: Colors.black87, width: 1),
                ),
                onPressed: () {
                  // Kembali ke halaman sebelumnya
                  Navigator.pop(context);
                },
                child: const Text(
                  'Batalkan',
                  style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
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