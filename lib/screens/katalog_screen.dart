import 'package:flutter/material.dart';
import '../models/motor_model.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class KatalogScreen extends StatefulWidget {
  final String initialCategory;
  final bool sortByRating;

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

  bool _isLoading = true;
  String? _error;
  List<Motor> _allMotors = [];
  List<Motor> _filteredList = [];
  List<String> _categories = ['Semua'];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      setState(() { _isLoading = true; _error = null; });
      final results = await Future.wait([
        ApiService.getMotors(),
        ApiService.getCategories(),
      ]);
      final motors = results[0] as List<dynamic>;
      final cats = results[1] as List<dynamic>;

      final allMotors = motors.map((e) => Motor.fromJson(e as Map<String, dynamic>)).toList();
      final categoryNames = ['Semua', ...cats.map((c) => c['name'] as String).toList()];

      setState(() {
        _allMotors = allMotors;
        _categories = categoryNames;
        _isLoading = false;
      });
      _applyFilterAndSort();
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }

  void _applyFilterAndSort() {
    List<Motor> result = List.from(_allMotors);

    // Filter Kategori
    if (_selectedCategory != 'Semua') {
      result = result.where((m) => m.category == _selectedCategory).toList();
    }

    // Filter Pencarian
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      result = result.where((m) => m.name.toLowerCase().contains(query) || m.brand.toLowerCase().contains(query)).toList();
    }

    // Sorting
    if (widget.sortByRating) {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }

    setState(() => _filteredList = result);
  }

  void _onCategorySelected(String category) {
    setState(() => _selectedCategory = category);
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
            // --- APP BAR ---
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
                        color: Colors.grey.shade100,
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
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2))],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.tune_rounded, color: darkText, size: 20),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Filter Tambahan'))),
                    ),
                  ),
                ],
              ),
            ),

            // --- CATEGORY PILLS ---
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
                          if (isSelected) BoxShadow(color: primaryPurple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3)),
                          if (!isSelected) BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2)),
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

            // --- LIST VIEW MOTOR ---
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
                  : _error != null
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.cloud_off_rounded, size: 60, color: Colors.grey),
                              const SizedBox(height: 12),
                              Text('Gagal memuat motor', style: TextStyle(color: Colors.grey.shade600)),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _loadData,
                                style: ElevatedButton.styleFrom(backgroundColor: primaryPurple),
                                child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : _filteredList.isEmpty
                          ? Center(child: Text('Motor tidak ditemukan', style: TextStyle(color: Colors.grey.shade500)))
                          : RefreshIndicator(
                              color: primaryPurple,
                              onRefresh: _loadData,
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                itemCount: _filteredList.length,
                                itemBuilder: (context, index) {
                                  final motor = _filteredList[index];
                                  return _buildMotorCard(motor, primaryPurple, darkText);
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotorCard(Motor motor, Color primaryPurple, Color darkText) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(motor: motor)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(color: const Color(0xFFFAFBFF), borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(8),
              child: Hero(
                tag: 'motor_${motor.id}',
                child: Image.network(
                  motor.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.motorcycle, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(motor.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkText)),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(motor.price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: darkText)),
                      const Text(' / hari', style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(motor.ratingStr, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
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