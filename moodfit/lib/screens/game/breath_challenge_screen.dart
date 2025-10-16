import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moodfit/common_widgets/bottom_bar.dart';
import 'package:moodfit/screens/mem_mode_screen.dart';
import 'package:moodfit/utils/colors.dart';

class BreathChallengeScreen extends StatefulWidget {
  const BreathChallengeScreen({super.key});

  @override
  State<BreathChallengeScreen> createState() => _BreathChallengeScreenState();
}

class _BreathChallengeScreenState extends State<BreathChallengeScreen> {
  int stage = 0; // 0=start, 1=inProgress, 2=breathing, 3=result
  int seconds = 0;
  Timer? timer;
  bool isRunning = false;

  void _startTimer() {
    setState(() {
      stage = 1;
      isRunning = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        seconds++;
      });
      if (seconds > 20) {
        _finish();
      }
    });
  }

  void _pause() {
    setState(() => isRunning = false);
    timer?.cancel();
  }

  void _resume() {
    setState(() => isRunning = true);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        seconds++;
      });
      if (seconds > 20) {
        _finish();
      }
    });
  }

  void _finish() {
    timer?.cancel();
    setState(() {
      stage = 3;
      isRunning = false;
    });
  }

  String get timeDisplay {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyBottomBar(
                    initialIndex: 1,
                  )),
        );
        return false; // prevents the default system pop
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                  "Breath Challenge",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Tap to breathe in. Tap again to breathe out. Match your rhythm with the animation to earn calm points.",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.4),
                ),
                const SizedBox(height: 25),

                // --- Body section ---
                Center(child: _buildBody()),
                SizedBox(
                  height: 22,
                ),
                // --- Timer Section ---
                if (stage < 3)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 13),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Timer",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        Row(
                          children: [
                            Text(
                              timeDisplay,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 6),
                            isRunning
                                ? Icon(Icons.pause_circle_filled,
                                    color: AppColors.primaryColor, size: 35)
                                : Icon(Icons.play_circle_filled,
                                    color: AppColors.primaryColor, size: 35)
                          ],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 25),

                // --- Buttons ---
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---- Body for each stage ----
  Widget _buildBody() {
    switch (stage) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Image.asset("assets/baloons.png", height: 210),
          ],
        );
      case 1:
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              stage == 1 ? "Breathe Out" : "Breathe In",
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            if (stage == 2)
              const Text("You are doing great!",
                  style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            Image.asset("assets/baloons.png", height: 100),
          ],
        );
      case 3:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Image.asset("assets/image2.png", height: 150),
                  const SizedBox(height: 8),
                  const Text(
                    "Calm Level: 4/7",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "You earned 2 ⭐ Mood Power-Up!",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Feedback",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your breathing is smooth and steady. You’re in a calm zone.",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Great Progress",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreenColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  // ---- Buttons ----
  Widget _buildButtons() {
    if (stage == 0) {
      return ElevatedButton(
        onPressed: _startTimer,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: const Text("Start",
            style: TextStyle(color: Colors.white, fontSize: 16)),
      );
    } else if (stage == 1 || stage == 2) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isRunning ? _pause : _resume,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                isRunning ? "Pause" : "Resume",
                style: const TextStyle(
                    color: AppColors.primaryColor2,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _finish,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child:
                  const Text("Finish", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  stage = 0;
                  seconds = 0;
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Play Again",
                style: TextStyle(
                    color: AppColors.primaryColor2,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MemeModeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Go to Meme Mode",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      );
    }
  }
}
