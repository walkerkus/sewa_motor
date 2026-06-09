import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import halaman utama yang sudah dipisah filenya
import 'screens/main_screen.dart'; 

void main() {
  runApp(const SewaMotorAppPremium());
}

class SewaMotorAppPremium extends StatelessWidget {
  const SewaMotorAppPremium({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: const Color(0xFF1D63DC),
      ),
      home: const MainScreen(), // Memanggil MainScreen dari file terpisah
    );
  }
}