import 'package:flutter/material.dart';
import 'package:quiz_app/screens/screens.dart';
import 'package:quiz_app/services/resources/style_manger.dart';
import '../topic_screen/topic_screen.dart';

enum TabScreens { topicScreen, profileScreen }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.selectedPageIndex});
  final int? selectedPageIndex;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedPageIndex ?? 0;
  }

  late int _selectedIndex;
  final List<Widget> _screens = const [
    TopicScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 70.0,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: ColorManager.primary),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: ColorManager.primary),
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
