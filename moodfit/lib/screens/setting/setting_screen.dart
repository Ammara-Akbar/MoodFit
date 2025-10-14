import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodfit/utils/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedTab = 0; // 0 = Profile, 1 = Reminders

  bool remindDaily = true;
  bool remindMeals = true;
  bool remindRelax = false;

  final TextEditingController nameCtrl =
      TextEditingController(text: "John Doe");
  final TextEditingController emailCtrl =
      TextEditingController(text: "johndoe3@gmail.com");
  final TextEditingController currentPassCtrl = TextEditingController();
  final TextEditingController newPassCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

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

              // ---- Tabs ----
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: _selectedTab == 0
                                ? AppColors.primaryColor
                                : const Color(0xFFF3F6FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )),
                        child: Center(
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              color: _selectedTab == 0
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: _selectedTab == 1
                                ? AppColors.primaryColor
                                : const Color(0xFFF3F6FF),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )),
                        child: Center(
                          child: Text(
                            "Reminders",
                            style: TextStyle(
                              color: _selectedTab == 1
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // ---- Profile Tab ----
              if (_selectedTab == 0) ...[
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/profile1.png",
                        height: 100,
                        width: 100,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Update Avatar",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Personal Info",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _buildLabel("Name"),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  controller: nameCtrl,
                  decoration: _inputDecoration("Enter Name"),
                ),
                const SizedBox(height: 16),
                _buildLabel("Email"),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  controller: emailCtrl,
                  decoration: _inputDecoration("Enter Email"),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Security",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _buildLabel("Current Password"),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  controller: currentPassCtrl,
                  obscureText: true,
                  decoration: _inputDecoration("Enter Password"),
                ),
                const SizedBox(height: 16),
                _buildLabel("New Password"),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  controller: newPassCtrl,
                  obscureText: true,
                  decoration: _inputDecoration("Enter New Password"),
                ),
                const SizedBox(height: 16),
                _buildLabel("Confirm Password"),
                TextFormField(
                  cursorColor: AppColors.primaryColor,
                  controller: confirmPassCtrl,
                  obscureText: true,
                  decoration: _inputDecoration("Confirm Password"),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: AppColors.primaryColor2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: AppColors.primaryColor2,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
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
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              // ---- Reminders Tab ----
              if (_selectedTab == 1) ...[
                _buildSwitchRow(
                  title: "Remind me to check in daily",
                  value: remindDaily,
                  onChanged: (v) => setState(() => remindDaily = v),
                ),
                _buildSwitchRow(
                  title: "Remind me to log meals",
                  value: remindMeals,
                  onChanged: (v) => setState(() => remindMeals = v),
                ),
                _buildSwitchRow(
                  title: "Remind me to relax",
                  value: remindRelax,
                  onChanged: (v) => setState(() => remindRelax = v),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8, // 👈 Adjust this value (0.8 = 80% of original size)
            alignment: Alignment.centerRight,
            child: CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF4F8EF7), // MoodFit blue
              trackColor: const Color(0xFFEFF4FF), // soft blue when off
            ),
          ),
        ],
      ),
    );
  }

  // ---- Label Builder ----
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Color(0xFF17171B),
          ),
        ),
      ),
    );
  }

  // ---- Input Decoration ----
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Color(0xFFBBBBBB),
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 1.6,
        ),
      ),
    );
  }
}
