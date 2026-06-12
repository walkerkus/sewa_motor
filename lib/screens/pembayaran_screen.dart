import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/motor_model.dart';
import 'qris_screen.dart'; // Buka komentar ini nanti jika qris_screen sudah ada

class PembayaranScreen extends StatefulWidget {
  final Motor motor;

  const PembayaranScreen({super.key, required this.motor});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  String _selectedPaymentMethod = 'Scan QRIS';

  // Fungsi untuk mengambil angka harga dari string
  int _getHargaMotor() {
    String priceStr = widget.motor.price;
    String numericOnly = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numericOnly) ?? 0;
  }

  // Format currency ke Rupiah
  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    int hargaPerHari = _getHargaMotor();
    int totalHarga = hargaPerHari * 2; // Dikalikan 2 hari sesuai data booking
    
    final Color primaryPurple = const Color(0xFF7A58E6); // Ungu khas aplikasi kamu
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF), // Background terang
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pembayaran',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. STEPPER INDICATOR ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepIndicator(1, 'Pilih Motor', status: 'completed', activeColor: primaryPurple),
                    _buildStepLine(isActive: true, color: primaryPurple),
                    _buildStepIndicator(2, 'Detail', status: 'completed', activeColor: primaryPurple),
                    _buildStepLine(isActive: true, color: primaryPurple),
                    _buildStepIndicator(3, 'Pembayaran', status: 'active', activeColor: primaryPurple),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),

              // --- 2. RINCIAN HARGA CARD ---
              Text('Ringkasan Biaya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Harga/hari', style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                        Text(widget.motor.price.split(' ')[0],
                            style: TextStyle(color: darkText, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lama Sewa', style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                        Text('2 Hari', style: TextStyle(color: darkText, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: Colors.black12, height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Pembayaran', style: TextStyle(color: darkText, fontSize: 14, fontWeight: FontWeight.bold)),
                        Text(
                          _formatCurrency(totalHarga), 
                          style: TextStyle(color: primaryPurple, fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- 3. METODE PEMBAYARAN SECTION ---
              Text('Metode Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
              const SizedBox(height: 12),
              
              // Pilihan Metode Pembayaran
              _buildPaymentOption(
                title: 'Transfer bank',
                subtitle: 'Bayar melalui rekening bank',
                iconWidget: _buildIconContainer(Icons.account_balance_rounded, const Color(0xFF1E293B)), // Biru dongker
                primaryPurple: primaryPurple,
              ),
              const SizedBox(height: 12),
              _buildPaymentOption(
                title: 'Top up E-wallet',
                subtitle: 'Bayar melalui OVO, Dana, Gopay',
                iconWidget: _buildIconContainer(Icons.account_balance_wallet_rounded, const Color(0xFF0EA5E9)), // Biru muda
                primaryPurple: primaryPurple,
              ),
              const SizedBox(height: 12),
              _buildPaymentOption(
                title: 'Scan QRIS',
                subtitle: 'Bayar instan melalui QRIS',
                primaryPurple: primaryPurple,
                iconWidget: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E), // Hijau terang QRIS
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'QRIS',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: -0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      
      // --- BOTTOM NAVIGATION BUTTON ---
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPurple,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            if (_selectedPaymentMethod == 'Scan QRIS') {
                // TODO: Arahkan ke QrisScreen
                Navigator.push(context, MaterialPageRoute(builder: (context) => QrisScreen(motor: widget.motor)));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Buka halaman QRIS')),
                );
            } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Memproses pembayaran dengan $_selectedPaymentMethod...')),
                );
            }
          },
          child: const Text(
            'Bayar Sekarang',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.3),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required Widget iconWidget,
    required Color primaryPurple,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryPurple.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryPurple : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2D3142)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // Custom Radio Button
            Container(
              width: 22,
              height: 22,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryPurple : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryPurple,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon, Color bgColor) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  // Status: 'completed', 'active', 'inactive'
  Widget _buildStepIndicator(int stepNumber, String label, {required String status, required Color activeColor}) {
    bool isCompleted = status == 'completed';
    bool isActive = status == 'active';
    
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (isCompleted || isActive) ? activeColor : Colors.grey.shade200,
          ),
          alignment: Alignment.center,
          child: isCompleted
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
              : Text(
                  stepNumber.toString(), 
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.grey.shade500, 
                    fontWeight: FontWeight.bold
                  )
                ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black87 : Colors.grey.shade400,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine({required bool isActive, required Color color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      width: 30,
      height: 1.5,
      color: isActive ? color : Colors.grey.shade200,
    );
  }
}