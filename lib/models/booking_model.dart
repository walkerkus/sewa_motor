import 'package:intl/intl.dart';
import 'motor_model.dart';

class Booking {
  final int id;
  final Motor motor;
  final String startDate;
  final String endDate;
  final int totalPrice; // integer dari API
  final String status;
  final int durationDays;
  final String paymentMethod;
  final String pickupLocation;

  Booking({
    required this.id,
    required this.motor,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
    this.durationDays = 1,
    this.paymentMethod = '',
    this.pickupLocation = '',
  });

  /// Format harga untuk ditampilkan
  String get price {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(totalPrice);
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: (json['id'] as num).toInt(),
      motor: Motor.fromJson(json['motor'] as Map<String, dynamic>),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      totalPrice: (json['total_price'] as num).toInt(),
      status: json['status'] as String,
      durationDays: (json['duration_days'] as num?)?.toInt() ?? 1,
      paymentMethod: json['payment_method'] as String? ?? '',
      pickupLocation: json['pickup_location'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'motor': motor.toJson(),
      'start_date': startDate,
      'end_date': endDate,
      'total_price': totalPrice,
      'status': status,
      'duration_days': durationDays,
      'payment_method': paymentMethod,
      'pickup_location': pickupLocation,
    };
  }
}
