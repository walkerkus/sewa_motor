import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/api_service.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key});

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  final Color darkText = const Color(0xFF2D3142);

  bool _isLoading = true;
  String? _error;
  List<NotificationModel> _notifikasiList = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      setState(() { _isLoading = true; _error = null; });
      final data = await ApiService.getNotifications();
      setState(() {
        _notifikasiList = data.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }

  IconData _getIcon(String type) {
    if (type == 'Pembayaran') return Icons.check_circle_rounded;
    if (type == 'Promo') return Icons.local_offer_rounded;
    if (type == 'Booking') return Icons.alarm_rounded;
    return Icons.system_update_rounded;
  }

  Color _getColor(String type) {
    if (type == 'Pembayaran') return const Color(0xFF22C55E);
    if (type == 'Promo') return const Color(0xFFF59E0B);
    if (type == 'Booking') return const Color(0xFFEF4444);
    return const Color(0xFF64748B);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifikasi',
          style: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.cloud_off_rounded, size: 60, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text('Gagal memuat notifikasi', style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadNotifications,
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7A58E6)),
                        child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                )
              : _notifikasiList.isEmpty
                  ? Center(child: Text('Belum ada notifikasi.', style: TextStyle(color: Colors.grey.shade500)))
                  : RefreshIndicator(
                      color: const Color(0xFF7A58E6),
                      onRefresh: _loadNotifications,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        itemCount: _notifikasiList.length,
                        itemBuilder: (context, index) {
                          final notif = _notifikasiList[index];
                          return _buildNotificationCard(
                            title: notif.title,
                            body: notif.description,
                            time: notif.time,
                            icon: _getIcon(notif.type),
                            color: _getColor(notif.type),
                          );
                        },
                      ),
                    ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String body,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}