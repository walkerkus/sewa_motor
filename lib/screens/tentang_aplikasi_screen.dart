import 'package:flutter/material.dart';
import '../models/app_info_model.dart';
import '../services/api_service.dart';

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
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 130),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 70, bottom: 40, left: 24, right: 24),
                children: [
                  Column(
                    children: [
                      Text('SewaMotor App', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: darkText)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                        child: Text('Versi 1.0.0', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade600)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aplikasi penyewaan motor terbaik yang memberikan kemudahan, kecepatan, dan kenyamanan perjalanan Anda di berbagai kota.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade500, height: 1.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildSectionTitle('Informasi Legal'),
                  _buildMenuCard(
                    context: context,
                    children: [
                      _buildMenuRow(
                        context: context,
                        icon: Icons.description_outlined,
                        label: 'Syarat & Ketentuan',
                        iconColor: primaryPurple,
                        darkText: darkText,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SyaratKetentuanScreen()));
                        },
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        context: context,
                        icon: Icons.privacy_tip_outlined,
                        label: 'Kebijakan Privasi',
                        iconColor: primaryPurple,
                        darkText: darkText,
                        isLast: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const KebijakanPrivasiScreen()));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Lainnya'),
                  _buildMenuCard(
                    context: context,
                    children: [
                      _buildMenuRow(
                        context: context,
                        icon: Icons.star_outline_rounded,
                        label: 'Beri Nilai Aplikasi',
                        iconColor: Colors.amber,
                        darkText: darkText,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menuju Play Store / App Store'))),
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        context: context,
                        icon: Icons.language_rounded,
                        label: 'Kunjungi Website Kami',
                        iconColor: Colors.blue,
                        darkText: darkText,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka Browser...'))),
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        context: context,
                        icon: Icons.share_rounded,
                        label: 'Bagikan Aplikasi',
                        iconColor: Colors.green,
                        darkText: darkText,
                        isLast: true,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membagikan tautan aplikasi...'))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        const Text('© 2026 SewaMotor App', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text('Dibuat dengan ❤️ di Indonesia', style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 85,
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
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(color: primaryPurple.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey.shade500, letterSpacing: 0.3)),
    );
  }

  Widget _buildMenuCard({required BuildContext context, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuRow({required BuildContext context, required IconData icon, required String label, required Color iconColor, required Color darkText, bool isLast = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkText))),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
    );
  }
}

// ============================================================================
// HALAMAN SYARAT & KETENTUAN (API-connected)
// ============================================================================

class SyaratKetentuanScreen extends StatefulWidget {
  const SyaratKetentuanScreen({super.key});

  @override
  State<SyaratKetentuanScreen> createState() => _SyaratKetentuanScreenState();
}

class _SyaratKetentuanScreenState extends State<SyaratKetentuanScreen> {
  final Color darkText = const Color(0xFF2D3142);
  bool _isLoading = true;
  List<AppInfoModel> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getTerms();
      setState(() {
        _items = data.map((e) => AppInfoModel.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Syarat & Ketentuan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              physics: const BouncingScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_items[index].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
                      const SizedBox(height: 8),
                      Text(_items[index].content, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.6)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// ============================================================================
// HALAMAN KEBIJAKAN PRIVASI (API-connected)
// ============================================================================

class KebijakanPrivasiScreen extends StatefulWidget {
  const KebijakanPrivasiScreen({super.key});

  @override
  State<KebijakanPrivasiScreen> createState() => _KebijakanPrivasiScreenState();
}

class _KebijakanPrivasiScreenState extends State<KebijakanPrivasiScreen> {
  final Color darkText = const Color(0xFF2D3142);
  bool _isLoading = true;
  List<AppInfoModel> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getPrivacy();
      setState(() {
        _items = data.map((e) => AppInfoModel.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Kebijakan Privasi', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              physics: const BouncingScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_items[index].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
                      const SizedBox(height: 8),
                      Text(_items[index].content, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.6)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}