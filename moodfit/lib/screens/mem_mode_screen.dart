import 'package:flutter/material.dart';
import 'package:moodfit/common_widgets/bottom_bar.dart';
import 'package:moodfit/utils/colors.dart';
// import 'package:share_plus/share_plus.dart';

class MemeModeScreen extends StatefulWidget {
  const MemeModeScreen({super.key});

  @override
  State<MemeModeScreen> createState() => _MemeModeScreenState();
}

class _MemeModeScreenState extends State<MemeModeScreen> {
  final TextEditingController captionController = TextEditingController();

  void _showShareSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Share on Social Media",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  Icon(Icons.close, color: Colors.grey.shade400),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Text(
                  "https://theacademy.b2prod.blob.core...",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _shareButton("assets/copylink.png", "Copy Link", () {
                    // Share.share("https://theacademy.b2prod.blob.core...");
                  }),
                  _shareButton("assets/facebook.png", "Facebook", () {
                    // Share.share("Check this out on Facebook!");
                  }),
                  _shareButton("assets/instagram.png", "Instagram", () {
                    // Share.share("Check this out on Instagram!");
                  }),
                  _shareButton("assets/tiktok.png", "TikTok", () {
                    // Share.share("Check this out on TikTok!");
                  }),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _shareButton(String icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(icon, height: 32),
          const SizedBox(height: 5),
          Text(label,
              style: const TextStyle(fontSize: 12, color: Colors.black87)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const MyBottomBar(initialIndex: 1)),
                              );
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 18, color: Colors.black)),
                        SizedBox(
                          width: 8,
                        ),
                        RichText(
                          text: const TextSpan(
                            text: "Mood",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                            children: [
                              TextSpan(
                                text: "Fit",
                                style: TextStyle(
                                    color: AppColors.primaryColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage("assets/image1.png"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Meme Mode",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2C3E50)),
                ),
                const SizedBox(height: 8),
                const Text(
                  "You did it! Here's your mood meme for today. Share it and spread the calm!",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 340,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Image.asset(
                      "assets/profile1.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Write a Caption",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
                const SizedBox(height: 10),
                TextField(
                    controller: captionController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      hintText: "Type your caption here...",
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
                    )),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _showShareSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text("Share",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
