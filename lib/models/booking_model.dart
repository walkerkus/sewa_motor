import 'motor_model.dart';

class Booking {
  final String id;
  final Motor motor;
  final String startDate;
  final String endDate;
  final String price;
  final String status; // 'Aktif', 'Selesai', 'Dibatalkan'

  Booking({
    required this.id,
    required this.motor,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      motor: Motor.fromJson(json['motor']),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      price: json['price'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'motor': motor.toJson(),
      'startDate': startDate,
      'endDate': endDate,
      'price': price,
      'status': status,
    };
  }
}
