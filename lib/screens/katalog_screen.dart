import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/motor_model.dart';
import 'detail_screen.dart'; // Untuk navigasi ke detail saat motor diklik

class KatalogScreen extends StatefulWidget {
  final String initialCategory;
  final bool sortByRating; // Jika true, urutkan dari bintang tertinggi

  const KatalogScreen({
    super.key,
    this.initialCategory = 'Semua',
    this.sortByRating = false,
  });

  @override
  State<KatalogScreen> createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  late String _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  
  List<Motor> _filteredList = [];
  final List<String> _categories = ['Semua', 'Matic', 'Sport', 'Retro', 'Listrik'];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _applyFilterAndSort();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Logika Filter & Sorting
  void _applyFilterAndSort() {
    List<Motor> result = List.from(DummyData.motors);

    // 1. Filter Kategori
    if (_selectedCategory != 'Semua') {
      result = result.where((motor) => motor.category == _selectedCategory).toList();
    }

    // 2. Filter Pencarian Teks
    String query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      result = result.where((motor) => motor.name.toLowerCase().contains(query)).toList();
    }

    // 3. Sorting berdasarkan Bintang (Jika diminta via widget.sortByRating)
    if (widget.sortByRating) {
      result.sort((a, b) {
        double ratingA = double.tryParse(a.rating) ?? 0.0;
        double ratingB = double.tryParse(b.rating) ?? 0.0;
        return ratingB.compareTo(ratingA); // Descending (Tertinggi di atas)
      });
    }

    setState(() {
      _filteredList = result;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _applyFilterAndSort();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      body: SafeArea(
        child: Column(
          children: [
            // --- 1. APP BAR CUSTOM (Back, Search, Filter) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100, // Abu-abu terang sesuai gambar
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => _applyFilterAndSort(),
                        decoration: InputDecoration(
                          hintText: 'Cari motor...',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400, size: 20),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.tune_rounded, color: darkText, size: 20),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Filter Tambahan')));
                      },
                    ),
                  ),
                ],
              ),
            ),

            // --- 2. CATEGORY PILLS ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: _categories.map((category) {
                  bool isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () => _onCategorySelected(category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryPurple : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(color: primaryPurple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3)),
                          if (!isSelected)
                            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : darkText,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // --- 3. LIST VIEW MOTOR ---
            Expanded(
              child: _filteredList.isEmpty
                  ? Center(
                      child: Text('Motor tidak ditemukan', style: TextStyle(color: Colors.grey.shade500)),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: _filteredList.length,
                      itemBuilder: (context, index) {
                        final motor = _filteredList[index];
                        return _buildMotorCard(motor, primaryPurple, darkText);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper: Kartu Motor List Vertical
  Widget _buildMotorCard(Motor motor, Color primaryPurple, Color darkText) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(motor: motor)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
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
          children: [
            // Gambar Motor
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFF),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: Hero(
                tag: motor.name,
                child: Image.network(
                  motor.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.motorcycle, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Detail Motor
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    motor.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkText),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        motor.price,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: darkText),
                      ),
                      const Text(
                        ' / hari',
                        style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        motor.rating,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Kolom Kanan (Favorite & Titik 3)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  motor.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: motor.isFavorite ? primaryPurple : Colors.grey.shade400,
                  size: 22,
                ),
                const SizedBox(height: 30),
                Icon(Icons.more_vert_rounded, color: Colors.grey.shade300, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}