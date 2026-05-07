import 'flight_model.dart';

class Booking {
  final Flight flight;
  final List<String> seats;
  final double total;
  final DateTime date;

  Booking({
    required this.flight,
    required this.seats,
    required this.total,
    required this.date,
  });
}

/// 🔥 GLOBAL STORAGE (SIMPLE)
List<Booking> bookingHistory = [];