import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk fitur Copy/Salin teks
import 'package:intl/intl.dart';
import '../models/motor_model.dart';
import '../services/api_service.dart';
import 'konfirmasi_screen.dart';

class PembayaranScreen extends StatefulWidget {
  final Motor motor;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final int totalPrice;

  const PembayaranScreen({
    super.key, 
    required this.motor,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.totalPrice,
  });

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  String _selectedPaymentMethod = 'Scan QRIS';
  String? _selectedBank; // Menyimpan bank yang dipilih pengguna
  bool _showInstructions = false; // State untuk mengontrol tampilan instruksi
  bool _isLoading = false; // State untuk API call

  // --- FUNGSI PROSES PEMBAYARAN & BOOKING ---
  Future<void> _processPayment(String message) async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF7A58E6),
        behavior: SnackBarBehavior.floating,
      ),
    );

    try {
      final String startDateStr = DateFormat('yyyy-MM-dd').format(widget.startDate);
      final String endDateStr = DateFormat('yyyy-MM-dd').format(widget.endDate);

      await ApiService.createBooking(
        motorId: widget.motor.id,
        startDate: startDateStr,
        endDate: endDateStr,
        durationDays: widget.durationDays,
        totalPrice: widget.totalPrice,
        paymentMethod: _selectedPaymentMethod,
        pickupLocation: 'Mataram City Center (MCC)',
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => KonfirmasiScreen(
            motor: widget.motor,
            startDate: widget.startDate,
            endDate: widget.endDate,
            durationDays: widget.durationDays,
            totalPrice: widget.totalPrice,
            paymentMethod: _selectedPaymentMethod,
          )),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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

  // --- FUNGSI MEMUNCULKAN PILIHAN BANK (BOTTOM SHEET) ---
  void _showBankSelectionSheet(Color primaryPurple, Color darkText) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Bank Tujuan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkText),
              ),
              const SizedBox(height: 16),
              _buildBankListItem('BCA', primaryPurple, darkText),
              _buildBankListItem('Mandiri', primaryPurple, darkText),
              _buildBankListItem('BRI', primaryPurple, darkText),
              _buildBankListItem('BNI', primaryPurple, darkText),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Widget item bank di dalam Bottom Sheet
  Widget _buildBankListItem(String bankName, Color primaryPurple, Color darkText) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primaryPurple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.account_balance_rounded, color: primaryPurple, size: 20),
      ),
      title: Text('Bank $bankName', style: TextStyle(fontWeight: FontWeight.w600, color: darkText)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: () {
        Navigator.pop(context); // Tutup Bottom Sheet
        setState(() {
          _selectedBank = bankName; // Simpan bank yang dipilih
          _showInstructions = true; // Langsung pindah ke instruksi pembayaran
        });
      },
    );
  }

  // --- WIDGET UTAMA ---
  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);
    
    // Menghapus int totalHarga = _getHargaMotor() * 2; karena sudah pakai widget.totalPrice
    int totalHarga = widget.totalPrice;

    return WillPopScope(
      onWillPop: () async {
        if (_showInstructions) {
          setState(() => _showInstructions = false);
          return false; // Mencegah keluar halaman, hanya kembali ke state awal
        }
        return true; // Keluar dari halaman
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFBFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFBFF),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
            onPressed: () {
              if (_showInstructions) {
                setState(() => _showInstructions = false); // Kembali ke pilihan metode
              } else {
                Navigator.pop(context); // Kembali ke halaman detail
              }
            },
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
                      _buildStepIndicator(
                        3, 
                        _showInstructions ? 'Instruksi' : 'Pembayaran', 
                        status: 'active', 
                        activeColor: primaryPurple
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),

                // --- 2. SWITCH CONTENT (PILIH METODE ATAU INSTRUKSI) ---
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.05, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _showInstructions
                      ? _buildInstructionView(totalHarga, primaryPurple, darkText)
                      : _buildSelectionView(totalHarga, primaryPurple, darkText),
                ),
              ],
            ),
          ),
        ),

        // --- 3. BOTTOM NAVIGATION / ACTION BUTTON ---
        bottomNavigationBar: _showInstructions 
            ? _buildInstructionBottomBar(primaryPurple) 
            : _buildSelectionBottomBar(primaryPurple, darkText),
      ),
    );
  }

  // =========================================================================
  // VIEW 1: PILIHAN METODE PEMBAYARAN
  // =========================================================================
  Widget _buildSelectionView(int totalHarga, Color primaryPurple, Color darkText) {
    return Column(
      key: const ValueKey('SelectionView'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- RINCIAN HARGA CARD ---
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
                  Text(widget.motor.price.split(' ')[0], style: TextStyle(color: darkText, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lama Sewa', style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                  Text('${widget.durationDays} Hari', style: TextStyle(color: darkText, fontSize: 13, fontWeight: FontWeight.w600)),
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

        // --- METODE PEMBAYARAN ---
        Text('Metode Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
        const SizedBox(height: 12),
        
        _buildPaymentOption(
          title: 'Transfer bank',
          subtitle: 'Bayar melalui VA (BCA, Mandiri, BRI)',
          iconWidget: _buildIconContainer(Icons.account_balance_rounded, const Color(0xFF1E293B)), 
          primaryPurple: primaryPurple,
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          title: 'Top up E-wallet',
          subtitle: 'Bayar melalui OVO, Dana, Gopay',
          iconWidget: _buildIconContainer(Icons.account_balance_wallet_rounded, const Color(0xFF0EA5E9)), 
          primaryPurple: primaryPurple,
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          title: 'Scan QRIS',
          subtitle: 'Bayar instan dari semua aplikasi',
          primaryPurple: primaryPurple,
          iconWidget: Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: const Color(0xFF22C55E), borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text('QRIS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: -0.5)),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // =========================================================================
  // VIEW 2: INSTRUKSI PEMBAYARAN (QRIS / BANK / E-WALLET)
  // =========================================================================
  Widget _buildInstructionView(int totalHarga, Color primaryPurple, Color darkText) {
    return Column(
      key: const ValueKey('InstructionView'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_selectedPaymentMethod == 'Scan QRIS') 
          _buildQrisCard(totalHarga, primaryPurple, darkText)
        else if (_selectedPaymentMethod == 'Transfer bank') 
          _buildBankVirtualAccountCard(totalHarga, primaryPurple, darkText)
        else if (_selectedPaymentMethod == 'Top up E-wallet')
          _buildEwalletCard(totalHarga, primaryPurple, darkText),

        const SizedBox(height: 36),

        // --- TEKS STATUS ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16, height: 16, 
              child: CircularProgressIndicator(strokeWidth: 2.5, color: primaryPurple)
            ),
            const SizedBox(width: 12),
            Text(
              'Menunggu Pembayaran...',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryPurple),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Silakan selesaikan pembayaran dalam waktu 14:59 menit sebelum pesanan otomatis dibatalkan.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // --- KARTU QRIS ---
  Widget _buildQrisCard(int totalHarga, Color primaryPurple, Color darkText) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'QRIS',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, letterSpacing: -1, color: Color(0xFFE11D48)), 
                  ),
                  Text(
                    'QR Code Standar\nPembayaran Nasional',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF1D4ED8), size: 22), 
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('MotorKU Rent', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: darkText)),
          const SizedBox(height: 4),
          Text('NMID: ID9360091100241059010', style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(color: primaryPurple.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Text('Total Pembayaran', style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(_formatCurrency(totalHarga), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: primaryPurple)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          GestureDetector(
            onTap: () {
              // Simulasi jika ditekan QR-nya langsung
              _processPayment('Mendeteksi pembayaran QRIS berhasil...');
            },
            child: Container(
              width: 220, height: 220, padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.qr_code_2_rounded, size: 190, color: darkText), // Simulasi QR
            ),
          ),
          const SizedBox(height: 24),
          
          // --- TOMBOL BAGIKAN & DOWNLOAD (Memicu Simulasi Sukses) ---
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    foregroundColor: darkText,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membagikan QRIS...')));
                  },
                  child: const Text('Bagikan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // MEMICU SIMULASI SUKSES
                    _processPayment('Mendownload QRIS... Pembayaran Berhasil!');
                  },
                  child: const Text('Download', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- KARTU BANK VIRTUAL ACCOUNT ---
  Widget _buildBankVirtualAccountCard(int totalHarga, Color primaryPurple, Color darkText) {
    // Generate nomor rekening berdasarkan bank yang dipilih
    String bankName = _selectedBank ?? "Bank Transfer";
    String vaPrefix = "8077"; // Default
    if (bankName == 'BCA') vaPrefix = "3901";
    if (bankName == 'Mandiri') vaPrefix = "89508";
    if (bankName == 'BRI') vaPrefix = "2209";
    if (bankName == 'BNI') vaPrefix = "8213";
    
    String vaNumber = "$vaPrefix 0812 3456 7890";
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIconContainer(Icons.account_balance_rounded, const Color(0xFF1E293B)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bank $bankName (Virtual Account)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
                    Text('Bayar dari ATM/Mobile Banking', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.black12, height: 1),
          ),
          Text('Nomor Virtual Account', style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vaNumber,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: darkText, letterSpacing: 1.2),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: vaNumber));
                  // MEMICU SIMULASI SUKSES
                  _processPayment('Nomor VA disalin! Memproses pembayaran otomatis...');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: primaryPurple.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(Icons.copy_rounded, size: 14, color: primaryPurple),
                      const SizedBox(width: 4),
                      Text('Salin', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryPurple)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Total Pembayaran', style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(_formatCurrency(totalHarga), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: primaryPurple)),
        ],
      ),
    );
  }

  // --- KARTU E-WALLET ---
  Widget _buildEwalletCard(int totalHarga, Color primaryPurple, Color darkText) {
    String phoneLinked = "0812-****-7890";

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIconContainer(Icons.account_balance_wallet_rounded, const Color(0xFF0EA5E9)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pembayaran E-Wallet', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
                    Text('OVO, Dana, Gopay, LinkAja', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.black12, height: 1),
          ),
          Text('Nomor Terdaftar', style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            phoneLinked,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: darkText, letterSpacing: 1.5),
          ),
          const SizedBox(height: 24),
          Text('Total Pembayaran', style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(_formatCurrency(totalHarga), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: primaryPurple)),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPurple.withOpacity(0.1),
              foregroundColor: primaryPurple,
              elevation: 0,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
               // MEMICU SIMULASI SUKSES
               _processPayment('Membuka aplikasi E-Wallet... Pembayaran Berhasil!');
            },
            child: const Text('Buka Aplikasi E-Wallet', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }


  // =========================================================================
  // HELPER WIDGETS (Bottom Bar & UI Components)
  // =========================================================================

  Widget _buildSelectionBottomBar(Color primaryPurple, Color darkText) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          // Jika pengguna memilih "Transfer bank", munculkan pilihan bank dulu.
          if (_selectedPaymentMethod == 'Transfer bank') {
            _showBankSelectionSheet(primaryPurple, darkText);
          } else {
            // Jika QRIS atau E-Wallet, langsung tampilkan instruksi
            setState(() {
              _showInstructions = true;
            });
          }
        },
        child: const Text(
          'Dapatkan Kode Pembayaran',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.3),
        ),
      ),
    );
  }

  Widget _buildInstructionBottomBar(Color primaryPurple) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                foregroundColor: const Color(0xFF2D3142),
              ),
              onPressed: () {
                // Simulasi Batalkan Pesanan (Kembali ke detail)
                Navigator.pop(context);
              },
              child: const Text('Batalkan', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                // Manual Button: Simulasi sukses dan lanjut ke Konfirmasi
                _processPayment('Mengecek status pembayaran...');
              },
              child: const Text('Cek Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5)),
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
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2D3142))),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Container(
              width: 22, height: 22, padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? primaryPurple : Colors.grey.shade400, width: 1.5),
              ),
              child: isSelected ? Container(decoration: BoxDecoration(shape: BoxShape.circle, color: primaryPurple)) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon, Color bgColor) {
    return Container(
      width: 42, height: 42,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  Widget _buildStepIndicator(int stepNumber, String label, {required String status, required Color activeColor}) {
    bool isCompleted = status == 'completed';
    bool isActive = status == 'active';
    return Column(
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (isCompleted || isActive) ? activeColor : Colors.grey.shade200,
          ),
          alignment: Alignment.center,
          child: isCompleted
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
              : Text(stepNumber.toString(), style: TextStyle(color: isActive ? Colors.white : Colors.grey.shade500, fontWeight: FontWeight.bold)),
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
      width: 30, height: 1.5,
      color: isActive ? color : Colors.grey.shade200,
    );
  }
}