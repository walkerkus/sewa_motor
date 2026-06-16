class VoucherModel {
  final String id;
  final String code;
  final String title;
  final String description;
  final String expiryDate;
  final int discountPercentage;
  final int pointsCost;

  VoucherModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.expiryDate,
    required this.discountPercentage,
    required this.pointsCost,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      expiryDate: json['expiryDate'] as String,
      discountPercentage: json['discountPercentage'] as int,
      pointsCost: json['pointsCost'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'expiryDate': expiryDate,
      'discountPercentage': discountPercentage,
      'pointsCost': pointsCost,
    };
  }
}
