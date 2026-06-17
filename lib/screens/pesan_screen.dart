import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/api_service.dart';
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

  bool _isLoading = true;
  List<Message> listPesan = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      setState(() => _isLoading = true);
      final data = await ApiService.getMessages();
      setState(() {
        listPesan = data.map((e) => Message.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
                : RefreshIndicator(
                    color: primaryPurple,
                    onRefresh: _loadMessages,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      itemCount: listPesan.length,
                      itemBuilder: (context, index) {
                        final chat = listPesan[index];
                        return _buildChatItem(
                          message: chat,
                          primaryPurple: primaryPurple,
                          darkText: darkText,
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
    required Message message,
    required Color primaryPurple,
    required Color darkText,
  }) {
    final bool hasUnread = message.unreadCount > 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomScreen(
              messageId: message.id,
              senderName: message.senderName,
              senderImage: message.avatar,
              isOnline: message.isOnline,
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
                  backgroundImage: message.avatar.isNotEmpty ? NetworkImage(message.avatar) : null,
                  child: message.avatar.isEmpty ? const Icon(Icons.person_rounded, color: Colors.grey) : null,
                ),
                if (message.isOnline)
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
                          message.senderName,
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
                        message.time,
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
                          message.text,
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
                            message.unreadCount.toString(),
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