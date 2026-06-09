import 'package:flutter/material.dart';
import 'tiket_screen.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan DefaultTabController untuk membuat fitur Tab (Aktif / Selesai)
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC), // Background abu-abu premium
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
            'Riwayat Sewa',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          // --- TAB BAR DI BAWAH APP BAR ---
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            tabs: [
              Tab(text: 'Aktif'),
              Tab(text: 'Selesai'),
            ],
          ),
        ),
        
        // --- ISI HALAMAN BERDASARKAN TAB ---
        body: TabBarView(
          children: [
            // Konten Tab 1: Aktif
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildRiwayatCard(
                  context,
                  namaMotor: 'Honda Beat',
                  tanggal: '6 Mei 2026 - 8 Mei 2026',
                  total: 'Rp 140.000',
                  imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=200',
                  statusText: 'Sedang Disewa',
                  statusColor: const Color(0xFF1D63DC), // Biru
                  isAktif: true,
                ),
              ],
            ),
            
            // Konten Tab 2: Selesai
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildRiwayatCard(
                  context,
                  namaMotor: 'Yamaha NMAX',
                  tanggal: '10 Apr 2026 - 12 Apr 2026',
                  total: 'Rp 240.000',
                  imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=200',
                  statusText: 'Selesai',
                  statusColor: const Color(0xFF4ade80), // Hijau
                  isAktif: false,
                ),
                _buildRiwayatCard(
                  context,
                  namaMotor: 'Honda Vario 125',
                  tanggal: '1 Mar 2026 - 2 Mar 2026',
                  total: 'Rp 90.000',
                  imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=200',
                  statusText: 'Selesai',
                  statusColor: const Color(0xFF4ade80), // Hijau
                  isAktif: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat Kartu Riwayat (Bisa dipakai berulang kali)
  Widget _buildRiwayatCard(
    BuildContext context, {
    required String namaMotor,
    required String tanggal,
    required String total,
    required String imageUrl,
    required String statusText,
    required Color statusColor,
    required bool isAktif,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Bagian Atas: Status dan Tanggal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tanggal,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: statusColor),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: Colors.black12, height: 1),
            ),
            
            // Bagian Tengah: Info Motor
            Row(
              children: [
                // Gambar Motor
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.motorcycle_rounded, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 15),
                // Teks Nama Motor & Total
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaMotor,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        total,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF1D63DC)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Bagian Bawah: Tombol Aksi (Hanya muncul jika sedang aktif)
            if (isAktif) ...[
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    side: const BorderSide(color: Color(0xFF1D63DC), width: 1.5),
                  ),
                  onPressed: () {
                        // Navigasi ke halaman E-Tiket dengan membawa data kartu yang diklik
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => TiketScreen(
                                namaMotor: namaMotor,
                                tanggal: tanggal,
                                imageUrl: imageUrl,
                            ),
                            ),
                        );
                        },
                  child: const Text(
                    'Lihat Tiket Sewa',
                    style: TextStyle(color: Color(0xFF1D63DC), fontSize: 13, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}