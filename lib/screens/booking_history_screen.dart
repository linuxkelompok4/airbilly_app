import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/booking_model.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});
  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}
class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  String formatRupiah(double value) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pemesanan'),
        backgroundColor: const Color(0xFF4FC3F7),
      ),
      body: bookingHistory.isEmpty
          ? _emptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) {
                final booking = bookingHistory[index];

                return Animate(
                  delay: (100 * index).ms,
                  effects: const [
                    FadeEffect(),
                    SlideEffect(begin: Offset(0, 0.1)),
                  ],
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ROUTE
                        Text(
                          '${booking.flight.departureCity} → ${booking.flight.arrivalCity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// AIRLINE
                        Text(
                          '${booking.flight.airline} • ${booking.flight.flightNumber}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),

                        const SizedBox(height: 10),

                        /// SEATS
                        Text(
                          'Kursi: ${booking.seats.join(', ')}',
                        ),

                        const SizedBox(height: 10),

                        /// TOTAL
                        Text(
                          'Total: Rp ${formatRupiah(booking.total)}',
                          style: const TextStyle(
                            color: Color(0xFF4FC3F7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Animate(
            effects: const [FadeEffect(), ScaleEffect()],
            child: Icon(
              Icons.flight_takeoff,
              size: 120,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Belum ada riwayat pemesanan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pesan tiket pertama Anda sekarang!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}