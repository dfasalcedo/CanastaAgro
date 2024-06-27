import 'package:flutter/material.dart';
import '../../producers/presentation/producers_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../register_prodtucts/presentation/register_farm.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const ProfileScreen(),
    const ProducersScreen(),
    const FarmForm(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Producers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Farms',
          ),
        ],
      ),
    );
  }
}
