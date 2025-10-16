import 'package:flutter/material.dart';
import 'package:moodfit/screens/web/common_widgets/custom_button.dart';
import 'package:moodfit/screens/web/web_user_screen.dart';
import 'package:moodfit/utils/colors.dart';

class WebLoginScreen extends StatelessWidget {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          // Small screen (mobile/tablet) layout
          if (width < 800) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    LoginCard(),
                  ],
                ),
              ),
            );
          }

          // Web large screen layout
          return Row(
            children: [
              // Left side (Login form)
              Expanded(
                flex: 5,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: const LoginCard(),
                  ),
                ),
              ),

              // Right side (Image)
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(left: 40),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/adminlogoimge.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          const SizedBox(height: 24),

          // Card box
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome!",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                "Welcome! Please enter your details.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
           _buildLabel("Email"),
              // Email
              TextField(
                controller: emailCtrl,
                cursorColor: AppColors.primaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter Email Address",
                  hintStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
           _buildLabel("Password"),
              // Password
              TextField(
                controller: passwordCtrl,
                obscureText: true,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  hintStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
          
              // Login button
              CustomButton(title: "Login", ontap: (){
                Navigator.pushReplacement( 
                  context,
                  MaterialPageRoute(builder: (_) => WebUserScreen()),
                );
              },),
     
            ],
          ),
        ],
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
}
