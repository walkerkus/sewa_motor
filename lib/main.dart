import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

// Import halaman-halaman yang dibutuhkan
import 'login_screen.dart'; // Import halaman Login

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const SewaMotorAppPremium());
}

class SewaMotorAppPremium extends StatelessWidget {
  const SewaMotorAppPremium({super.key});

  @override
  Widget build(BuildContext context) {
    // Pengaturan status bar agar terlihat clean
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // Ubah ke dark jika background Login terang
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sewa Motor Premium',
      theme: ThemeData(
        fontFamily: 'Inter',
        // Mengatur warna utama ungu Gen Z yang kita gunakan di seluruh aplikasi
        primaryColor: const Color(0xFF7A58E6), 
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A58E6)),
      ),
      // MENGARAHKAN KE LOGIN SCREEN SEBAGAI HALAMAN PERTAMA
      home: const LoginScreen(), 
    );
  }
}