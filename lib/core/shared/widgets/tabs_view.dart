import 'package:flutter/material.dart';
import 'package:my_budget/core/barells/views.dart';

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final screens = [
      const DashboardView(),
      const ProfileView(),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_2_outlined),
            activeIcon: const Icon(Icons.person_2),
            label: 'Profile',
            backgroundColor: colors.primary,
          ),
        ],
      ),
    );
  }
}
