import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const AirbillyApp());
}

class AirbillyApp extends StatelessWidget {
  const AirbillyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airbilly App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF4FC3F7),
        scaffoldBackgroundColor: const Color(0xFFF8FDFF),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const WelcomeScreen(), // ✅ buka welcome dulu
    );
  }
}