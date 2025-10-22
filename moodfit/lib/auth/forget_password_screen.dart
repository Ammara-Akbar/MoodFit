import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodfit/auth/update_password_screen.dart';
import 'package:moodfit/utils/colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLoading = false;
  bool _showResetFields = false;
  bool _obscure = true;

  // Future<void> _verifyEmail() async {
  //   setState(() => _isLoading = true);
  //   try {
  //     // Check if the email is registered in Firebase
  //     final methods = await _auth.fetchSignInMethodsForEmail(_emailController.text.trim());
  //     if (methods.isNotEmpty) {
  //       // Email exists in Firebase
  //       setState(() {
  //         _showResetFields = true;
  //       });
  //       Fluttertoast.showToast(
  //         msg: "Email verified! You can now reset password.",
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //       );
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: "No account found with this email.",
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     Fluttertoast.showToast(
  //       msg: e.message ?? "Invalid email format.",
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //     );
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

  Future<void> _resetPassword() async {
    if (_passwordController.text != _confirmController.text) {
      Fluttertoast.showToast(
        msg: "Passwords do not match!",
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // 🔹 Firebase only allows reset via email link for security.
      // So we simulate by sending the email.
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      Fluttertoast.showToast(
        msg: "Password reset link sent! Check your email.",
        backgroundColor: Colors.green,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UpdatePasswordScreen()),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  RichText(
                    text: const TextSpan(
                      text: "Mood",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                      children: [
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
                  Text(
                    _showResetFields
                        ? "Reset Your Password"
                        : "Forgot Password?",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xFF17171B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _showResetFields
                        ? "Enter your new password below."
                        : "Enter your registered email to reset password.",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF717171),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  _buildLabel("Email"),
                  TextField(
                    controller: _emailController,
                    enabled: !_showResetFields,
                    cursorColor: AppColors.primaryColor,
                    decoration: _inputDecoration("Enter your email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  if (_showResetFields) ...[
                    _buildLabel("New Password"),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      cursorColor: AppColors.primaryColor,
                      decoration:
                          _inputDecoration("Enter new password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () =>
                              setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    _buildLabel("Confirm Password"),
                    TextField(
                      controller: _confirmController,
                      obscureText: _obscure,
                      cursorColor: AppColors.primaryColor,
                      decoration: _inputDecoration("Confirm new password"),
                    ),
                    const SizedBox(height: 25),
                  ],

                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    // onPressed: _isLoading
                    //     ? null
                    //     : _showResetFields
                    //         ? _resetPassword
                    //         : _verifyEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    ),
                    child: Text(
                      _showResetFields ? "Reset Password" : "Verify Email",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
          ],
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
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}
