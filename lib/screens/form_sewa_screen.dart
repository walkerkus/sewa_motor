import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/motor_model.dart';
import 'pembayaran_screen.dart'; // Buka komentar ini nanti jika halaman pembayaran sudah ada

class FormSewaScreen extends StatefulWidget {
  final Motor motor;

  const FormSewaScreen({super.key, required this.motor});

  @override
  State<FormSewaScreen> createState() => _FormSewaScreenState();
}

class _FormSewaScreenState extends State<FormSewaScreen> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 1));
  }

  // Mengambil angka harga dari string "Rp 85.000"
  int _getHargaMotor() {
    String priceStr = widget.motor.price;
    String numericOnly = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numericOnly) ?? 0;
  }

  // Format currency
  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime initialDate = isStart ? _startDate : _endDate;
    final DateTime firstDate = isStart ? DateTime.now() : _startDate.add(const Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF7A58E6), 
              onPrimary: Colors.white, 
              onSurface: Color(0xFF2D3142), 
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          // Auto-adjust end date if start date is after or equal to end date
          if (_startDate.isAfter(_endDate) || _startDate.isAtSameMomentAs(_endDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  int get _durationDays {
    final diff = _endDate.difference(_startDate).inDays;
    return diff > 0 ? diff : 1;
  }

  int get _totalHarga {
    return _getHargaMotor() * _durationDays;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6); // Ungu khas aplikasi kamu
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF), // Background terang yang sama dengan Main & Detail
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Booking',
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
                    _buildStepIndicator(1, 'Pilih Motor', isActive: true, activeColor: primaryPurple),
                    _buildStepLine(),
                    _buildStepIndicator(2, 'Detail', isActive: true, activeColor: primaryPurple),
                    _buildStepLine(),
                    _buildStepIndicator(3, 'Pembayaran', isActive: false, activeColor: primaryPurple),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),

              // --- 2. PILIH TANGGAL SECTION ---
              Text('Pilih Tanggal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDatePickerRow('Ambil', _startDate, '10:00', true),
                    const SizedBox(height: 20),
                    _buildDatePickerRow('Kembali', _endDate, '10:00', false),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- 3. LOKASI PENGAMBILAN SECTION ---
              Text('Lokasi Pengambilan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mataram City Center (MCC)',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Jl. Pejanggik No. 100, Mataram',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Action ubah lokasi
                      },
                      child: Row(
                        children: [
                          Text('Ubah', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryPurple)),
                          Icon(Icons.chevron_right_rounded, color: primaryPurple, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- 4. RINGKASAN PESANAN SECTION ---
              Text('Ringkasan Pesanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info Motor
                    Row(
                      children: [
                        Hero(
                          tag: widget.motor.name,
                          child: Image.network(
                            widget.motor.image,
                            width: 80,
                            height: 60,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.motorcycle, size: 50, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.motor.name,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkText),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${widget.motor.price} / hari',
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Durasi
                    Text('$_durationDays Hari', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
                    const SizedBox(height: 4),
                    Text('${DateFormat('dd MMM yyyy', 'id_ID').format(_startDate)} - ${DateFormat('dd MMM yyyy', 'id_ID').format(_endDate)}', style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: Colors.black12, height: 1),
                    ),
                    
                    // Total Harga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                        Text(_formatCurrency(_totalHarga), style: TextStyle(color: darkText, fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: TextStyle(color: darkText, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          _formatCurrency(_totalHarga), 
                          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.w900),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PembayaranScreen(
                  motor: widget.motor,
                  startDate: _startDate,
                  endDate: _endDate,
                  durationDays: _durationDays,
                  totalPrice: _totalHarga,
                ),
              ),
            );
          },
          child: const Text(
            'Lanjut ke Pembayaran',
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

  Widget _buildDatePickerRow(String label, DateTime date, String timeValue, bool isStart) {
    String formattedDate = DateFormat('dd MMM yyyy', 'id_ID').format(date);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            // Date Box
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => _selectDate(context, isStart),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formattedDate, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      Icon(Icons.calendar_month_rounded, size: 16, color: Colors.grey.shade500),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Time Box
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  color: Colors.grey.shade50, // Waktu saat ini statis sesuai mock
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(timeValue, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade600)),
                    Icon(Icons.access_time_rounded, size: 16, color: Colors.grey.shade400),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIndicator(int stepNumber, String label, {required bool isActive, required Color activeColor}) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeColor : Colors.grey.shade200,
          ),
          alignment: Alignment.center,
          child: isActive 
              ? Text(stepNumber.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
              : Icon(Icons.check_rounded, color: Colors.grey.shade400, size: 18), // Icon gembok/check untuk inactive
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

  Widget _buildStepLine() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      width: 40,
      height: 1.5,
      color: Colors.grey.shade200,
    );
  }
}