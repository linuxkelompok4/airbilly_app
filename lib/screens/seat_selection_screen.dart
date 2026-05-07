import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../widgets/seat_widget.dart';
import 'payment_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Flight flight;

  const SeatSelectionScreen({super.key, required this.flight});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<String> selectedSeats = [];

  final Map<String, bool> seats = {
    for (var row = 1; row <= 6; row++)
      for (var col in ['A', 'B', 'C', 'D', 'E', 'F'])
        '$col$row': (row == 2 && (col == 'B' || col == 'E')) ||
            (row == 4 && (col == 'A' || col == 'C' || col == 'F'))
  };

  void toggleSeat(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else if (!(seats[seat] ?? false)) {
        selectedSeats.add(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.flight.price * selectedSeats.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kursi'),
        backgroundColor: const Color(0xFF4FC3F7),
      ),
      body: Column(
        children: [
          // 🔥 HEADER INFO
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  '${selectedSeats.length} kursi dipilih',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Total: Rp ${totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFF4FC3F7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🔥 LEGEND
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _Legend(color: Colors.green, label: 'Available'),
              _Legend(color: Color(0xFF4FC3F7), label: 'Selected'),
              _Legend(color: Colors.grey, label: 'Booked'),
            ],
          ),

          const SizedBox(height: 20),

          // ✈️ AIRPLANE BODY
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: List.generate(6, (rowIndex) {
                  final row = rowIndex + 1;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // LEFT SIDE (A B C)
                        ...['A', 'B', 'C'].map((col) {
                          final seat = '$col$row';
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: SeatWidget(
                              seatNumber: seat,
                              isBooked: seats[seat] ?? false,
                              isSelected: selectedSeats.contains(seat),
                              onTap: () => toggleSeat(seat),
                            ),
                          );
                        }),

                        // ✨ AISLE (LORONG)
                        Container(
                          width: 30,
                          alignment: Alignment.center,
                          child: Text(
                            row.toString(),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // RIGHT SIDE (D E F)
                        ...['D', 'E', 'F'].map((col) {
                          final seat = '$col$row';
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: SeatWidget(
                              seatNumber: seat,
                              isBooked: seats[seat] ?? false,
                              isSelected: selectedSeats.contains(seat),
                              onTap: () => toggleSeat(seat),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),

      // 🔥 BOTTOM BUTTON
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: selectedSeats.isEmpty
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(
                        flight: widget.flight,
                        selectedSeats: selectedSeats,
                        totalPrice: totalPrice,
                      ),
                    ),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4FC3F7),
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Lanjut (${selectedSeats.length} Kursi)',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}