import 'package:flutter/material.dart';

class TentangAplikasiScreen extends StatelessWidget {
  const TentangAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);
    final Color lightBg = const Color(0xFFF4F6F9);

    return Scaffold(
      backgroundColor: lightBg,
      body: Stack(
        children: [
          // --- 1. BACKGROUND GRADIENT UNGU TUA ---
          Container(
            height: 240,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B42D1), Color(0xFF7A58E6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // --- 2. HEADER APP BAR ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    'Tentang Aplikasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 48), // Spacer agar teks di tengah
                ],
              ),
            ),
          ),

          // --- 3. KONTEN UTAMA (AREA PUTIH / ABU MUDA) ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 130), // Jarak jatuhnya kotak konten putih
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6F9), // Background abu-abu muda
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                // Jarak padding atas (top: 70) diberikan agar teks tidak menabrak logo yang melayang
                padding: const EdgeInsets.only(top: 70, bottom: 40, left: 24, right: 24),
                children: [
                  // --- INFO APLIKASI (Nama, Versi, Deskripsi) ---
                  Column(
                    children: [
                      Text(
                        'SewaMotor App',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Versi 1.0.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aplikasi penyewaan motor terbaik yang memberikan kemudahan, kecepatan, dan kenyamanan perjalanan Anda di berbagai kota.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // --- KELOMPOK INFORMASI LEGAL ---
                  _buildSectionTitle('Informasi Legal'),
                  _buildMenuCard(
                    children: [
                      _buildMenuRow(
                        icon: Icons.description_outlined, 
                        label: 'Syarat & Ketentuan', 
                        iconColor: primaryPurple, 
                        darkText: darkText,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SyaratKetentuanScreen()));
                        }
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.privacy_tip_outlined, 
                        label: 'Kebijakan Privasi', 
                        iconColor: primaryPurple, 
                        darkText: darkText, 
                        isLast: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const KebijakanPrivasiScreen()));
                        }
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // --- KELOMPOK LAINNYA ---
                  _buildSectionTitle('Lainnya'),
                  _buildMenuCard(
                    children: [
                      _buildMenuRow(
                        icon: Icons.star_outline_rounded, 
                        label: 'Beri Nilai Aplikasi', 
                        iconColor: Colors.amber, 
                        darkText: darkText,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menuju Play Store / App Store')));
                        }
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.language_rounded, 
                        label: 'Kunjungi Website Kami', 
                        iconColor: Colors.blue, 
                        darkText: darkText,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka Browser...')));
                        }
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.share_rounded, 
                        label: 'Bagikan Aplikasi', 
                        iconColor: Colors.green, 
                        darkText: darkText, 
                        isLast: true,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membagikan tautan aplikasi...')));
                        }
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // --- FOOTER COPYRIGHT ---
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          '© 2026 SewaMotor App',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dibuat dengan ❤️ di Indonesia',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 4. FLOATING APP ICON (Dikeluarkan dari ListView agar tidak terpotong) ---
          Positioned(
            top: 85, // Posisi pas di tengah antara background ungu dan konten putih
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: primaryPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(Icons.motorcycle_rounded, color: primaryPurple, size: 40),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade500,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildMenuCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuRow({required IconData icon, required String label, required Color iconColor, required Color darkText, bool isLast = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade100,
      ),
    );
  }
}

// ============================================================================
// HALAMAN SYARAT & KETENTUAN 
// ============================================================================

class SyaratKetentuanScreen extends StatelessWidget {
  const SyaratKetentuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color darkText = const Color(0xFF2D3142);

    final List<Map<String, String>> dummySyarat = [
      {
        "judul": "1. Persyaratan Pengguna",
        "isi": "Pengguna aplikasi minimal berusia 18 tahun, wajib memiliki KTP elektronik yang sah, dan Surat Izin Mengemudi (SIM C) aktif. Dokumen asli harus ditunjukkan saat serah terima kendaraan."
      },
      {
        "judul": "2. Penggunaan Kendaraan",
        "isi": "Motor hanya digunakan untuk keperluan transportasi normal di jalan raya. Dilarang keras menggunakan motor untuk balapan liar, off-road (kecuali motor khusus trail yang disewa), atau dipindahtangankan ke pihak ketiga tanpa izin tertulis dari pihak SewaMotor."
      },
      {
        "judul": "3. Kerusakan & Kehilangan",
        "isi": "Segala bentuk kerusakan (lecet, penyok, pecah) maupun kehilangan kendaraan yang terjadi selama masa sewa menjadi tanggung jawab penuh penyewa. Jika memilih paket asuransi premium, biaya pertanggungan akan disesuaikan dengan polis."
      },
      {
        "judul": "4. Keterlambatan Pengembalian",
        "isi": "Pengembalian motor yang melebihi batas waktu (toleransi 1 jam) akan dikenakan denda sebesar 15% dari tarif harian per jam keterlambatan."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A58E6),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Syarat & Ketentuan',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        itemCount: dummySyarat.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dummySyarat[index]['judul']!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
                ),
                const SizedBox(height: 8),
                Text(
                  dummySyarat[index]['isi']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.6),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// HALAMAN KEBIJAKAN PRIVASI 
// ============================================================================

class KebijakanPrivasiScreen extends StatelessWidget {
  const KebijakanPrivasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color darkText = const Color(0xFF2D3142);

    final List<Map<String, String>> dummyPrivasi = [
      {
        "judul": "1. Pengumpulan Data",
        "isi": "Kami mengumpulkan informasi pribadi Anda seperti Nama Lengkap, Alamat Email, Nomor Telepon, Foto KTP, dan Swafoto (Selfie) guna keperluan verifikasi akun dan keamanan penyewaan."
      },
      {
        "judul": "2. Pelacakan Lokasi (GPS)",
        "isi": "Semua unit kendaraan kami dilengkapi dengan pelacak GPS. Kami mencatat riwayat lokasi perjalanan selama masa sewa guna mencegah pencurian kendaraan dan memastikan keamanan bersama."
      },
      {
        "judul": "3. Penggunaan Informasi",
        "isi": "Data Anda digunakan semata-mata untuk memproses transaksi, mengirimkan notifikasi pemesanan, dan memberikan layanan pelanggan. Kami tidak akan menjual data Anda ke pihak ketiga untuk keperluan marketing tanpa persetujuan Anda."
      },
      {
        "judul": "4. Pengungkapan Data Hukum",
        "isi": "Kami berhak menyerahkan data pribadi dan rekam jejak GPS Anda kepada pihak berwenang (Kepolisian) jika ditemukan adanya indikasi pelanggaran hukum, kecelakaan lalu lintas berat, atau penggelapan unit motor."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A58E6),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        itemCount: dummyPrivasi.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dummyPrivasi[index]['judul']!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
                ),
                const SizedBox(height: 8),
                Text(
                  dummyPrivasi[index]['isi']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.6),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}