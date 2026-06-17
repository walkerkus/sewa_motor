import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('Testing API Backend...');

  // 1. Create a booking
  print('\n--- 1. Create Booking ---');
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/bookings'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-User-Id': '1',
      },
      body: json.encode({
        'user_id': 1,
        'motor_id': 1,
        'start_date': '2026-06-20',
        'end_date': '2026-06-22',
        'duration_days': 2,
        'total_price': 170000,
        'payment_method': 'Transfer bank',
        'pickup_location': 'Mataram City Center (MCC)',
      }),
    );
    print('Status: ${response.statusCode}');
    print('Response: ${response.body}');
  } catch (e) {
    print('Failed to create booking: $e');
  }

  // 2. Fetch bookings
  print('\n--- 2. Fetch Bookings ---');
  try {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/bookings'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-User-Id': '1',
      },
    );
    print('Status: ${response.statusCode}');
    print('Response: ${response.body}');
  } catch (e) {
    print('Failed to fetch bookings: $e');
  }
}
