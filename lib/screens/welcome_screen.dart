import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
void initState() {
  super.initState();

  Future.delayed(const Duration(seconds: 3), () {
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const LoginScreen(),
  ),
);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FC3F7),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ✈️ ICON / LOGO
            Animate(
              effects: const [
                FadeEffect(duration: Duration(milliseconds: 800)),
                ScaleEffect(begin: Offset(0.5, 0.5)),
              ],
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flight_takeoff,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// TITLE
            Animate(
              delay: 300.ms,
              effects: const [
                FadeEffect(),
                SlideEffect(begin: Offset(0, 0.5)),
              ],
              child: const Text(
                'AirBilly',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// SUBTITLE
            Animate(
              delay: 600.ms,
              effects: const [FadeEffect()],
              child: const Text(
                'Pesan Tiket Pesawat dengan Mudah',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// LOADING
            Animate(
              delay: 900.ms,
              effects: const [FadeEffect()],
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}