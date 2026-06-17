import 'package:flutter/material.dart';
import '../models/voucher_model.dart';
import '../models/point_history_model.dart';
import '../services/api_service.dart';

class PoinVoucherScreen extends StatefulWidget {
  const PoinVoucherScreen({super.key});

  @override
  State<PoinVoucherScreen> createState() => _PoinVoucherScreenState();
}

class _PoinVoucherScreenState extends State<PoinVoucherScreen> {
  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF4F6F9);

  bool _isLoading = true;
  int _totalPoin = 0;
  List<VoucherModel> _vouchers = [];
  List<PointHistoryModel> _histories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() => _isLoading = true);
      final results = await Future.wait([
        ApiService.getUser(),
        ApiService.getVouchers(),
        ApiService.getPointHistories(),
      ]);
      final user = results[0] as Map<String, dynamic>;
      final vouchers = results[1] as List<dynamic>;
      final histories = results[2] as List<dynamic>;

      setState(() {
        _totalPoin = (user['points'] as num?)?.toInt() ?? 0;
        _vouchers = vouchers.map((e) => VoucherModel.fromJson(e as Map<String, dynamic>)).toList();
        _histories = histories.map((e) => PointHistoryModel.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: lightBg,
        body: Stack(
          children: [
            // --- BACKGROUND GRADIENT ---
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

            // --- HEADER ---
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Text(
                      'Poin & Voucher',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),

            // --- KONTEN UTAMA ---
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
                child: _isLoading
                    ? const Center(child: Padding(padding: EdgeInsets.all(80), child: CircularProgressIndicator(color: Color(0xFF7A58E6))))
                    : Column(
                        children: [
                          // --- KARTU TOTAL POIN ---
                          Transform.translate(
                            offset: const Offset(0, -30),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.15), blurRadius: 25, offset: const Offset(0, 10))],
                                  border: Border.all(color: primaryPurple.withOpacity(0.1), width: 1.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Total Poin Saat Ini', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), shape: BoxShape.circle),
                                              child: const Icon(Icons.stars_rounded, color: Colors.amber, size: 24),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              _totalPoin.toString(),
                                              style: TextStyle(color: darkText, fontSize: 28, fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(colors: [Color(0xFF5B42D1), Color(0xFF7A58E6)]),
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        ),
                                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Buka halaman Tukar Poin'))),
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
                              tabs: const [Tab(text: 'Voucher Ku'), Tab(text: 'Riwayat Poin')],
                            ),
                          ),

                          // --- TAB CONTENT ---
                          Expanded(
                            child: Container(
                              color: lightBg,
                              child: TabBarView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  // TAB 1: VOUCHER
                                  _vouchers.isEmpty
                                      ? Center(child: Text('Belum ada voucher.', style: TextStyle(color: Colors.grey.shade500)))
                                      : ListView.builder(
                                          padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: _vouchers.length,
                                          itemBuilder: (context, index) => _buildTicketVoucher(_vouchers[index]),
                                        ),

                                  // TAB 2: RIWAYAT POIN
                                  _histories.isEmpty
                                      ? Center(child: Text('Belum ada riwayat poin.', style: TextStyle(color: Colors.grey.shade500)))
                                      : ListView.builder(
                                          padding: const EdgeInsets.only(top: 20, bottom: 40, left: 24, right: 24),
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: _histories.length,
                                          itemBuilder: (context, index) => _buildRiwayatPoinItem(_histories[index]),
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

  Widget _buildTicketVoucher(VoucherModel data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 140,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: primaryPurple.withOpacity(0.05),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: primaryPurple.withOpacity(0.15), shape: BoxShape.circle),
                      child: Icon(Icons.percent_rounded, color: primaryPurple, size: 30),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      15,
                      (_) => SizedBox(width: 1, height: 4, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade300))),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(data.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkText, height: 1.2), maxLines: 2, overflow: TextOverflow.ellipsis),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber.shade200)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.stars_rounded, color: Colors.amber, size: 12),
                                  const SizedBox(width: 4),
                                  Text("${data.pointsCost} Pts", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.amber)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(data.description, style: TextStyle(fontSize: 11, color: Colors.grey.shade500, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded, size: 14, color: Colors.red.shade400),
                                const SizedBox(width: 4),
                                Text(data.expiryDate, style: TextStyle(fontSize: 11, color: Colors.red.shade400, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            InkWell(
                              onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Menukar ${data.pointsCost} poin untuk ${data.title}'))),
                              child: Text('Tukar', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: primaryPurple)),
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
          Positioned(top: -10, left: 90, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: lightBg, shape: BoxShape.circle))),
          Positioned(bottom: -10, left: 90, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: lightBg, shape: BoxShape.circle))),
        ],
      ),
    );
  }

  Widget _buildRiwayatPoinItem(PointHistoryModel data) {
    final bool isPemasukan = data.isEarned;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPemasukan ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(isPemasukan ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded, color: isPemasukan ? Colors.green : Colors.red, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
                const SizedBox(height: 4),
                Text(data.date, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
              ],
            ),
          ),
          Text(
            (isPemasukan ? '+' : '-') + data.points.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isPemasukan ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}