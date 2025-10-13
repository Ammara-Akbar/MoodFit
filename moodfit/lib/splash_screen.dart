import 'package:flutter/material.dart';
import 'package:moodfit/utils/my_images.dart';

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
    _checkLoginAndNavigate();
  }
  

  Future<void> _checkLoginAndNavigate() async {
    await Future.delayed(const Duration(seconds: 4)); // Splash delay

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User already logged in, go directly to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // User not logged in, show onboarding first
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              MyImages.appLogo,
              height: 250,
              width: 250,
            ),
          ),
          // const SizedBox(height: 15),
          // Text(
          //   "Soulfull Care Co",
          //   style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.w600,
          //       color: AppColors.primaryBlueColor),
          // ),
          // Text(
          //   "Nourish your soul, one \nmindful moment at a time",
          //   style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //       color: AppColors.primaryBrownColor),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
