import 'package:intl/intl.dart';

class Motor {
  final int id;
  final String name;
  final String brand;
  final int pricePerDay; // Harga dalam rupiah (integer dari API)
  final double rating;
  final String category; // Nama kategori
  final String image;
  final bool isFavorite;
  // Detail lengkap dari API
  final int year;
  final int cc;
  final String transmission;
  final String fuelType;
  final String color;
  final int reviewCount;
  final String plateNumber;
  final bool isAvailable;
  final String description;

  Motor({
    required this.id,
    required this.name,
    required this.brand,
    required this.pricePerDay,
    required this.rating,
    required this.category,
    required this.image,
    this.isFavorite = false,
    this.year = 0,
    this.cc = 0,
    this.transmission = 'Matic',
    this.fuelType = 'Bensin',
    this.color = '',
    this.reviewCount = 0,
    this.plateNumber = '',
    this.isAvailable = true,
    this.description = '',
  });

  /// Format harga untuk ditampilkan: "Rp 85.000"
  String get price {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(pricePerDay);
  }

  /// Rating dalam format string "4.8"
  String get ratingStr => rating.toString();

  factory Motor.fromJson(Map<String, dynamic> json) {
    final categoryName = json['category'] is Map
        ? (json['category']['name'] as String? ?? '')
        : (json['category'] as String? ?? '');

    return Motor(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      brand: json['brand'] as String? ?? '',
      pricePerDay: (json['price'] as num).toInt(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      category: categoryName,
      image: json['image'] as String? ?? '',
      isFavorite: json['is_favorite'] as bool? ?? false,
      year: (json['year'] as num?)?.toInt() ?? 0,
      cc: (json['cc'] as num?)?.toInt() ?? 0,
      transmission: json['transmission'] as String? ?? 'Matic',
      fuelType: json['fuel_type'] as String? ?? 'Bensin',
      color: json['color'] as String? ?? '',
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      plateNumber: json['plate_number'] as String? ?? '',
      isAvailable: json['is_available'] as bool? ?? true,
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': pricePerDay,
      'rating': rating,
      'category': category,
      'image': image,
      'is_favorite': isFavorite,
    };
  }
}
