import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import app kamu
import 'package:airbilly_app/main.dart';

void main() {
  testWidgets('Airbilly App basic navigation test', (WidgetTester tester) async {
    
    // Build app
    await tester.pumpWidget(const AirbillyApp());

    // Tunggu render selesai
    await tester.pumpAndSettle();

    // ===============================
    // TEST 1: Pastikan Home muncul
    // ===============================
    expect(find.text('Cari Penerbangan'), findsOneWidget);

    // ===============================
    // TEST 2: Klik tombol cari flight
    // ===============================
    await tester.tap(find.text('Cari Penerbangan'));
    await tester.pumpAndSettle();

    // Pastikan masuk ke halaman flight list
    expect(find.text('Daftar Penerbangan'), findsOneWidget);

    // ===============================
    // TEST 3: Klik salah satu flight
    // ===============================
    await tester.tap(find.textContaining('→').first);
    await tester.pumpAndSettle();

    // Pastikan masuk ke detail
    expect(find.text('Pilih Seat'), findsOneWidget);

    // ===============================
    // TEST 4: Masuk ke seat page
    // ===============================
    await tester.tap(find.text('Pilih Seat'));
    await tester.pumpAndSettle();

    expect(find.text('Seat'), findsOneWidget);

    // ===============================
    // TEST 5: Pilih seat & checkout
    // ===============================
    await tester.tap(find.text('S1'));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();

    expect(find.text('Checkout'), findsOneWidget);

    // ===============================
    // TEST 6: Klik bayar
    // ===============================
    await tester.tap(find.text('Bayar'));
    await tester.pump();

    // Cek snackbar muncul
    expect(find.text('Booking Berhasil'), findsOneWidget);

  });
}