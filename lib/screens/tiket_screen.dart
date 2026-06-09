import 'package:flutter/material.dart';

class TiketScreen extends StatelessWidget {
  final String namaMotor;
  final String tanggal;
  final String imageUrl;

  const TiketScreen({
    super.key,
    required this.namaMotor,
    required this.tanggal,
    required this.imageUrl,
  });

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
          'E-Tiket Sewa',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            // --- KARTU TIKET ---
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                      color: const Color(0xFF1D63DC).withOpacity(0.05),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ID Transaksi',
                              style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'TRX-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}', // Generate ID Dummy
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.black87),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D63DC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'AKTIF',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.motorcycle_rounded, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                namaMotor,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                              ),
                              const SizedBox(height: 6),
                              const Row(
                                children: [
                                  Icon(Icons.check_circle, color: Color(0xFF4ade80), size: 14),
                                  SizedBox(width: 6),
                                  Text(
                                    'Sudah Dibayar',
                                    style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Garis Pemisah ala Tiket
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FAFC),
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
                                (constraints.constrainWidth() / 8).floor(),
                                (index) => Container(width: 4, height: 1.5, color: Colors.grey.shade300),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 15,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FAFC),
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
                        _buildDetailRow('Nama Penyewa', 'Akbar'),
                        _buildDetailRow('Nomor Telepon', '081253636885'),
                        _buildDetailRow('Tanggal Sewa', tanggal),
                        _buildDetailRow('Lokasi Ambil', 'Cabang Surakarta'),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(color: Colors.black12, height: 1),
                  ),

                  // 4. QR Code Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          'Tunjukkan QR ini kepada petugas',
                          style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: const Icon(Icons.qr_code_2_rounded, size: 120, color: Colors.black87),
                        ),
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
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D63DC),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk baris detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}