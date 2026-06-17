import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('Testing Login on Windows...');
  // Simulating ApiService.login behavior
  String baseUrl = 'http://127.0.0.1:8000/api';
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  try {
    print('Sending POST to $baseUrl/login');
    final response = await http
        .post(
          Uri.parse('$baseUrl/login'),
          headers: headers,
          body: json.encode({
            'email': 'reza.maulana@gmail.com',
            'password': 'password123'
          }),
        )
        .timeout(const Duration(seconds: 15));
        
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
    final body = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Login Success: $body');
    } else {
      final message = body['message'] ?? 'Error (${response.statusCode})';
      throw Exception(message);
    }
  } catch (e) {
    print('Caught Exception: $e');
  }
}
