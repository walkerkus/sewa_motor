import 'package:flutter/material.dart';

// ============================================================================
// 1. HALAMAN UTAMA PENGATURAN
// ============================================================================

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF4F6F9);

  // State untuk Toggle Switch
  bool isBiometricEnabled = true;
  bool isNotifPromoEnabled = true;
  bool isNotifPesanEnabled = true;
  bool isLocationEnabled = true; // <-- Tambahan State untuk Lokasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      // PENTING: Ini membuat body menyatu dengan AppBar transparan di atasnya
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 64, // Memberi ruang agar lingkaran tombol tidak gepeng
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Pengaturan',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.5),
        ),
      ),
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

          // --- 2. KONTEN UTAMA ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 120), // Jarak aman dari AppBar
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
                padding: const EdgeInsets.only(top: 30, bottom: 40, left: 24, right: 24),
                children: [
                  // --- KELOMPOK KEAMANAN ---
                  _buildSectionTitle('Keamanan Akun'),
                  _buildMenuCard(
                    children: [
                      _buildMenuRow(
                        icon: Icons.lock_outline_rounded,
                        label: 'Ubah Kata Sandi',
                        iconColor: primaryPurple,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UbahSandiScreen()));
                        },
                      ),
                      _buildDivider(),
                      _buildToggleRow(
                        icon: Icons.face_retouching_natural_rounded,
                        label: 'Face ID / Sidik Jari',
                        iconColor: primaryPurple,
                        value: isBiometricEnabled,
                        onChanged: (val) {
                          setState(() => isBiometricEnabled = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- KELOMPOK PREFERENSI ---
                  _buildSectionTitle('Preferensi'),
                  _buildMenuCard(
                    children: [
                      _buildMenuRow(
                        icon: Icons.language_rounded,
                        label: 'Bahasa',
                        iconColor: Colors.blue,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PengaturanBahasaScreen()));
                        },
                      ),
                      _buildDivider(),
                      // --- TAMBAHAN: AKSES LOKASI ---
                      _buildToggleRow(
                        icon: Icons.location_on_outlined,
                        label: 'Akses Lokasi (GPS)',
                        iconColor: Colors.teal,
                        value: isLocationEnabled,
                        onChanged: (val) {
                          setState(() => isLocationEnabled = val);
                        },
                      ),
                      _buildDivider(),
                      _buildToggleRow(
                        icon: Icons.notifications_active_outlined,
                        label: 'Notif Pesan & Booking',
                        iconColor: Colors.orange,
                        value: isNotifPesanEnabled,
                        onChanged: (val) {
                          setState(() => isNotifPesanEnabled = val);
                        },
                      ),
                      _buildDivider(),
                      _buildToggleRow(
                        icon: Icons.local_offer_outlined,
                        label: 'Notif Promo & Diskon',
                        iconColor: Colors.green,
                        value: isNotifPromoEnabled,
                        onChanged: (val) {
                          setState(() => isNotifPromoEnabled = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- KELOMPOK AKUN ---
                  _buildSectionTitle('Zonasi Bahaya'),
                  _buildMenuCard(
                    children: [
                      _buildMenuRow(
                        icon: Icons.delete_forever_rounded,
                        label: 'Hapus Akun Permanen',
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        hideArrow: true,
                        onTap: () {
                          _showDeleteAccountDialog(context);
                        },
                      ),
                    ],
                  ),
                ],
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
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey.shade500, letterSpacing: 0.3),
      ),
    );
  }

  Widget _buildMenuCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuRow({
    required IconData icon, 
    required String label, 
    required Color iconColor, 
    Color? textColor, 
    bool hideArrow = false,
    required VoidCallback onTap
  }) {
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
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textColor ?? darkText),
              ),
            ),
            if (!hideArrow) Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon, 
    required String label, 
    required Color iconColor, 
    required bool value, 
    required ValueChanged<bool> onChanged
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkText),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: primaryPurple,
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Column(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 48),
              SizedBox(height: 16),
              Text('Hapus Akun?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
            ],
          ),
          content: const Text(
            'Tindakan ini tidak dapat dibatalkan. Semua data diri, riwayat pesanan, dan poin Anda akan dihapus secara permanen.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permintaan hapus akun diproses.')));
              },
              child: const Text('Ya, Hapus', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// 2. SUB-HALAMAN: UBAH KATA SANDI
// ============================================================================

class UbahSandiScreen extends StatefulWidget {
  const UbahSandiScreen({super.key});

  @override
  State<UbahSandiScreen> createState() => _UbahSandiScreenState();
}

class _UbahSandiScreenState extends State<UbahSandiScreen> {
  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF4F6F9);

  bool _obscureLama = true;
  bool _obscureBaru = true;
  bool _obscureKonfirmasi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text('Ubah Kata Sandi', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: Stack(
        children: [
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 120),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              ),
              child: ListView(
                padding: const EdgeInsets.all(24),
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                    'Buat kata sandi baru yang kuat dan belum pernah digunakan sebelumnya.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  _buildPasswordField('Kata Sandi Saat Ini', _obscureLama, () => setState(() => _obscureLama = !_obscureLama)),
                  const SizedBox(height: 20),
                  _buildPasswordField('Kata Sandi Baru', _obscureBaru, () => setState(() => _obscureBaru = !_obscureBaru)),
                  const SizedBox(height: 20),
                  _buildPasswordField('Konfirmasi Kata Sandi Baru', _obscureKonfirmasi, () => setState(() => _obscureKonfirmasi = !_obscureKonfirmasi)),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kata sandi berhasil diubah!')));
                      Navigator.pop(context);
                    },
                    child: const Text('Simpan Kata Sandi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, bool isObscure, VoidCallback toggleVisibility) {
    return TextFormField(
      obscureText: isObscure,
      style: TextStyle(color: darkText, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFFAFBFF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Icon(Icons.lock_outline_rounded, color: primaryPurple, size: 22),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey.shade500),
            onPressed: toggleVisibility,
          ),
        ),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primaryPurple, width: 1.5)),
      ),
    );
  }
}

// ============================================================================
// 3. SUB-HALAMAN: PENGATURAN BAHASA
// ============================================================================

class PengaturanBahasaScreen extends StatefulWidget {
  const PengaturanBahasaScreen({super.key});

  @override
  State<PengaturanBahasaScreen> createState() => _PengaturanBahasaScreenState();
}

class _PengaturanBahasaScreenState extends State<PengaturanBahasaScreen> {
  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF4F6F9);

  String selectedLanguage = 'Indonesia'; 
  final List<Map<String, String>> languages = [
    {'code': 'ID', 'name': 'Indonesia', 'flag': '🇮🇩'},
    {'code': 'EN', 'name': 'English', 'flag': '🇺🇸'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text('Pilih Bahasa', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: Stack(
        children: [
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 120),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                physics: const BouncingScrollPhysics(),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  final isSelected = selectedLanguage == lang['nama'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLanguage = lang['nama']!;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bahasa diubah ke ${lang['nama']}')));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryPurple.withOpacity(0.05) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isSelected ? primaryPurple : Colors.grey.shade200, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(lang['kode']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                lang['nama']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                  color: isSelected ? primaryPurple : darkText,
                                ),
                              ),
                            ],
                          ),
                          if (isSelected) Icon(Icons.check_circle_rounded, color: primaryPurple, size: 24),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}