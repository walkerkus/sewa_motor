import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class EditDataDiriScreen extends StatefulWidget {
  const EditDataDiriScreen({super.key});

  @override
  State<EditDataDiriScreen> createState() => _EditDataDiriScreenState();
}

class _EditDataDiriScreenState extends State<EditDataDiriScreen> {
  final Color primaryPurple = const Color(0xFF7A58E6);
  final Color darkText = const Color(0xFF2D3142);
  final Color lightBg = const Color(0xFFF4F6F9);

  // Controllers untuk input teks
  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _pekerjaanController;
  late TextEditingController _alamatController;

  String? _selectedGender;
  final List<String> _genderOptions = ['Laki-laki', 'Perempuan'];

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
    _pekerjaanController = TextEditingController();
    _alamatController = TextEditingController();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final data = await ApiService.getUser();
      final user = UserModel.fromJson(data);
      setState(() {
        _namaController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
        _dobController.text = user.birthDate;
        _pekerjaanController.text = user.occupation;
        _alamatController.text = user.address;
        _selectedGender = user.gender.isNotEmpty ? user.gender : null;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _pekerjaanController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  // Fungsi untuk memunculkan kalender bawaan Flutter
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryPurple, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: darkText, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        // Format sederhana (Bisa gunakan package intl untuk format yang lebih baik)
        _dobController.text = "${picked.day} - ${picked.month} - ${picked.year}";
      });
    }
  }

  void _simpanData() {
    // Logika untuk menyimpan data (misal: kirim ke API atau update state)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Data Diri berhasil diperbarui!'),
        backgroundColor: primaryPurple,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context); // Kembali ke halaman sebelumnya setelah simpan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      body: Stack(
        children: [
          // --- 1. BACKGROUND GRADIENT ---
          Container(
            height: 240,
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
                    'Edit Profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton(
                    onPressed: _simpanData,
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 3. KONTEN FORM SCROLL ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 120),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 70, bottom: 40, left: 24, right: 24),
                children: [
                  _buildSectionTitle('Informasi Pribadi'),
                  _buildTextField('Nama Lengkap', _namaController, Icons.person_outline_rounded),
                  _buildTextField('Email', _emailController, Icons.email_outlined, keyboardType: TextInputType.emailAddress),
                  _buildTextField('No. Telepon', _phoneController, Icons.phone_outlined, keyboardType: TextInputType.phone),
                  
                  const SizedBox(height: 16),
                  _buildSectionTitle('Detail Tambahan'),
                  
                  // Field Tanggal Lahir (Read-only, memanggil DatePicker)
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: _buildTextField('Tanggal Lahir', _dobController, Icons.calendar_today_outlined),
                    ),
                  ),

                  // Dropdown Jenis Kelamin
                  _buildDropdownGender(),

                  _buildTextField('Pekerjaan', _pekerjaanController, Icons.work_outline_rounded),
                  
                  const SizedBox(height: 16),
                  _buildSectionTitle('Alamat Lengkap'),
                  _buildTextField('Alamat Domisili', _alamatController, Icons.location_on_outlined, isMultiline: true),
                ],
              ),
            ),
          ),

          // --- 4. FLOATING AVATAR DENGAN IKON KAMERA ---
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(Icons.person_rounded, color: Colors.white, size: 45),
                    ),
                  ),
                  // Ikon Edit/Kamera kecil di pojok kanan bawah avatar
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pilih foto dari Galeri/Kamera')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryPurple,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: Judul Kategori Form ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // --- WIDGET HELPER: Text Field Kustom ---
  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isMultiline = false, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: isMultiline ? 3 : 1,
        style: TextStyle(fontSize: 15, color: darkText, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 12, bottom: 4), // Penyesuaian agar ikon pas di tengah
            child: Icon(icon, color: primaryPurple, size: 22),
          ),
          filled: true,
          fillColor: const Color(0xFFFAFBFF),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: primaryPurple, width: 1.5),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER: Dropdown Jenis Kelamin ---
  Widget _buildDropdownGender() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade500),
        decoration: InputDecoration(
          labelText: 'Jenis Kelamin',
          labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 12, bottom: 4),
            child: Icon(Icons.male_outlined, color: primaryPurple, size: 22),
          ),
          filled: true,
          fillColor: const Color(0xFFFAFBFF),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: primaryPurple, width: 1.5),
          ),
        ),
        items: _genderOptions.map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(
              gender,
              style: TextStyle(fontSize: 15, color: darkText, fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
          });
        },
      ),
    );
  }
}