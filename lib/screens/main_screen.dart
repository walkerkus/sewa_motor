import 'package:flutter/material.dart';
import 'detail_screen.dart'; // Sesuaikan dengan nama file kamu
import 'riwayat_screen.dart'; // Buka komentar ini jika file riwayat_screen.dart sudah siap

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  // Data Dummy Rekomendasi
  final List<Map<String, dynamic>> rekomendasiMotor = [
    {
      'name': 'Honda Vario 125',
      'price': 'Rp 85.000',
      'rating': '4.8',
      'image': 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      'isFavorite': false,
    },
    {
      'name': 'Yamaha NMAX 155',
      'price': 'Rp 110.000',
      'rating': '4.9',
      'image': 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      'isFavorite': true,
    },
  ];

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi bantuan untuk memunculkan pesan sementara
  void _showDummyMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- HEADER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hi, Reza 👋',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Mau kemana hari ini?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded, size: 28, color: Color(0xFF2D3142)),
                      onPressed: () {
                        // TODO: NAVIGASI KE HALAMAN NOTIFIKASI
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
                        _showDummyMessage('Buka halaman Notifikasi');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- SEARCH BAR ---
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'Cari motor atau lokasi...',
                            hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                            prefixIcon: Icon(Icons.search_rounded, color: Colors.black38),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7A58E6),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7A58E6).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune_rounded, color: Colors.white),
                        onPressed: () {
                          // TODO: MUNCULKAN BOTTOM SHEET FILTER ATAU HALAMAN PENCARIAN DETAIL
                          _showDummyMessage('Buka menu Filter');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // --- PROMO BANNER ---
                Container(
                  height: 210,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5B42D1), Color(0xFF8F6EFA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5B42D1).withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -50,
                        top: -50,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sewa Motor\nPraktis & Cepat',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Mulai dari',
                              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                            ),
                            const Text(
                              'Rp 75.000 / hari',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E1E2C),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                elevation: 0,
                              ),
                              onPressed: () {
                                // TODO: NAVIGASI KE HALAMAN PROMO / KATALOG DISKON
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const PromoScreen()));
                                _showDummyMessage('Buka promo spesial');
                              },
                              child: const Text('Sewa Sekarang', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/flutter-ui-challenges.appspot.com/o/scooter.png?alt=media',
                          width: 180,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(
                            width: 180,
                            height: 180,
                            child: Icon(Icons.motorcycle, size: 80, color: Colors.white54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Indikator titik (Dots)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(true),
                    _buildDot(false),
                    _buildDot(false),
                  ],
                ),
                const SizedBox(height: 30),

                // --- CATEGORIES ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryItem(Icons.grid_view_rounded, 'Semua\nMotor', true, () {
                      // TODO: NAVIGASI KE HALAMAN SEMUA MOTOR
                      _showDummyMessage('Kategori: Semua Motor');
                    }),
                    _buildCategoryItem(Icons.moped_rounded, 'Motor\nMatic', false, () {
                      // TODO: FILTER LIST HANYA MOTOR MATIC
                      _showDummyMessage('Kategori: Motor Matic');
                    }),
                    _buildCategoryItem(Icons.sports_motorsports_rounded, 'Motor\nSport', false, () {
                      // TODO: FILTER LIST HANYA MOTOR SPORT
                      _showDummyMessage('Kategori: Motor Sport');
                    }),
                    _buildCategoryItem(Icons.two_wheeler_rounded, 'Motor\nRetro', false, () {
                      // TODO: FILTER LIST HANYA MOTOR RETRO
                      _showDummyMessage('Kategori: Motor Retro');
                    }),
                    _buildCategoryItem(Icons.more_horiz_rounded, 'Lainnya', false, () {
                      // TODO: BUKA HALAMAN KATEGORI LAINNYA
                      _showDummyMessage('Kategori: Lainnya');
                    }),
                  ],
                ),
                const SizedBox(height: 36),

                // --- REKOMENDASI UNTUKMU ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Rekomendasi Untukmu',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: NAVIGASI KE HALAMAN KATALOG FULL MOTOR REKOMENDASI
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const AllRecommendationScreen()));
                        _showDummyMessage('Buka semua daftar rekomendasi');
                      },
                      child: Text(
                        'Lihat semua',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF7A58E6)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Horizontal List Cards (Sudah ada navigasi ke DetailScreen)
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: rekomendasiMotor.length,
                    itemBuilder: (context, index) {
                      final motor = rekomendasiMotor[index];
                      
                      return GestureDetector(
                        onTap: () {
                          // Navigasi ke DetailScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(motor: motor),
                            ),
                          );
                        },
                        child: Container(
                          width: 170,
                          margin: const EdgeInsets.only(right: 16, bottom: 10, top: 5),
                          padding: const EdgeInsets.all(12),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  motor['isFavorite'] ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                                  color: motor['isFavorite'] ? const Color(0xFF7A58E6) : Colors.grey.shade400,
                                  size: 22,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Hero(
                                    tag: motor['name'], 
                                    child: Image.network(
                                      motor['image'],
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.motorcycle, size: 50, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                motor['name'],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2D3142)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${motor['price']} / hari',
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    motor['rating'],
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home_rounded, 'Beranda'),
            _buildNavItem(1, Icons.calendar_month_rounded, 'Booking'),
            _buildNavItem(2, Icons.chat_bubble_outline_rounded, 'Pesan'),
            _buildNavItem(3, Icons.person_outline_rounded, 'Profil'),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk titik carousel
  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 8 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF7A58E6) : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  // Widget helper untuk menu kategori (Diperbarui dengan aksi onTap)
  Widget _buildCategoryItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFF3F0FF) : Colors.transparent,
              shape: BoxShape.circle,
              border: isActive ? null : Border.all(color: Colors.grey.shade200, width: 1.5),
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF7A58E6) : const Color(0xFF2D3142),
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? const Color(0xFF2D3142) : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk Bottom Navigation (Diperbarui dengan aksi pindah halaman)
  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Berada di Home, update state agar ikon menyala
          setState(() => _selectedIndex = 0);
        } else if (index == 1) {
          // TODO: NAVIGASI KE HALAMAN BOOKING / RIWAYAT TRANSAKSI
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RiwayatScreen()));
          _showDummyMessage('Pindah ke Halaman Riwayat');
        } else if (index == 2) {
          // TODO: NAVIGASI KE HALAMAN PESAN / INBOX KOTAK MASUK
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const PesanScreen()));
          _showDummyMessage('Pindah ke Halaman Pesan');
        } else if (index == 3) {
          // TODO: NAVIGASI KE HALAMAN PROFIL PENGGUNA
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilScreen()));
          _showDummyMessage('Pindah ke Halaman Profil');
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        color: Colors.transparent, // Menjamin seluruh area icon+teks bisa di-tap
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF7A58E6) : Colors.grey.shade400,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF7A58E6) : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}