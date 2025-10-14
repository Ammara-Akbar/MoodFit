import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class AvatarEditingScreen extends StatefulWidget {
  const AvatarEditingScreen({super.key});

  @override
  State<AvatarEditingScreen> createState() => _AvatarEditingScreenState();
}

class _AvatarEditingScreenState extends State<AvatarEditingScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = [
    "Outfits",
    "Accessories",
    "Colors",
    "Backgrounds"
  ];

  // Dummy avatar image list (use your own assets)
  final List<String> avatars =
      List.generate(12, (index) => "assets/profile1.png");

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
              // ---- Header ----
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

              const Text(
                "Profile & Preferences",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Manage your profile and preferences.",
                style: TextStyle(fontSize: 14, color: Color(0xFF444444)),
              ),
              const SizedBox(height: 20),

              // ---- Avatar Preview ----
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            "assets/profile1.png",
                            height: 330,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Mood Level: 80% — Feeling Calm",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF444444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ---- Tab Buttons ----
              Container(
               
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_tabs.length, (index) {
                    final isSelected = _selectedTab == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = index),
                        child: Container(
                         
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _tabs[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // ---- Avatar Grid ----
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: avatars.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Image.asset(avatars[index]),
                  );
                },
              ),
              const SizedBox(height: 25),

              // ---- Action Buttons ----
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primaryColor2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Reset Changes",
                        style: TextStyle(
                          color: AppColors.primaryColor2,
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
