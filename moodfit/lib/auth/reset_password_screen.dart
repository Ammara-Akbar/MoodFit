import 'package:flutter/material.dart';
import 'package:moodfit/auth/update_password_screen.dart';
import 'package:moodfit/utils/colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

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
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Reset Password",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF17171B),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Enter your new password to continue.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF717171),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),

              // Email Label + Field
              _buildLabel("New Password"),
              TextField(
                cursorColor: AppColors.primaryColor,
                
                decoration: _inputDecoration("Enter New Password"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),

              // Password Label + Field
              _buildLabel("Confirm Password"),
              TextField(
                cursorColor: AppColors.primaryColor,
               
                obscureText: true,
                decoration: _inputDecoration("Enter Confirm Password"),
              ),
              const SizedBox(height: 22),

              
                // --- Buttons Row ---
                Row(
                  children: [
                   
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryColor2,
                            elevation: 0,
                            side: const BorderSide(
                                color: AppColors.primaryColor2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UpdatePasswordScreen()));

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Reset Password",
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
            
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Color(0xFF17171B),
          ),
        ),
      ),
    );
  }

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
          color: Color(0xFF4F8EF7),
          width: 1.6,
        ),
      ),
    );
  }
}
