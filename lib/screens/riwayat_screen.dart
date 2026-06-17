import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../services/api_service.dart';
import 'main_screen.dart';
import 'tiket_screen.dart';
import 'profil_screen.dart';
import 'pesan_screen.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  final int _selectedIndex = 1; 
  String _selectedTab = 'Aktif'; 
  final List<String> _tabs = ['Semua', 'Aktif', 'Selesai', 'Dibatalkan'];

  bool _isLoading = true;
  List<Booking> _allBookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      setState(() => _isLoading = true);
      final data = await ApiService.getBookings();
      setState(() {
        _allBookings = data.map((e) => Booking.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF), // Background terang Gen Z
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
          onPressed: () {
            // Kembali ke Home
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: Text(
          'Booking Saya',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- PILL TABS (Semua, Aktif, Selesai, Dibatalkan) ---
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              children: _tabs.map((tab) {
                bool isSelected = _selectedTab == tab;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = tab;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryPurple : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? primaryPurple : Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: isSelected 
                          ? [BoxShadow(color: primaryPurple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] 
                          : [],
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // --- LIST KONTEN BOOKING ---
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
                : RefreshIndicator(
                    color: primaryPurple,
                    onRefresh: _loadBookings,
                    child: Builder(
                      builder: (context) {
                        List<Booking> filteredBookings = _allBookings;
                        if (_selectedTab != 'Semua') {
                          filteredBookings = filteredBookings.where((b) => b.status == _selectedTab).toList();
                        }

                        if (filteredBookings.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                'Tidak ada pesanan.',
                                style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          itemCount: filteredBookings.length,
                          itemBuilder: (context, index) {
                            final booking = filteredBookings[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 0 || filteredBookings[index - 1].status != booking.status) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    margin: EdgeInsets.only(bottom: 12, top: index == 0 ? 0.0 : 20.0),
                                    decoration: BoxDecoration(
                                      color: booking.status == 'Aktif' ? primaryPurple.withOpacity(0.1) : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      booking.status,
                                      style: TextStyle(
                                        fontSize: 13, 
                                        fontWeight: FontWeight.bold, 
                                        color: booking.status == 'Aktif' ? primaryPurple : Colors.grey.shade700
                                      ),
                                    ),
                                  ),
                                ],
                                _buildBookingCard(
                                  booking: booking,
                                  primaryPurple: primaryPurple,
                                  darkText: darkText,
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        );
                      },
                    ),
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
            _buildNavItem(0, Icons.home_rounded, 'Beranda'),
            _buildNavItem(1, Icons.calendar_month_rounded, 'Booking'), // Ini yang akan menyala
            _buildNavItem(2, Icons.chat_bubble_outline_rounded, 'Pesan'),
            _buildNavItem(3, Icons.person_outline_rounded, 'Profil'),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: KARTU BOOKING ---
  Widget _buildBookingCard({
    required Booking booking,
    required Color primaryPurple,
    required Color darkText,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Area Gambar Motor (Kiri)
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC), // Latar belakang abu sangat terang
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.network(
              booking.motor.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.motorcycle, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          // Area Teks & Tombol (Kanan)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  booking.motor.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${booking.startDate} - ${booking.endDate}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Text(
                  booking.price,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: darkText),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPurple,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      // Navigasi ke Detail Tiket dengan membawa data dari card
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TiketScreen(booking: booking),
                        ),
                      );
                    },
                    child: const Text('Detail', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: BOTTOM NAV ITEM ---
  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index; // Akan true jika index == 1 (Booking)
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Navigasi kembali ke Beranda (MainScreen)
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false,
          );
        } else if (index == 2) {
          // Navigasi ke PesanScreen
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PesanScreen()));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Buka halaman Pesan')));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilScreen()));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Buka halaman Profil')));
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