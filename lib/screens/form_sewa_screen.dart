import 'package:flutter/material.dart';
import 'pembayaran_screen.dart';

class FormSewaScreen extends StatefulWidget {
  final Map<String, String> motor;

  const FormSewaScreen({super.key, required this.motor});

  @override
  State<FormSewaScreen> createState() => _FormSewaScreenState();
}

class _FormSewaScreenState extends State<FormSewaScreen> {
  // Controller form sesuai dengan gambar referensi
  final TextEditingController _namaController = TextEditingController(text: 'Budi Lestari');
  final TextEditingController _teleponController = TextEditingController(text: '081253636885');
  final TextEditingController _tanggalController = TextEditingController(text: '6 Mei 2026');
  final TextEditingController _lamaSewaController = TextEditingController(text: '2');

  @override
  void dispose() {
    _namaController.dispose();
    _teleponController.dispose();
    _tanggalController.dispose();
    _lamaSewaController.dispose();
    super.dispose();
  }

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
          'Form Sewa',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. STEPPER INDICATOR ---
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepIndicator(1, 'Data', isActive: true),
                  _buildStepLine(),
                  _buildStepIndicator(2, 'Pembayaran', isActive: false),
                  _buildStepLine(),
                  _buildStepIndicator(3, 'Selesai', isActive: false),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 2. DATA PENYEWA SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Penyewa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  _buildCustomTextField('Nama Lengkap', Icons.person_outline_rounded, _namaController),
                  const SizedBox(height: 15),
                  _buildCustomTextField('No. Telepon', Icons.phone_outlined, _teleponController),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- 3. DETAIL SEWA SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Sewa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  _buildCustomTextField('Tanggal Sewa', Icons.calendar_today_outlined, _tanggalController, isRightIcon: true),
                  const SizedBox(height: 15),
                  _buildCustomTextField('Lama Sewa (hari)', Icons.calendar_today_outlined, _lamaSewaController),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- 4. RINCIAN HARGA CARD ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Harga',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Harga/hari', style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text(widget.motor['price']!.split(' ')[0],
                          style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Lama Sewa', style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text('2 hari', style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.black12, thickness: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w900)),
                      Text(
                        'Rp 140.000', 
                        style: TextStyle(color: const Color(0xFF1D63DC), fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // --- BOTTOM NAVIGATION BUTTON ---
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => PembayaranScreen(motor: widget.motor),
                ),
            );
            },
            child: const Text(
              'Lanjut ke Pembayaran',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  // Helper untuk membuat TextField
  Widget _buildCustomTextField(String label, IconData icon, TextEditingController controller, {bool isRightIcon = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isRightIcon)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 15.0),
            child: Icon(icon, color: Colors.black87, size: 24),
          ),
        if (isRightIcon)
           const Padding(
            padding: EdgeInsets.only(bottom: 10.0, right: 15.0),
            child: Icon(Icons.calendar_month, color: Colors.black87, size: 24),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black45)),
              const SizedBox(height: 6),
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400, width: 0.8),
                ),
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    suffixIcon: isRightIcon ? const Icon(Icons.calendar_today_rounded, size: 18, color: Colors.black45) : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper untuk Step Indicator
  Widget _buildStepIndicator(int stepNumber, String label, {required bool isActive}) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF1D63DC) : Colors.grey.shade300,
          ),
          alignment: Alignment.center,
          child: Text(
            stepNumber.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF1D63DC) : Colors.grey.shade500,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // Helper untuk Garis Step
  Widget _buildStepLine() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 20,
      height: 1.5,
      color: Colors.grey.shade300,
    );
  }
}