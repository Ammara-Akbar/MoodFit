import 'package:flutter/material.dart';
import 'package:moodfit/auth/login_screen.dart';
import 'package:moodfit/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  final _passwordCtrl = TextEditingController();

  bool rememberMe = false;

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
                "Create an Account",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF17171B),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Welcome to the MoodFit! Let's get started",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF717171),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              // Email Label + Field
              _buildLabel("Name"),
              TextField(
                cursorColor: AppColors.primaryColor,
                controller: _nameCtrl,
                decoration: _inputDecoration("Enter your Name"),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 18),

              // Email Label + Field
              _buildLabel("Email"),
              TextField(
                cursorColor: AppColors.primaryColor,
                controller: _emailCtrl,
                decoration: _inputDecoration("Enter your Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),

              // Password Label + Field
              _buildLabel("Password"),
              TextField(
                cursorColor: AppColors.primaryColor,
                controller: _passwordCtrl,
                obscureText: true,
                decoration: _inputDecoration("Enter Password"),
              ),
              const SizedBox(height: 18),
              // Password Label + Field
              _buildLabel("Confirm Password"),
              TextField(
                cursorColor: AppColors.primaryColor,
                controller: _passwordCtrl,
                obscureText: true,
                decoration: _inputDecoration("Enter Confirm Password"),
              ),

              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // OR divider
              const Text(
                "Or",
                style: TextStyle(fontSize: 15, color: Color(0xFF444444)),
              ),
              const SizedBox(height: 10),

              // Google and Apple Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: Image.asset(
                        'assets/google.png', // replace with your asset
                        height: 22,
                      ),
                      label: const Text(
                        "Login with Google",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Apple Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.apple,
                          color: Colors.white, size: 24),
                      label: const Text(
                        "Login with Apple",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // SignUp link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF444444),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
