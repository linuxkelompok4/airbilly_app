class Flight {
  final String id;
  final String airline;
  final String flightNumber;
  final String departureCity;
  final String arrivalCity;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final String seatClass;
  final int availableSeats;

  Flight({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.seatClass,
    required this.availableSeats,
  });
}