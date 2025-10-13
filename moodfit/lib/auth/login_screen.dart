
import 'package:flutter/material.dart';
import 'package:moodfit/common_widgets/custom_button.dart';
import 'package:moodfit/utils/colors.dart';
import 'package:moodfit/utils/my_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  // final _authService = AuthService();

  bool rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        _scrollToFocusedField(_emailFocus);
      }
    });

    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        _scrollToFocusedField(_passwordFocus);
      }
    });
  }

  void _scrollToFocusedField(FocusNode focusNode) {
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      if (!focusNode.hasPrimaryFocus) return;
      Scrollable.ensureVisible(
        focusNode.context!,
        duration: const Duration(milliseconds: 400),
        alignment: 0.3,
        curve: Curves.easeInOut,
      );
    });
  }
// Future<void> _login() async {
//   if (!_formKey.currentState!.validate()) return;

//   setState(() => _isLoading = true);
//   try {
//     final user = await _authService.signIn(
//       email: _emailCtrl.text.trim(),
//       password: _passwordCtrl.text.trim(),
//     );
//     if (user != null) {
//       Fluttertoast.showToast(
//         msg: "Login successful!",
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//       if (!mounted) return;
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => HomeScreen()),
//       );
//     }
//   } on FirebaseAuthException catch (e) {
//     String message;
//     switch (e.code) {
//       case 'user-not-found':
//         message = "No account found for that email.";
//         break;
//       case 'wrong-password':
//         message = "Incorrect password.";
//         break;
//       case 'user-disabled':
//         message = "This account has been disabled.";
//         break;
//       case 'invalid-email':
//         message = "Invalid email address.";
//         break;
//       case 'too-many-requests':
//         message = "Too many attempts. Try again later.";
//         break;
//       default:
//         message = "Login failed. Please check your credentials and try again.";
//     }
//     Fluttertoast.showToast(
//       msg: message,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//     );
//   } catch (e) {
//     // Instead of showing a vague error, always show a friendly fallback
//     Fluttertoast.showToast(
//       msg: "Login failed. Please try again.",
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//     );
//   } finally {
//     if (mounted) setState(() => _isLoading = false);
//   }
// }


  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
       
        SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          Image.asset(MyImages.appLogo, height: 100, width: 100),
                          const SizedBox(height: 10),
                          const Text(
                            "Log in to your Account",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFF17171B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            "Welcome back! Please enter your details.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF717171),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 25),

                          /// Email field
                          _buildLabel("Email"),
                          TextFormField(
                            controller: _emailCtrl,
                            focusNode: _emailFocus,
                            cursorColor: AppColors.primaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration("Enter your Email"),
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 16),

                          /// Password field
                          _buildLabel("Password"),
                          TextFormField(
                            controller: _passwordCtrl,
                            focusNode: _passwordFocus,
                            cursorColor: AppColors.primaryColor,
                            obscureText: true,
                            decoration: _inputDecoration("Enter Password"),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Please enter password' : null,
                          ),
                          const SizedBox(height: 3),

                          /// Remember & Forgot
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (v) => setState(() => rememberMe = v ?? false),
                                activeColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              const Text("Remember me",
                                  style: TextStyle(fontSize: 14, color: Color(0xFF444444))),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Forgot password
                                },
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          /// Login button
                          CustomButton(
                           text : _isLoading ? "Logging in..." : "Login",
                            ontap:  () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                                  );
                                },
                          ),
                          const SizedBox(height: 16),

                          /// Sign up link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don’t have an account?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF444444),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                // onTap: (){ Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (_) => const SignUpScreen()),
                                //         );},
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        /// Loading overlay
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black38,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    ),
  );
}
InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBBBBBB)),
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
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.7),
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
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Color(0xFF17171B),
        ),
      ),
    ),
  );
}

String? _validateEmail(String? v) {
  if (v == null || v.isEmpty) return 'Please enter email';
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(v)) return 'Enter a valid email';
  return null;
}
}