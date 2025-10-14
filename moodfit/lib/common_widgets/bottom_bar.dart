import 'package:flutter/material.dart';
import 'package:moodfit/screens/daily_challenges_screen.dart';
import 'package:moodfit/screens/game/games_screen.dart';
import 'package:moodfit/screens/setting/setting_screen.dart';
import 'package:moodfit/screens/dashboard_screen.dart';
import 'package:moodfit/utils/colors.dart';

class MyBottomBar extends StatefulWidget {
  final int initialIndex; // 👈 allows you to pass custom starting tab

  const MyBottomBar({super.key, this.initialIndex = 0});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  late int _selectedIndex;

  final Color selectedColor = AppColors.primaryGreenColor;

  final List<String> icons = [
    "assets/dashboard.png",
    "assets/emoji1.png",
    "assets/chalenges1.png",
    "assets/setting1.png"
  ];

  final List<String> labels = [
    "Dashboard",
    "Games",
    "Daily Challenges",
    "Settings",
  ];

  final List<Widget> screens = const [
    DashboardScreen(),
    GamesScreen(),
    DailyChallengesScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // 👈 use the passed initial index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[_selectedIndex],

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index) {
            final isSelected = _selectedIndex == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isSelected ? 130 : 50,
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => _onItemTapped(index),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icons[index],
                      color: isSelected ? Colors.white : selectedColor,
                      height: 22,
                      fit: BoxFit.contain,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          labels[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
