import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL menyesuaikan platform (Android Emulator vs Windows/Web)
  static String get _baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api';
    } else {
      return 'http://127.0.0.1:8000/api';
    }
  }

  // User ID yang sedang login (awalnya null/1, di-set saat login)
  static int currentUserId = 1;

  // Header default untuk setiap request
  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-User-Id': currentUserId.toString(),
      };

  // =============================================
  // GENERIC HTTP METHODS
  // =============================================

  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl$endpoint'), headers: _headers)
          .timeout(const Duration(seconds: 15));
      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Pastikan server Laravel sedang berjalan.');
    } on HttpException {
      throw Exception('Terjadi kesalahan pada server.');
    } catch (e) {
      if (e.toString().contains('Exception: ')) {
        rethrow;
      }
      throw Exception('Gagal terhubung ke server: $e');
    }
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl$endpoint'),
            headers: _headers,
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 15));
      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      if (e.toString().contains('Exception: ')) {
        rethrow;
      }
      throw Exception('Gagal mengirim data: $e');
    }
  }

  static Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .put(
            Uri.parse('$_baseUrl$endpoint'),
            headers: _headers,
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 15));
      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      if (e.toString().contains('Exception: ')) {
        rethrow;
      }
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final body = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      final message = body['message'] ?? 'Terjadi kesalahan pada server (${response.statusCode})';
      throw Exception(message);
    }
  }

  // =============================================
  // MOTORS
  // =============================================

  static Future<List<dynamic>> getMotors({String? category, String? search}) async {
    String endpoint = '/motors';
    final params = <String, String>{};
    if (category != null && category != 'Semua') params['category'] = category;
    if (search != null && search.isNotEmpty) params['search'] = search;
    if (params.isNotEmpty) {
      endpoint += '?${Uri(queryParameters: params).query}';
    }
    final res = await get(endpoint);
    return res['data'] as List<dynamic>;
  }

  static Future<Map<String, dynamic>> getMotorDetail(int id) async {
    final res = await get('/motors/$id');
    return res['data'] as Map<String, dynamic>;
  }

  // =============================================
  // CATEGORIES
  // =============================================

  static Future<List<dynamic>> getCategories() async {
    final res = await get('/categories');
    return res['data'] as List<dynamic>;
  }

  // =============================================
  // BOOKINGS
  // =============================================

  static Future<List<dynamic>> getBookings() async {
    final res = await get('/bookings');
    return res['data'] as List<dynamic>;
  }

  static Future<Map<String, dynamic>> createBooking({
    required int motorId,
    required String startDate,
    required String endDate,
    required int durationDays,
    required int totalPrice,
    String? paymentMethod,
    String? pickupLocation,
  }) async {
    final res = await post('/bookings', {
      'user_id': currentUserId,
      'motor_id': motorId,
      'start_date': startDate,
      'end_date': endDate,
      'duration_days': durationDays,
      'total_price': totalPrice,
      'payment_method': paymentMethod,
      'pickup_location': pickupLocation,
    });
    return res['data'] as Map<String, dynamic>;
  }

  // =============================================
  // MESSAGES & CHATS
  // =============================================

  static Future<List<dynamic>> getMessages() async {
    final res = await get('/messages');
    return res['data'] as List<dynamic>;
  }

  static Future<List<dynamic>> getChatDetails(int messageId) async {
    final res = await get('/messages/$messageId/chats');
    return res['data'] as List<dynamic>;
  }

  static Future<Map<String, dynamic>> sendChat(int messageId, String text) async {
    final res = await post('/messages/$messageId/chats', {
      'text': text,
      'is_me': true,
    });
    return res['data'] as Map<String, dynamic>;
  }

  // =============================================
  // NOTIFICATIONS
  // =============================================

  static Future<List<dynamic>> getNotifications() async {
    final res = await get('/notifications');
    return res['data'] as List<dynamic>;
  }

  // =============================================
  // VOUCHERS
  // =============================================

  static Future<List<dynamic>> getVouchers() async {
    final res = await get('/vouchers');
    return res['data'] as List<dynamic>;
  }

  // =============================================
  // POINT HISTORIES
  // =============================================

  static Future<List<dynamic>> getPointHistories() async {
    final res = await get('/point-histories');
    return res['data'] as List<dynamic>;
  }

  // =============================================
  // FAQS
  // =============================================

  static Future<List<dynamic>> getFaqs() async {
    final res = await get('/faqs');
    return res['data'] as List<dynamic>;
  }

  // =============================================
  // APP INFO (Terms & Privacy)
  // =============================================

  static Future<List<dynamic>> getTerms() async {
    final res = await get('/app-info/terms');
    return res['data'] as List<dynamic>;
  }

  static Future<List<dynamic>> getPrivacy() async {
    final res = await get('/app-info/privacy');
    return res['data'] as List<dynamic>;
  }

  // =============================================
  // USER PROFILE
  // =============================================

  static Future<Map<String, dynamic>> getUser() async {
    final res = await get('/user');
    return res['data'] as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> updateUser(Map<String, dynamic> data) async {
    final res = await put('/user', data);
    return res['data'] as Map<String, dynamic>;
  }

  static Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    await post('/user/change-password', {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirm': newPasswordConfirm,
    });
  }

  // =============================================
  // AUTH
  // =============================================

  /// Login menggunakan email & password.
  /// Return Map berisi 'user' jika berhasil, null jika gagal kredensial.
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await post('/login', {
      'email': email,
      'password': password,
    });
    if (res['user'] != null && res['user']['id'] != null) {
      currentUserId = res['user']['id'];
    }
    return res;
  }
}
