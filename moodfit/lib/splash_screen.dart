import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodfit/auth/login_screen.dart';
import 'package:moodfit/common_widgets/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onBoarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }
Future<void> _navigateAfterDelay() async {
  await Future.delayed(const Duration(seconds: 3)); // splash delay

  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  // ✅ Check Firebase user session
  final user = FirebaseAuth.instance.currentUser;

  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  } else if (user != null) {
    // ✅ Already logged in
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MyBottomBar()),
    );
  } else {
    // ✅ Not logged in yet
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/background.jpg', // replace with your uploaded image path
            fit: BoxFit.cover,
          ),

          // Overlay design (as in 2nd image)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center app logo text
              Text(
                "Mood",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade600,
                ),
              ),
              Text(
                "Fit",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
