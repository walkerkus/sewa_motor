import 'package:flutter/material.dart';
import 'qris_screen.dart';

class PembayaranScreen extends StatefulWidget {
  final Map<String, String> motor;

  const PembayaranScreen({super.key, required this.motor});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  // Variabel untuk menyimpan metode pembayaran yang dipilih (Default: QRIS)
  String _selectedPaymentMethod = 'Scan QRIS';

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
          'Form Pembayaran',
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
                  _buildStepIndicator(1, 'Data', isCompleted: true),
                  _buildStepLine(),
                  _buildStepIndicator(2, 'Pembayaran', isActive: true),
                  _buildStepLine(),
                  _buildStepIndicator(3, 'Selesai', isActive: false),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 2. RINCIAN HARGA CARD ---
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

            const SizedBox(height: 30),

            // --- 3. METODE PEMBAYARAN SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Metode Pembayaran', // Diubah sedikit dari gambar ("Detail Sewa") agar lebih logis secara konteks
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  
                  // Pilihan Metode Pembayaran
                  _buildPaymentOption(
                    title: 'Transfer bank',
                    subtitle: 'Bayar melalui rekening bank',
                    iconWidget: _buildIconContainer(Icons.account_balance_rounded, const Color(0xFF1D63DC)),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentOption(
                    title: 'Top up E-wallet',
                    subtitle: 'Bayar melalui E-wallet',
                    iconWidget: _buildIconContainer(Icons.account_balance_wallet_rounded, Colors.black),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentOption(
                    title: 'Scan QRIS',
                    subtitle: 'Bayar melalui QRIS',
                    // Ikon custom khusus QRIS (Kotak hijau tulisan QRIS)
                    iconWidget: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ade80), // Hijau terang QRIS
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'QRIS',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: -0.5),
                        ),
                      ),
                    ),
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
            if (_selectedPaymentMethod == 'Scan QRIS') {
                // Jika QRIS dipilih, arahkan ke QrisScreen
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QrisScreen(motor: widget.motor),
                ),
                );
            } else {
                // Jika metode lain dipilih (Transfer/E-Wallet), tampilkan pesan sementara
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Memproses pembayaran dengan $_selectedPaymentMethod...')),
                );
            }
            },
            child: const Text(
              'Bayar',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  // Helper untuk membuat Kartu Metode Pembayaran yang bisa di-klik
  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required Widget iconWidget,
  }) {
    final bool isSelected = _selectedPaymentMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // Memberikan border biru halus jika dipilih
          border: Border.all(
            color: isSelected ? const Color(0xFF1D63DC) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // Custom Radio Button
            Container(
              width: 22,
              height: 22,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1D63DC) : Colors.black45,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1D63DC),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk ikon Bank & E-wallet
  Widget _buildIconContainer(IconData icon, Color bgColor) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  // Helper untuk Step Indicator (Angka) dengan state dinamis
  Widget _buildStepIndicator(int stepNumber, String label, {bool isActive = false, bool isCompleted = false}) {
    final Color stepColor = (isActive || isCompleted) ? const Color(0xFF1D63DC) : Colors.grey.shade300;
    
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: stepColor,
          ),
          alignment: Alignment.center,
          child: Text(
            stepNumber.toString(),
            style: TextStyle(
              color: (isActive || isCompleted) ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: (isActive || isCompleted) ? const Color(0xFF1D63DC) : Colors.grey.shade500,
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