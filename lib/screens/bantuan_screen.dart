import 'package:flutter/material.dart';
import '../models/faq_model.dart';
import '../services/api_service.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF4F6F9);

  bool _isLoading = true;
  String? _error;
  List<FaqModel> _faqs = [];

  @override
  void initState() {
    super.initState();
    _loadFaqs();
  }

  Future<void> _loadFaqs() async {
    try {
      setState(() { _isLoading = true; _error = null; });
      final data = await ApiService.getFaqs();
      setState(() {
        _faqs = data.map((e) => FaqModel.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
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
                    'Pusat Bantuan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // --- 3. KONTEN UTAMA ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 100),
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
                  // --- SEARCH BAR (Floating) ---
                  Transform.translate(
                    offset: const Offset(0, -25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari topik bantuan...',
                            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                            prefixIcon: Icon(Icons.search_rounded, color: primaryPurple),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          onSubmitted: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Mencari: $value')),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
                        : _error != null
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.cloud_off_rounded, size: 50, color: Colors.grey),
                                    const SizedBox(height: 12),
                                    Text('Gagal memuat FAQ', style: TextStyle(color: Colors.grey.shade600)),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: _loadFaqs,
                                      style: ElevatedButton.styleFrom(backgroundColor: primaryPurple),
                                      child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              )
                            : RefreshIndicator(
                                color: primaryPurple,
                                onRefresh: _loadFaqs,
                                child: ListView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(top: 0, bottom: 40, left: 24, right: 24),
                                  children: [
                                    _buildSectionTitle('Hubungi Customer Service'),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildContactButton(Icons.chat_bubble_rounded, 'Live Chat', Colors.blue.shade400),
                                        _buildContactButton(Icons.call_rounded, 'Telepon', Colors.green.shade400),
                                        _buildContactButton(Icons.email_rounded, 'Email', Colors.orange.shade400),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    _buildSectionTitle('Pertanyaan Populer (FAQ)'),
                                    const SizedBox(height: 12),
                                    ..._faqs.map((faq) => _buildFaqItem(faq.question, faq.answer)),
                                  ],
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String label, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Membuka $label...')),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: primaryPurple,
          collapsedIconColor: Colors.grey.shade400,
          title: Text(
            question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
          childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          children: [
            Text(
              answer,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}