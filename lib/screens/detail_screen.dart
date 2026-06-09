import 'package:flutter/material.dart';
import 'form_sewa_screen.dart'; // Menghubungkan ke halaman form

class DetailScreen extends StatefulWidget {
  final Map<String, String> motor;

  const DetailScreen({super.key, required this.motor});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  final int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF154DB3), Color(0xFF1D63DC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Motor',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () => setState(() => isFavorite = !isFavorite),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Hero(
                    tag: widget.motor['name']!,
                    child: Image.network(
                      widget.motor['image']!,
                      height: 220,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.motorcycle, size: 100, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == _currentImageIndex ? 10 : 8,
                        height: index == _currentImageIndex ? 10 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentImageIndex
                              ? const Color(0xFF1D63DC)
                              : Colors.grey.withOpacity(0.3),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.motor['name']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.motor['price']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D63DC)),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 25, 20, 25),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSpecItem(Icons.settings_suggest_rounded, '110 cc', 'Mesin'),
                  _buildSpecItem(Icons.local_gas_station_rounded, '60 km/L', 'BBM'),
                  _buildSpecItem(Icons.person_outline_rounded, '2 orang', 'Kapasitas'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Deskripsi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87)),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.motor['desc']!} Motor ini sangat nyaman digunakan untuk berbagai keperluan harian dengan konsumsi bahan bakar yang sangat efisien.',
                    style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Syarat & ketentuan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87)),
                  const SizedBox(height: 15),
                  _buildChecklistItem('Usia minimal 17 tahun'),
                  _buildChecklistItem('Menunjukan KTP asli saat serah terima'),
                  _buildChecklistItem('Meninggalkan jaminan (KTP/SIM/Paspor)'),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
          ],
        ),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1D63DC), Color(0xFF154DB3)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: const Color(0xFF1D63DC).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5)),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () {
              // Navigasi ke halaman form sewa
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormSewaScreen(motor: widget.motor),
                ),
              );
            },
            child: const Text(
              'Sewa Sekarang',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 26, color: Colors.black87),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black87)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
      ],
    );
  }

  Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_outlined, color: Color(0xFF1D63DC), size: 18),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}