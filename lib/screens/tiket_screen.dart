import 'package:flutter/material.dart';

import '../models/booking_model.dart';

class TiketScreen extends StatelessWidget {
  final Booking booking;

  const TiketScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF), // Background terang Gen Z
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFAFBFF),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'E-Tiket Sewa',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // --- KARTU TIKET ---
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 1. Header Tiket (ID & Status)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryPurple.withOpacity(0.08), // Background ungu super halus
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID Transaksi',
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'TRX-${booking.id.toString().toUpperCase().padLeft(6, '0')}',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: darkText),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: booking.status == 'Aktif' ? primaryPurple : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            booking.status.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Info Motor
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            booking.motor.image,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.motorcycle_rounded, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.motor.name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: darkText),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 16), // Hijau sukses
                                  const SizedBox(width: 6),
                                  Text(
                                    'Sudah Dibayar',
                                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Garis Pemisah (Dashed Line) ala Tiket
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFAFBFF), // Warna sesuai background Scaffold
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                (constraints.constrainWidth() / 10).floor(),
                                (index) => Container(width: 5, height: 1.5, color: Colors.grey.shade300),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 15,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFAFBFF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 3. Detail Penyewaan
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildDetailRow('Nama Penyewa', 'Penyewa', darkText),
                        _buildDetailRow('Metode Bayar', booking.paymentMethod.isNotEmpty ? booking.paymentMethod : '-', darkText),
                        _buildDetailRow('Tanggal Sewa', '${booking.startDate} - ${booking.endDate}', darkText),
                        _buildDetailRow('Lokasi Ambil', booking.pickupLocation.isNotEmpty ? booking.pickupLocation : 'Lokasi Terdaftar', darkText),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(color: Colors.black12, height: 1),
                  ),

                  // 4. QR Code Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Tunjukkan QR ini kepada petugas',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200, width: 2),
                          ),
                          child: Icon(Icons.qr_code_2_rounded, size: 140, color: darkText),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // --- TOMBOL UNDUH TIKET ---
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tiket berhasil diunduh ke galeri!')),
                  );
                },
                icon: const Icon(Icons.download_rounded, color: Colors.white, size: 20),
                label: const Text(
                  'Unduh Tiket',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper untuk baris detail
  Widget _buildDetailRow(String label, String value, Color darkText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13, color: darkText, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}