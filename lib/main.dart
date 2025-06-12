import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';

void main() {
  runApp(const TabViewApp());
}

class TabViewApp extends StatelessWidget {
  const TabViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome TabView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101010),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const TabViewHome(),
    );
  }
}

class TabViewHome extends StatefulWidget {
  const TabViewHome({super.key});

  @override
  State<TabViewHome> createState() => _TabViewHomeState();
}

class _TabViewHomeState extends State<TabViewHome> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late final List<Widget> _tabs = [
    const HomeTab(),
    const FavoritesTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _tabs[_currentIndex],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GlassmorphicContainer(
              width: double.infinity,
              height: 70,
              borderRadius: 30,
              blur: 20,
              alignment: Alignment.center,
              border: 1,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: _currentIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white54,
                showUnselectedLabels: false,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.star), label: "Fav"),
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search something...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.search, color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white10,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: const [
                Text("Featured", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                featuredCard("🎮 Gaming", "New releases", Colors.deepPurple, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPage(title: "Gaming")));
                }),
                const SizedBox(width: 16),
                featuredCard("🌐 Explore", "Discover more", Colors.teal, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPage(title: "Explore")));
                }),
                const SizedBox(width: 16),
                featuredCard("🧠 Learn", "Boost skills", Colors.orange, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailPage(title: "Learn")));
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: const [
                Text("Quick Access", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                quickAccessCard(Icons.music_note, "Music", onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MusicDetailPage()));
                }),
                quickAccessCard(Icons.book, "Reading", onTap: () {}),
                quickAccessCard(Icons.map, "Travel", onTap: () {}),
                quickAccessCard(Icons.work, "Work", onTap: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget featuredCard(String title, String subtitle, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: GlassmorphicContainer(
        width: 160,
        height: 200,
        borderRadius: 20,
        blur: 20,
        border: 1,
        linearGradient: LinearGradient(
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white38, Colors.white10],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white70)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }

  static Widget quickAccessCard(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 20,
        blur: 15,
        border: 1,
        linearGradient: LinearGradient(
          colors: [Colors.white10, Colors.white24],
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white30, Colors.white10],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        cardItem("🎧 Music", "Enjoy your favorite tracks"),
        cardItem("🎬 Movies", "Watch trending films"),
        cardItem("📚 Books", "Explore great stories"),
      ],
    );
  }

  Widget cardItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 200,
        borderRadius: 20,
        blur: 15,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [Colors.white10, Colors.white24],
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white30, Colors.white10],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassmorphicContainer(
        width: 300,
        height: 250,
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [Colors.white10, Colors.white30],
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white38, Colors.white10],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            const Text("Settings Tab", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            const Text("Customize your preferences", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.dark_mode),
              label: const Text("Dark Mode"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white10,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  const DetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("Welcome to $title page!", style: const TextStyle(fontSize: 24))),
    );
  }
}

class MusicDetailPage extends StatelessWidget {
  const MusicDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      appBar: AppBar(title: const Text("Music")),
      body: Center(
        child: GlassmorphicContainer(
          width: 300,
          height: 300,
          borderRadius: 30,
          blur: 25,
          alignment: Alignment.center,
          border: 2,
          linearGradient: LinearGradient(colors: [Colors.deepPurpleAccent.withOpacity(0.2), Colors.black26]),
          borderGradient: LinearGradient(colors: [Colors.white24, Colors.deepPurpleAccent]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.music_note, size: 50, color: Colors.white),
              SizedBox(height: 16),
              Text("Now Playing", style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              Text("🎵 Lo-fi Beats", style: TextStyle(fontSize: 16, color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
