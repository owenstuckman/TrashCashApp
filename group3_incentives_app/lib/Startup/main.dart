import 'package:flutter/material.dart';
import 'home_page.dart';
import 'activity_page.dart';
import 'rewards_page.dart';
import 'package:provider/provider.dart';
import '../models/user_points.dart';
import 'login_page.dart'; // Import the LoginPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserPoints(),
      child: MaterialApp(
        title: 'Virginia Tech App',
        theme: ThemeData(
          primaryColor: const Color(0xFF861F41), // VT Maroon
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        initialRoute: '/', // Set the initial route
        routes: {
          '/': (context) => const LoginPage(), // Set LoginPage as the home page
          '/home': (context) => const MainNavigationPage(), // Define your home page route
        },
      ),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    ActivityPage(),
    RewardsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF861F41), // VT Maroon
        onTap: _onItemTapped,
      ),
    );
  }
}



