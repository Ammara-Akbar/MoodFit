import 'package:flutter/material.dart';
import 'package:moodfit/screens/game/breath_challenge_screen.dart';
import 'package:moodfit/screens/game/color_match_screen.dart';
import 'package:moodfit/screens/game/tap_to_focus_screen.dart';
import 'package:moodfit/utils/colors.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Header (Logo + Profile) ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Mood",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      children: [
                        TextSpan(
                          text: "Fit",
                          style: TextStyle(
                            color: AppColors.primaryColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage("assets/image1.png"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ---- Title and Description ----
              const Text(
                "Let's check your calm level.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Play a quick game to measure how anxious or relaxed you feel right now.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF444444),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 25),

              // ---- Custom Row 1 (Two Cards Side by Side) ----
              Row(
                children: [
                  Expanded(
                    child: _buildGameCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BreathChallengeScreen()),
                        );
                      },
                      title: "Breath Challenge",
                      description:
                          "Follow the rhythm and breathe with the circle.",
                      iconPath: "assets/breathperson.png",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildGameCard(
                      onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TapToFocusScreen()),
                        );
                      },
                      title: "Tap to Focus",
                      description: "Pop the bubbles before time runs out.",
                      iconPath: "assets/tapfocus.png",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ---- Custom Row 2 (Full Width Card) ----
              _buildGameCard(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ColorMatchScreen()),
                        );
                },
                title: "Color Match",
                description: "Stay sharp. Match the color fast.",
                iconPath: "assets/colormatch.png",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

// ---- Reusable Game Card ----
  Widget _buildGameCard({
    required String title,
    required String description,
    required String iconPath,
    required VoidCallback onTap, // 👈 added required onTap
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 70, fit: BoxFit.contain),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: onTap, // 👈 now it's dynamic
            child: const Text(
              "Start Game",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
