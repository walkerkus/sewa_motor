import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'riwayat_screen.dart';
import 'pesan_screen.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'data_diri_screen.dart';
import 'poin_voucher_screen.dart';
import 'bantuan_screen.dart';
import 'tentang_aplikasi_screen.dart';
import 'pengaturan_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final int _selectedIndex = 3;

  bool _isLoading = true;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      setState(() => _isLoading = true);
      final data = await ApiService.getUser();
      setState(() {
        _user = UserModel.fromJson(data);
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6); // Ungu Gen Z
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- 1. BACKGROUND GRADIENT UNGU TUA ---
          Container(
            height: 320,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B42D1), Color(0xFF7A58E6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // --- 2. KONTEN UTAMA ---
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top Bar (Ikon Pengaturan)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PengaturanScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Profil Info (Foto, Nama, Email, Badge Premium)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      // Avatar Profile
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage: (_user?.avatar.isNotEmpty == true) ? NetworkImage(_user!.avatar) : null,
                          child: (_user?.avatar.isEmpty != false) ? const Icon(Icons.person_rounded, color: Colors.white, size: 40) : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Teks Profil
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user?.name ?? 'Memuat...',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _user?.email ?? '',
                              style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8)),
                            ),
                            const SizedBox(height: 10),
                            if (_user?.isPremium == true)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.stars_rounded, color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Premium Member',
                                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // --- 3. KOTAK PUTIH (STATS & MENU) ---
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Statistik (Total Booking, Rating, Poin)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatItem((_user?.totalBookings ?? 0).toString(), 'Total Booking', darkText),
                              _buildStatItem('${_user?.rating ?? 0}', 'Rating', darkText),
                              _buildStatItem('${_user?.points ?? 0}', 'Poin', darkText),
                            ],
                          ),
                        ),
                        
                        // Divider Halus
                        Container(
                          height: 8,
                          width: double.infinity,
                          color: const Color(0xFFFAFBFF), // Warna abu-abu sangat muda
                        ),

                        // List Menu
                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            children: [
                              _buildMenuItem(Icons.person_outline_rounded, 'Data Diri', darkText, onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const DataDiriScreen()),
                                );
                              }),
                              _buildMenuItem(Icons.card_giftcard_rounded, 'Poin & Voucher', darkText, onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const PoinVoucherScreen()),
                                  );
                                }),
                              _buildMenuItem(Icons.help_outline_rounded, 'Bantuan', darkText, onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const BantuanScreen()),
                                  );
                                }),
                              _buildMenuItem(Icons.info_outline_rounded, 'Tentang Aplikasi', darkText, onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TentangAplikasiScreen()),
                                  );
                                }),
                              _buildMenuItem(Icons.power_settings_new_rounded, 'Keluar', Colors.red, isDestructive: true, onTap: () {
                                // Contoh aksi logout
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil Keluar')));
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            _buildNavItem(0, Icons.home_rounded, 'Beranda', primaryPurple),
            _buildNavItem(1, Icons.calendar_month_rounded, 'Booking', primaryPurple), 
            _buildNavItem(2, Icons.chat_bubble_outline_rounded, 'Pesan', primaryPurple),
            _buildNavItem(3, Icons.person_rounded, 'Profil', primaryPurple), // Aktif
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: STATISTIK ---
  Widget _buildStatItem(String value, String label, Color darkText) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: darkText),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  // --- WIDGET HELPER: MENU ITEM ---
  Widget _buildMenuItem(IconData icon, String title, Color textColor, {bool isDestructive = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.red : const Color(0xFF2D3142), size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? Colors.red : textColor,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 24),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: BOTTOM NAV ITEM ---
  Widget _buildNavItem(int index, IconData icon, String label, Color primaryPurple) {
    bool isSelected = _selectedIndex == index; 
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Navigasi kembali ke Beranda (MainScreen)
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false,
          );
        } else if (index == 1) {
          // Navigasi ke RiwayatScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RiwayatScreen()),
          );
        } else if (index == 2) {
            // Navigasi ke PesanScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PesanScreen()),
            );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Buka halaman Pesan')));
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryPurple : Colors.grey.shade400,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? primaryPurple : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}