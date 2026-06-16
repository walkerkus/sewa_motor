import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/voucher_model.dart';
import '../models/point_history_model.dart';

class PoinVoucherScreen extends StatefulWidget {
  const PoinVoucherScreen({super.key});

  @override
  State<PoinVoucherScreen> createState() => _PoinVoucherScreenState();
}

class _PoinVoucherScreenState extends State<PoinVoucherScreen> {
  // --- DATA DUMMY ---
  final int totalPoin = DummyData.currentUser.points;
  final List<VoucherModel> dummyVouchers = DummyData.vouchers;
  final List<PointHistoryModel> dummyRiwayat = DummyData.pointHistories;

  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF4F6F9);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 2 Tab: Voucher dan Riwayat
      child: Scaffold(
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
                      'Poin & Voucher',
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
                    // --- KARTU TOTAL POIN (Desain Baru yang Terang & Clean) ---
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: primaryPurple.withOpacity(0.15),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            border: Border.all(color: primaryPurple.withOpacity(0.1), width: 1.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Poin Saat Ini',
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.stars_rounded, color: Colors.amber, size: 24),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        totalPoin.toString(),
                                        style: TextStyle(
                                          color: darkText,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF5B42D1), Color(0xFF7A58E6)],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent, // Transparan agar gradient terlihat
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Buka halaman Tukar Poin')),
                                    );
                                  },
                                  child: const Text('Tukar Poin', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // --- TAB BAR ---
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: TabBar(
                        labelColor: primaryPurple,
                        unselectedLabelColor: Colors.grey.shade500,
                        indicatorColor: primaryPurple,
                        indicatorWeight: 3,
                        indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
                        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        tabs: const [
                          Tab(text: 'Voucher Ku'),
                          Tab(text: 'Riwayat Poin'),
                        ],
                      ),
                    ),

                    // --- TAB BAR VIEW (Isi Konten) ---
                    Expanded(
                      child: Container(
                        color: lightBg, // Latar belakang abu muda agar kartu putih terlihat jelas
                        child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // TAB 1: DAFTAR VOUCHER (Desain Tiket)
                            ListView.builder(
                              padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
                              physics: const BouncingScrollPhysics(),
                              itemCount: dummyVouchers.length,
                              itemBuilder: (context, index) {
                                return _buildTicketVoucher(dummyVouchers[index]);
                              },
                            ),

                            // TAB 2: RIWAYAT POIN
                            ListView.builder(
                              padding: const EdgeInsets.only(top: 20, bottom: 40, left: 24, right: 24),
                              physics: const BouncingScrollPhysics(),
                              itemCount: dummyRiwayat.length,
                              itemBuilder: (context, index) {
                                return _buildRiwayatPoinItem(dummyRiwayat[index]);
                              },
                            ),
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
      ),
    );
  }

  // --- WIDGET HELPER: Bentuk Tiket Voucher yang Sangat Rapi ---
  Widget _buildTicketVoucher(VoucherModel data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 140, // Tinggi fix tiket
      child: Stack(
        children: [
          // 1. Badan Tiket Utama
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Bagian Kiri (Area Ikon)
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: primaryPurple.withOpacity(0.05),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: primaryPurple.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.percent_rounded, color: primaryPurple, size: 30),
                      ),
                    ),
                ),

                // Garis Putus-putus Pemisah (Dashed Line)
                SizedBox(
                  width: 1,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      15,
                      (_) => SizedBox(
                        width: 1,
                        height: 4,
                        child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade300)),
                      ),
                    ),
                  ),
                ),

                // Bagian Kanan (Info Teks & Tombol Tukar)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Judul & Harga Poin
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                data.title,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkText, height: 1.2),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.amber.shade200),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.stars_rounded, color: Colors.amber, size: 12),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${data.pointsCost} Pts",
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.amber),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        // Deskripsi
                        Text(
                          data.description,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade500, height: 1.3),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Validasi & Tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded, size: 14, color: Colors.red.shade400),
                                const SizedBox(width: 4),
                                Text(
                                  data.expiryDate,
                                  style: TextStyle(fontSize: 11, color: Colors.red.shade400, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Menukar ${data.pointsCost} poin untuk ${data.title}')),
                                );
                              },
                              child: Text(
                                'Tukar',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: primaryPurple),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Lingkaran Pemotong Atas (Untuk efek tiket)
          Positioned(
            top: -10,
            left: 90, // Berada pas di atas garis putus-putus
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: lightBg, // Warna disamakan dengan background list
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 3. Lingkaran Pemotong Bawah (Untuk efek tiket)
          Positioned(
            bottom: -10,
            left: 90,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: lightBg, // Warna disamakan dengan background list
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: Item Riwayat Poin ---
  Widget _buildRiwayatPoinItem(PointHistoryModel data) {
    bool isPemasukan = data.isEarned;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPemasukan ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPemasukan ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              color: isPemasukan ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText),
                ),
                const SizedBox(height: 4),
                Text(
                  data.date,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Text(
            (isPemasukan ? '+' : '-') + data.points.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isPemasukan ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}