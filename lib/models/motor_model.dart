class Motor {
  final String id;
  final String name;
  final String price; // Boleh String, tapi disarankan int di backend. Untuk mockup kita pertahankan formatnya.
  final String rating;
  final String category;
  final String image;
  final bool isFavorite;

  Motor({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.category,
    required this.image,
    required this.isFavorite,
  });

  // Untuk keperluan konversi JSON
  factory Motor.fromJson(Map<String, dynamic> json) {
    return Motor(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      rating: json['rating'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'rating': rating,
      'category': category,
      'image': image,
      'isFavorite': isFavorite,
    };
  }
}
