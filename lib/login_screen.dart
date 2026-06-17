import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'services/api_service.dart';

// ============================================================================
// 1. HALAMAN LOGIN
// ============================================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    String inputEmail = _emailController.text.trim();
    String inputPassword = _passwordController.text.trim();

    if (inputEmail.isEmpty || inputPassword.isEmpty) {
      _showSnackBar('Email dan Password tidak boleh kosong!', isError: true);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await ApiService.login(inputEmail, inputPassword);
      if (result['user'] != null) {
        final name = result['user']['name'] as String? ?? '';
        _showSnackBar('Selamat datang kembali, $name!', isError: false);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
          );
        }
      } else {
        _showSnackBar('Format respons tidak valid dari server', isError: true);
      }
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      _showSnackBar(errorMsg, isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: const TextStyle(fontWeight: FontWeight.w600))),
          ],
        ),
        backgroundColor: isError ? Colors.red.shade600 : const Color(0xFF22C55E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      body: Stack(
        children: [
          // --- DEKORASI BACKGROUND ---
          Positioned(
            top: -50, right: -50,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [primaryPurple.withOpacity(0.15), Colors.transparent]),
              ),
            ),
          ),
          Positioned(
            bottom: 100, left: -80,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Colors.blueAccent.withOpacity(0.1), Colors.transparent]),
              ),
            ),
          ),

          // --- KONTEN UTAMA ---
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(color: primaryPurple.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                      child: Icon(Icons.two_wheeler_rounded, color: primaryPurple, size: 34),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Selamat Datang\nKembali! 👋',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: darkText, height: 1.3),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Silakan masuk dengan akunmu untuk\nmelanjutkan sewa motor.',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500, height: 1.5),
                    ),
                    const SizedBox(height: 40),

                    // --- FORM INPUT ---
                    _buildTextField(
                      label: 'Email',
                      hint: 'Masukkan email kamu',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'Password',
                      hint: 'Masukkan password',
                      icon: Icons.lock_outline_rounded,
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 12),

                    // Lupa Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => _showSnackBar('Fitur reset password belum tersedia.', isError: false),
                        child: Text('Lupa Password?', style: TextStyle(color: primaryPurple, fontWeight: FontWeight.w700, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- TOMBOL MASUK ---
                    SizedBox(
                      width: double.infinity, height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryPurple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          shadowColor: primaryPurple.withOpacity(0.4),
                        ),
                        onPressed: _doLogin,
                        child: const Text('Masuk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- DIVIDER SOCIAL LOGIN ---
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Atau masuk dengan', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- SOCIAL LOGIN BUTTONS ---
                    Row(
                      children: [
                        Expanded(
                          child: _buildSocialBtn(
                            iconPath: Icons.g_mobiledata_rounded, label: 'Google', color: Colors.red.shade500,
                            onTap: () {
                              setState(() {
                                _emailController.text = 'reza.maulana@gmail.com';
                                _passwordController.text = 'password123';
                              });
                              _doLogin();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSocialBtn(
                            iconPath: Icons.apple_rounded, label: 'Apple', color: Colors.black,
                            onTap: () => _showSnackBar('Login via Apple belum diimplementasi.', isError: false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // --- REGISTER LINK ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Belum punya akun? ', style: TextStyle(color: Colors.grey.shade600, fontSize: 14, fontWeight: FontWeight.w500)),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman Register (ada di bawah)
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: Text('Daftar Sekarang', style: TextStyle(color: primaryPurple, fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, required IconData icon, required TextEditingController controller, bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF2D3142))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D3142)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.w500),
              prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 22),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey.shade400, size: 20),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn({required IconData iconPath, required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconPath, color: color, size: 28),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF2D3142))),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 2. HALAMAN PENDAFTARAN (REGISTER)
// ============================================================================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _doRegister() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String password = _passwordController.text;
    String confirm = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showSnackBar('Semua data wajib diisi!', isError: true);
      return;
    }

    if (password != confirm) {
      _showSnackBar('Konfirmasi password tidak cocok!', isError: true);
      return;
    }

    // Simulasi Loading Pendaftaran
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6))),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pop(context); // Tutup loading
      _showSnackBar('Pendaftaran berhasil! Silakan masuk.', isError: false);
      
      // Kembali ke halaman Login
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pop(context); 
      });
    });
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: const TextStyle(fontWeight: FontWeight.w600))),
          ],
        ),
        backgroundColor: isError ? Colors.red.shade600 : const Color(0xFF22C55E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      body: Stack(
        children: [
          // --- DEKORASI BACKGROUND ---
          Positioned(
            top: -50, left: -50, // Posisi ditukar agar beda dengan login
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [primaryPurple.withOpacity(0.15), Colors.transparent]),
              ),
            ),
          ),
          Positioned(
            bottom: 100, right: -80,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Colors.blueAccent.withOpacity(0.1), Colors.transparent]),
              ),
            ),
          ),

          // --- KONTEN UTAMA ---
          SafeArea(
            child: Column(
              children: [
                // Header Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buat Akun Baru 🚀',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: darkText, height: 1.3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Lengkapi data dirimu di bawah ini untuk\nmemulai perjalanan seru bersama kami.',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500, height: 1.5),
                        ),
                        const SizedBox(height: 40),

                        // --- FORM INPUT ---
                        _buildTextField(
                          label: 'Nama Lengkap', hint: 'Masukkan nama sesuai KTP', icon: Icons.person_outline_rounded,
                          controller: _nameController,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          label: 'Email', hint: 'contoh: email@domain.com', icon: Icons.email_outlined,
                          controller: _emailController, keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          label: 'Nomor Telepon', hint: 'contoh: 081234567890', icon: Icons.phone_android_rounded,
                          controller: _phoneController, keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          label: 'Password', hint: 'Minimal 8 karakter', controller: _passwordController,
                          isVisible: _isPasswordVisible, onToggle: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          label: 'Konfirmasi Password', hint: 'Ulangi password di atas', controller: _confirmPasswordController,
                          isVisible: _isConfirmPasswordVisible, onToggle: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                        ),
                        const SizedBox(height: 40),

                        // --- TOMBOL DAFTAR ---
                        SizedBox(
                          width: double.infinity, height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryPurple, foregroundColor: Colors.white, elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: _doRegister,
                            child: const Text('Daftar Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // --- LOGIN LINK ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sudah punya akun? ', style: TextStyle(color: Colors.grey.shade600, fontSize: 14, fontWeight: FontWeight.w500)),
                            GestureDetector(
                              onTap: () => Navigator.pop(context), // Kembali ke form login
                              child: Text('Masuk di sini', style: TextStyle(color: primaryPurple, fontSize: 14, fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }

  // Helper form text biasa
  Widget _buildTextField({required String label, required String hint, required IconData icon, required TextEditingController controller, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF2D3142))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200, width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: TextField(
            controller: controller, keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D3142)),
            decoration: InputDecoration(
              hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.w500),
              prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 22),
              border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Helper khusus password (ada tombol mata)
  Widget _buildPasswordField({required String label, required String hint, required TextEditingController controller, required bool isVisible, required VoidCallback onToggle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF2D3142))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200, width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: TextField(
            controller: controller, obscureText: !isVisible,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D3142)),
            decoration: InputDecoration(
              hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.w500),
              prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey.shade400, size: 22),
              suffixIcon: IconButton(
                icon: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey.shade400, size: 20),
                onPressed: onToggle,
              ),
              border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}