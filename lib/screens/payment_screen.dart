import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../models/booking_model.dart';
import '../widgets/payment_method_card.dart';

class PaymentScreen extends StatefulWidget {
  final Flight flight;
  final List<String> selectedSeats;
  final double totalPrice;

  const PaymentScreen({
    super.key,
    required this.flight,
    required this.selectedSeats,
    required this.totalPrice,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'gopay';

  String formatRupiah(double value) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFF),

      /// 🔵 APPBAR
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: const Color(0xFF4FC3F7),
        elevation: 0,
      ),

      /// 🔵 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// 🔥 ORDER CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle,
                      color: Colors.white, size: 40),

                  const SizedBox(height: 10),

                  const Text(
                    'Booking Berhasil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    '${widget.flight.departureCity} → ${widget.flight.arrivalCity}',
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${widget.flight.airline} • ${widget.flight.flightNumber}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔥 DETAIL HARGA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _row('Kursi', widget.selectedSeats.join(', ')),
                  _row('Jumlah', '${widget.selectedSeats.length} kursi'),

                  const Divider(height: 24),

                  _row(
                    'Harga',
                    'Rp ${formatRupiah(widget.flight.price)}',
                  ),

                  _row(
                    'Biaya Layanan',
                    'Rp 25,000',
                    isGrey: true,
                  ),

                  const Divider(height: 24),

                  _row(
                    'Total',
                    'Rp ${formatRupiah(widget.totalPrice)}',
                    isBold: true,
                    isBlue: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔥 PAYMENT METHOD
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            PaymentMethodCard(
              title: 'GoPay',
              icon: Icons.account_balance_wallet,
              isSelected: selectedMethod == 'gopay',
              onTap: () => setState(() => selectedMethod = 'gopay'),
            ),

            PaymentMethodCard(
              title: 'Bank BCA',
              icon: Icons.account_balance,
              isSelected: selectedMethod == 'bca',
              onTap: () => setState(() => selectedMethod = 'bca'),
            ),

            PaymentMethodCard(
              title: 'Bank BRI',
              icon: Icons.credit_card,
              isSelected: selectedMethod == 'bri',
              onTap: () => setState(() => selectedMethod = 'bri'),
            ),
          ],
        ),
      ),

      /// 🔥 BUTTON BAYAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ElevatedButton(
          onPressed: () {
            /// 🔥 SIMPAN KE HISTORY
            bookingHistory.add(
              Booking(
                flight: widget.flight,
                seats: widget.selectedSeats,
                total: widget.totalPrice,
                date: DateTime.now(),
              ),
            );

            /// 🔥 NOTIF
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎉 Pembayaran berhasil!'),
                backgroundColor: Colors.green,
              ),
            );

            /// 🔥 KEMBALI KE HOME
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4FC3F7),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Bayar Sekarang',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// 🔧 HELPER ROW
  Widget _row(String title, String value,
      {bool isBold = false, bool isGrey = false, bool isBlue = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isGrey ? Colors.grey : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: isBlue ? const Color(0xFF4FC3F7) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}