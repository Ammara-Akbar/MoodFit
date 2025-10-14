import 'package:flutter/material.dart';
import 'package:moodfit/auth/login_screen.dart';
import 'package:moodfit/utils/colors.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Title
              RichText(
                text: TextSpan(
                  text: "Mood",
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                  children: const [
                    TextSpan(
                      text: "Fit",
                      style: TextStyle(
                        color: AppColors.primaryColor2,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
          
              const Text(
                "Password Updated!",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF17171B),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Your password has been changed successfully.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF717171),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
          
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 13),
                  ),
                  child: const Text(
                    "Go to Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
