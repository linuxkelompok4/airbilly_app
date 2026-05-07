import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'flight_list_screen.dart';
import 'profile_screen.dart';
import 'booking_history_screen.dart';
import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

@override
void initState() {
  super.initState();

  _screens = [
    const HomeContent(),
    const BookingHistoryScreen(),
    ProfileScreen(user: widget.user),
  ];
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/airplane.png',
          height: 32,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.flight_takeoff),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: const Color(0xFF4FC3F7),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = [
      {
        'name': 'Jakarta (CGK)',
        'price': 450000,
        'image': 'assets/images/jakarta.jpg'
      },
      {
        'name': 'Bali (DPS)',
        'price': 750000,
        'image': 'assets/images/bali.jpg'
      },
      {
        'name': 'Surabaya (SUB)',
        'price': 600000,
        'image': 'assets/images/surabaya.jpg'
      },
      {
        'name': 'Medan (KNO)',
        'price': 850000,
        'image': 'assets/images/medan.jpg'
      },
      {
        'name': 'Makassar (UPG)',
        'price': 950000,
        'image': 'assets/images/makassar.jpg'
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // HERO
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Animate(
                  effects: const [
                    FadeEffect(),
                    SlideEffect(begin: Offset(0, 0.2)),
                  ],
                  child: const Text(
                    'Temukan Penerbangan Terbaik Kamu',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SearchBarWidget(),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // DESTINASI HEADER
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _SectionHeader(title: 'Destinasi Populer'),
          ),

          const SizedBox(height: 12),

          // DESTINATION LIST (FIXED)
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: destinations.length,
              itemBuilder: (context, i) {
                final data = destinations[i];

                return Animate(
                  delay: (100 * i).ms,
                  child: DestinationCard(
                    destination: data['name'] as String,
                    price: data['price'] as int,
                    image: data['image'] as String,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FlightListScreen(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // PROMO
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _SectionHeader(title: 'Promo Spesial'),
          ),

          const SizedBox(height: 12),

          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => PromoCard(i),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        onSubmitted: (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FlightListScreen(),
            ),
          );
        },
        decoration: const InputDecoration(
          hintText: 'Ke mana ingin terbang?',
          prefixIcon: Icon(Icons.search, color: Color(0xFF4FC3F7)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String destination;
  final int price;
  final String image;
  final VoidCallback? onTap;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.price,
    required this.image,
    this.onTap,
  });

  String formatRupiah(int value) {
    return value
        .toString()
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [

              // IMAGE
              Positioned.fill(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),

              // GRADIENT
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // CONTENT
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.flight_takeoff,
                        color: Colors.white, size: 18),

                    const Spacer(),

                    Text(
                      destination,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4FC3F7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Rp ${formatRupiah(price)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  final int index;
  const PromoCard(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final promos = [
      'Diskon 50% Jakarta - Bali',
      'Gratis Bagasi 20kg',
      'Promo Keluarga Hemat',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: Color(0xFF4FC3F7)),
          const SizedBox(width: 16),
          Expanded(child: Text(promos[index])),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Ambil'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Lihat Semua'),
        ),
      ],
    );
  }
}