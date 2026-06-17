class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final bool isPremium;
  final int points;
  final double rating;
  final int totalBookings;
  final String birthDate;
  final String gender;
  final String occupation;
  final String address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.avatar = '',
    this.isPremium = false,
    this.points = 0,
    this.rating = 0.0,
    this.totalBookings = 0,
    this.birthDate = '',
    this.gender = '',
    this.occupation = '',
    this.address = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      isPremium: json['is_premium'] as bool? ?? false,
      points: (json['points'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalBookings: (json['total_bookings'] as num?)?.toInt() ?? 0,
      birthDate: json['birth_date'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      occupation: json['occupation'] as String? ?? '',
      address: json['address'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'points': points,
      'birth_date': birthDate,
      'gender': gender,
      'occupation': occupation,
      'address': address,
    };
  }
}
