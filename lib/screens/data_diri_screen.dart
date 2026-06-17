import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'edit_data_diri_screen.dart';

class DataDiriScreen extends StatefulWidget {
  const DataDiriScreen({super.key});

  @override
  State<DataDiriScreen> createState() => _DataDiriScreenState();
}

class _DataDiriScreenState extends State<DataDiriScreen> {
  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF8F9FA);

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
    return Scaffold(
      backgroundColor: lightBg,
      body: Stack(
        children: [
          // --- 1. BACKGROUND GRADIENT UNGU TUA ---
          Container(
            height: 260,
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
                    'Data Diri',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  // Tombol Edit di header data_diri_screen.dart
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditDataDiriScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ], // <-- PERBAIKAN: Disini letak kurung siku ']' yang hilang
              ),
            ),
          ),

          // --- 3. KONTEN SCROLL (FLOATING AVATAR & KARTU DATA) ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 130), // Memberi ruang untuk Avatar
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6F9), // Warna background abu sangat muda
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 80, bottom: 40, left: 24, right: 24),
                children: [
                  // Nama & Pekerjaan di tengah
                  Column(
                    children: [
                      Text(
                        _user?.name ?? 'Memuat...',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _user?.occupation ?? '-',
                          style: TextStyle(
                            color: primaryPurple,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),

                  // KELOMPOK 1: Kontak
                  _buildSectionTitle('Informasi Kontak'),
                  _buildDataCard(
                    children: [
                      _buildDataRow(Icons.email_outlined, 'Email', _user?.email ?? '-'),
                      _buildDivider(),
                      _buildDataRow(Icons.phone_outlined, 'No. Telepon', _user?.phone ?? '-', isLast: true),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // KELOMPOK 2: Detail Pribadi
                  _buildSectionTitle('Detail Pribadi'),
                  _buildDataCard(
                    children: [
                      _buildDataRow(Icons.calendar_today_outlined, 'Tanggal Lahir', _user?.birthDate ?? '-'),
                      _buildDivider(),
                      _buildDataRow(Icons.male_outlined, 'Jenis Kelamin', _user?.gender ?? '-', isLast: true),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // KELOMPOK 3: Lokasi / Alamat
                  _buildSectionTitle('Lokasi'),
                  _buildDataCard(
                    children: [
                      _buildDataRow(Icons.location_on_outlined, 'Alamat Domisili', _user?.address ?? '-', isLast: true, isMultiline: true),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- 4. FLOATING AVATAR (Ditumpuk di atas segalanya) ---
          Positioned(
            top: 90, // Posisi memotong antara ungu dan putih
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(6), // Border putih ketebalan 6
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: (_user?.avatar.isNotEmpty == true) ? NetworkImage(_user!.avatar) : null,
                  child: (_user?.avatar.isEmpty != false) ? const Icon(Icons.person_rounded, color: Colors.white, size: 40) : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: Judul Kategori ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // --- WIDGET HELPER: Kartu Pembungkus Kelompok Data ---
  Widget _buildDataCard({required List<Widget> children}) {
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

  // --- WIDGET HELPER: Baris Data (Row) ---
  Widget _buildDataRow(IconData icon, String label, String value, {bool isLast = false, bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryPurple.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryPurple, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: darkText,
                    fontWeight: FontWeight.w600,
                    height: isMultiline ? 1.4 : 1.0,
                  ),
                  maxLines: isMultiline ? 3 : 1,
                  overflow: isMultiline ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: Garis Pemisah (Divider) ---
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16), // Memberi indentasi sejajar dengan teks
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade100,
      ),
    );
  }
}