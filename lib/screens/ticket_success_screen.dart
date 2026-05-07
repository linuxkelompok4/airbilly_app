import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/flight_model.dart';

class TicketSuccessScreen extends StatelessWidget {
  final Flight flight;
  final List<String> seats;
  final double total;

  const TicketSuccessScreen({
    super.key,
    required this.flight,
    required this.seats,
    required this.total,
  });

  String formatRupiah(double value) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    final ticketCode = '${flight.flightNumber}-${seats.join()}';

    return Scaffold(
      backgroundColor: const Color(0xFF4FC3F7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ✅ SUCCESS ICON
            const Icon(Icons.check_circle,
                color: Colors.white, size: 80),
            const SizedBox(height: 10),

            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // 🎟️ TICKET CARD
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    // Flight Info
                    Text(
                      '${flight.departureCity} → ${flight.arrivalCity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text('${flight.airline} • ${flight.flightNumber}'),

                    const Divider(height: 30),

                    // TIME
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        _info('Berangkat', flight.departureTime),
                        _info('Tiba', flight.arrivalTime),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // SEATS
                    _info('Kursi', seats.join(', ')),

                    const SizedBox(height: 20),

                    // QR CODE
                    QrImageView(
                      data: ticketCode,
                      size: 180,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      ticketCode,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    // PRICE
                    Text(
                      'Rp ${formatRupiah(total)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4FC3F7),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BUTTON
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FC3F7),
                        minimumSize:
                            const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Kembali ke Home',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}