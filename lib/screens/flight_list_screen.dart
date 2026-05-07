import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/flight_model.dart';
import 'flight_detail_screen.dart';
import '../widgets/flight_card.dart';

class FlightListScreen extends StatefulWidget {
  final String? selectedCity;

  const FlightListScreen({super.key, this.selectedCity});

  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  List<Flight> allFlights = [
    Flight(
      id: '1',
      airline: 'Airbilly Airlines',
      flightNumber: 'AB123',
      departureCity: 'Jakarta (CGK)',
      arrivalCity: 'Bali (DPS)',
      departureTime: '08:30',
      arrivalTime: '10:45',
      duration: '2j 15m',
      price: 650000,
      seatClass: 'Economy',
      availableSeats: 120,
    ),
    Flight(
      id: '2',
      airline: 'Garuda Indonesia',
      flightNumber: 'GA456',
      departureCity: 'Jakarta (CGK)',
      arrivalCity: 'Surabaya (SUB)',
      departureTime: '14:20',
      arrivalTime: '15:40',
      duration: '1j 20m',
      price: 450000,
      seatClass: 'Economy',
      availableSeats: 85,
    ),
    Flight(
      id: '3',
      airline: 'Lion Air',
      flightNumber: 'JT789',
      departureCity: 'Bali (DPS)',
      arrivalCity: 'Makassar (UPG)',
      departureTime: '16:45',
      arrivalTime: '19:30',
      duration: '2j 45m',
      price: 580000,
      seatClass: 'Economy',
      availableSeats: 95,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /// 🔥 FILTER FIX (SUDAH AMAN)
    List<Flight> filteredFlights = widget.selectedCity == null
        ? allFlights
        : allFlights.where((f) {
            final city = widget.selectedCity!.toLowerCase();

            return f.arrivalCity.toLowerCase().contains(city) ||
                f.departureCity.toLowerCase().contains(city);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedCity ?? 'Semua Penerbangan'),
        backgroundColor: const Color(0xFF4FC3F7),
      ),
      body: Column(
        children: [
          /// 🔥 FILTER BAR
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.swap_horiz, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          widget.selectedCity ?? 'Semua Rute',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FC3F7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.tune, color: Colors.white, size: 20),
                      SizedBox(width: 4),
                      Text('Filter',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 LIST
          Expanded(
            child: filteredFlights.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada penerbangan',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredFlights.length,
                    itemBuilder: (context, index) {
                      final flight = filteredFlights[index];

                      return Animate(
                        delay: (100 * index).ms,
                        effects: const [
                          FadeEffect(),
                          SlideEffect(begin: Offset(0, 0.1)),
                        ],
                        child: FlightCard(
                          flight: flight,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    FlightDetailScreen(flight: flight),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}