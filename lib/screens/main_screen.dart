import 'package:flutter/material.dart';
import 'detail_screen.dart'; 
import 'riwayat_screen.dart'; // Import halaman riwayat

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  // Data Asli (Master Data)
  final List<Map<String, String>> motorList = [
    {
      'name': 'Honda Beat Deluxe',
      'price': 'Rp 70.000 / hari',
      'desc': 'Motor irit & lincah untuk harian.',
      'image': 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=200',
    },
    {
      'name': 'Yamaha NMAX 155',
      'price': 'Rp 120.000 / hari',
      'desc': 'Kenyamanan ekstra untuk touring.',
      'image': 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=200',
    },
    {
      'name': 'Honda Vario 125 CBS',
      'price': 'Rp 90.000 / hari',
      'desc': 'Performa mantap dengan fitur canggih.',
      'image': 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=200',
    },
    {
      'name': 'Yamaha Mio Gear',
      'price': 'Rp 60.000 / hari',
      'desc': 'Praktis dan lincah bertenaga.',
      'image': 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?q=80&w=200',
    },
  ];

  List<Map<String, String>> _filteredMotorList = [];

  @override
  void initState() {
    super.initState();
    _filteredMotorList = motorList;
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      results = motorList;
    } else {
      results = motorList
          .where((motor) =>
              motor['name']!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredMotorList = results;
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Efek Cahaya Belakang
          Positioned(
            top: 200,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF1D63DC).withOpacity(0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              // --- PREMIUM HEADER SECTION ---
              Container(
                padding: EdgeInsets.fromLTRB(20, statusBarHeight + 10, 20, 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF154DB3), Color(0xFF1D63DC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                        Column(
                          children: [
                            Text(
                              'MOTORENT',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  letterSpacing: 2,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Sewa Motor',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // --- INTERACTIVE SEARCH BAR ---
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E9F0),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: _searchFocusNode.hasFocus
                                ? const Color(0xFF1D63DC).withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: _searchFocusNode.hasFocus ? 12 : 5,
                            spreadRadius: _searchFocusNode.hasFocus ? 2 : 0,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.search,
                                color: _searchFocusNode.hasFocus ? const Color(0xFF1D63DC) : Colors.black54,
                                size: 22),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              onChanged: (value) => _runFilter(value),
                              onTap: () => setState(() {}),
                              onSubmitted: (value) => setState(() => _searchFocusNode.unfocus()),
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                              decoration: const InputDecoration(
                                hintText: 'Cari Motor Impian...',
                                hintStyle: TextStyle(
                                    color: Colors.black45, fontWeight: FontWeight.w500, fontSize: 13),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.mic_none_rounded, color: Colors.black54, size: 22),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- LIST MOTOR SECTION ---
              Expanded(
                child: _filteredMotorList.isEmpty
                    ? const Center(
                        child: Text(
                          'Motor yang Anda cari tidak ditemukan.',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                        itemCount: _filteredMotorList.length,
                        itemBuilder: (context, index) {
                          final motor = _filteredMotorList[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 22),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: const Color(0xFF1D63DC).withOpacity(0.06),
                                  blurRadius: 20,
                                  spreadRadius: 3,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  // Gambar Motor
                                  Expanded(
                                    flex: 4,
                                    child: AspectRatio(
                                      aspectRatio: 1.1,
                                      child: Hero(
                                        tag: motor['name']!,
                                        child: Image.network(
                                          motor['image']!,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.motorcycle_rounded, size: 60, color: Colors.grey);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Detail Info Motor
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          motor['name']!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          motor['price']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF154DB3),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          motor['desc']!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black.withOpacity(0.6),
                                            height: 1.3,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 12),
                                        // Tombol Lihat Detail
                                        Container(
                                          width: double.infinity,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF1D63DC), Color(0xFF154DB3)],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              foregroundColor: Colors.white,
                                              shadowColor: Colors.transparent,
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              elevation: 0,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DetailScreen(motor: motor),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Lihat Detail',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCustomNavItem(0, Icons.home_rounded, Icons.home_outlined, 'Home'),
            _buildCustomNavItem(1, Icons.history_edu_rounded, Icons.history_edu_outlined, 'Riwayat'),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          // Navigasi ke halaman Riwayat jika tombol Riwayat diklik
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RiwayatScreen(),
            ),
          );
        } else {
          // Jika tombol Home, tetap di halaman ini
          setState(() => _selectedIndex = index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF1D63DC) : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? Colors.white : Colors.black45,
              size: 24,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              color: isActive ? const Color(0xFF1D63DC) : Colors.black45,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}