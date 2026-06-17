import 'package:flutter/material.dart';
import '../models/motor_model.dart';
import 'form_sewa_screen.dart'; 

class DetailScreen extends StatefulWidget {
  final Motor motor;

  const DetailScreen({super.key, required this.motor});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Mengambil status favorit bawaan dari data
    isFavorite = widget.motor.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1015), // Background gelap sesuai gambar
      body: Stack(
        children: [
          // --- GAMBAR MOTOR (HERO ANIMATION) ---
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Hero(
                tag: widget.motor.name,
                child: Image.network(
                  widget.motor.image,
                  height: 280,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.motorcycle, size: 100, color: Colors.white24),
                ),
              ),
            ),
          ),

          // --- KONTEN DETAIL (SCROLLABLE) ---
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Ruang kosong transparan agar gambar motor di belakangnya terlihat
                SizedBox(height: size.height * 0.42),
                
                // Panel Putih melengkung
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul Motor
                      Text(
                        widget.motor.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Badge Kategori & Rating
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7A58E6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Matic',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            widget.motor.ratingStr,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            ' (100+ review)',
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Harga
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.motor.price,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF7A58E6),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 4, left: 4),
                            child: Text(
                              '/ hari',
                              style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Baris Spesifikasi (Tanpa Ikon)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSpecItem('125 cc', 'Mesin'),
                          _buildSpecItem('45 km/l', 'Irit BBM'),
                          _buildSpecItem('2', 'Helm'),
                          _buildSpecItem('Full', 'Service'),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Deskripsi
                      const Text(
                        'Deskripsi',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2D3142)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Motor matic yang nyaman dan irit bahan bakar, cocok untuk perjalanan dalam kota maupun luar kota. Dilengkapi dengan bagasi luas untuk menyimpan barang bawaan.',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.6),
                      ),
                      const SizedBox(height: 30),

                      // Fitur
                      const Text(
                        'Fitur',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF2D3142)),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFeatureItem(Icons.power_settings_new_rounded, 'Starter\nElektrik'),
                          _buildFeatureItem(Icons.vpn_key_outlined, 'Smart Key\nSystem'),
                          _buildFeatureItem(Icons.cases_outlined, 'Bagasi\nLuas'),
                          _buildFeatureItem(Icons.speed_rounded, 'Rem\nCBS'),
                        ],
                      ),
                      const SizedBox(height: 20), // Ekstra padding di bawah agar tidak mentok
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- APP BAR CUSTOM (Tombol Back & Favorit) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Back
                  _buildTopButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    color: const Color(0xFF2D3142),
                    onTap: () => Navigator.pop(context),
                  ),
                  // Tombol Favorite
                  _buildTopButton(
                    icon: isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: const Color(0xFF7A58E6),
                    onTap: () => setState(() => isFavorite = !isFavorite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // --- BOTTOM NAVIGATION (Sewa Sekarang) ---
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32), // Padding lebih besar di bawah untuk layar sentuh
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7A58E6), // Ungu Gen Z
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            // Navigasi ke form sewa
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormSewaScreen(motor: widget.motor), // Pastikan motor: widget.motor dipass jika FormSewa membutuhkannya
              ),
            );
          },
          child: const Text(
            'Sewa Sekarang',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.3),
          ),
        ),
      ),
    );
  }

  // Widget Helper: Tombol Bulat di Atas
  Widget _buildTopButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  // Widget Helper: Spesifikasi Motor (Teks atas besar, bawah kecil)
  Widget _buildSpecItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF2D3142)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // Widget Helper: Kotak Fitur dengan Ikon
  Widget _buildFeatureItem(IconData icon, String label) {
    return Container(
      width: 75,
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // Warna abu-abu sangat terang
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: const Color(0xFF2D3142)),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}