class VoucherModel {
  final int id;
  final String title;
  final String description;
  final String expiryDate;
  final int discountPercentage;
  final int pointsCost;
  final bool isActive;

  VoucherModel({
    required this.id,
    required this.title,
    required this.description,
    required this.expiryDate,
    required this.discountPercentage,
    required this.pointsCost,
    this.isActive = true,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      expiryDate: json['expiry_date'] as String,
      discountPercentage: (json['discount_percent'] as num?)?.toInt() ?? 0,
      pointsCost: (json['points_cost'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'expiry_date': expiryDate,
      'discount_percent': discountPercentage,
      'points_cost': pointsCost,
      'is_active': isActive,
    };
  }
}
