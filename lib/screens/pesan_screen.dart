import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'riwayat_screen.dart';
import 'profil_screen.dart';
import 'chat_room_screen.dart'; // Menghubungkan ke halaman Chat Room Detail

class PesanScreen extends StatefulWidget {
  const PesanScreen({super.key});

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  // Navigasi bawah: 2 = Pesan
  final int _selectedIndex = 2;
  final TextEditingController _searchController = TextEditingController();

  // Data Dummy Chat
  final List<Map<String, dynamic>> listPesan = [
    {
      'name': 'Admin MotorKU',
      'lastMessage': 'Halo Mas Akbar, untuk persyaratan KTP bisa diupload via link yang kami kirimkan ya. Terima kasih! 🙏',
      'time': '10:42',
      'unread': 2,
      'isOnline': true,
      'image': 'https://ui-avatars.com/api/?name=Admin+M&background=7A58E6&color=fff&rounded=true&bold=true',
    },
    {
      'name': 'Pak Budi (Pengirim Motor)',
      'lastMessage': 'Posisi saya sudah di depan gerbang MCC ya mas, motor Vario 125 nya sudah siap.',
      'time': '09:15',
      'unread': 1,
      'isOnline': true,
      'image': 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200&auto=format&fit=crop',
    },
    {
      'name': 'CS Bantuan',
      'lastMessage': 'Terima kasih telah menghubungi layanan pelanggan kami. Tiket laporan Anda sudah ditutup.',
      'time': 'Kemarin',
      'unread': 0,
      'isOnline': false,
      'image': 'https://ui-avatars.com/api/?name=CS&background=E5E7EB&color=2D3142&rounded=true&bold=true',
    },
    {
      'name': 'Promo & Info',
      'lastMessage': 'Diskon 20% khusus untuk perpanjangan sewa hari ini! Klaim vouchernya sekarang.',
      'time': '10 Mei',
      'unread': 0,
      'isOnline': false,
      'image': 'https://ui-avatars.com/api/?name=%25&background=F3F0FF&color=7A58E6&rounded=true&bold=true',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        automaticallyImplyLeading: false, // Hilangkan tombol back default karena ini menu utama
        title: Text(
          'Pesan',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_rounded, color: darkText),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // --- 1. SEARCH BAR KOTAK MASUK ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Cari pesan atau pengirim...',
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 10),

          // --- 2. LIST CHAT ---
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              itemCount: listPesan.length,
              itemBuilder: (context, index) {
                final chat = listPesan[index];
                return _buildChatItem(
                  name: chat['name'],
                  lastMessage: chat['lastMessage'],
                  time: chat['time'],
                  unreadCount: chat['unread'],
                  imageUrl: chat['image'],
                  isOnline: chat['isOnline'],
                  primaryPurple: primaryPurple,
                  darkText: darkText,
                );
              },
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
            _buildNavItem(2, Icons.chat_bubble_rounded, 'Pesan', primaryPurple), // Aktif
            _buildNavItem(3, Icons.person_outline_rounded, 'Profil', primaryPurple),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: ITEM CHAT ---
  Widget _buildChatItem({
    required String name,
    required String lastMessage,
    required String time,
    required int unreadCount,
    required String imageUrl,
    required bool isOnline,
    required Color primaryPurple,
    required Color darkText,
  }) {
    bool hasUnread = unreadCount > 0;

    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman Ruang Chat (Chat Room Detail) dengan parameter yang sesuai
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomScreen(
              senderName: name, // Menggunakan properti yang diminta ChatRoomScreen
              senderImage: imageUrl,
              isOnline: isOnline,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: hasUnread ? primaryPurple.withOpacity(0.04) : Colors.white, // Highlight tipis jika ada pesan belum dibaca
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: hasUnread ? primaryPurple.withOpacity(0.3) : Colors.transparent),
          boxShadow: [
            if (!hasUnread) // Shadow hanya jika tidak ada pesan baru, agar terlihat seperti card biasa
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Row(
          children: [
            // Avatar Pengirim
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                if (isOnline)
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E), // Hijau online
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            
            // Teks Pesan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: hasUnread ? FontWeight.bold : FontWeight.w700,
                            color: darkText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: hasUnread ? FontWeight.bold : FontWeight.w500,
                          color: hasUnread ? primaryPurple : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyle(
                            fontSize: 13,
                            color: hasUnread ? darkText : Colors.grey.shade500,
                            fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: primaryPurple,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
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
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false,
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RiwayatScreen()),
          );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfilScreen()),
          );
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