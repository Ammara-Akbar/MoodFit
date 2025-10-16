import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moodfit/common_widgets/bottom_bar.dart';
import 'package:moodfit/utils/colors.dart';

import '../mem_mode_screen.dart';

class TapToFocusScreen extends StatefulWidget {
  const TapToFocusScreen({super.key});

  @override
  State<TapToFocusScreen> createState() => _TapToFocusScreenState();
}

class _TapToFocusScreenState extends State<TapToFocusScreen> {
  int stage = 0; // 0=start, 1=inProgress, 2=feedback, 3=result
  int seconds = 0;
  int score = 0;
  int total = 20;
  Timer? timer;
  bool isRunning = false;

  List<Offset> bubbles = [];

  void _generateBubbles() {
    final rand = Random();
    bubbles = List.generate(8, (index) {
      double x = rand.nextDouble() * 280;
      double y = rand.nextDouble() * 280;
      return Offset(x, y);
    });
  }

  void _startGame() {
    setState(() {
      stage = 1;
      score = 0;
      seconds = 0;
      _generateBubbles();
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => seconds++);
      if (seconds >= 20) _finishGame();
    });
  }

  void _pause() {
    setState(() => isRunning = false);
    timer?.cancel();
  }

  void _resume() {
    setState(() => isRunning = true);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => seconds++);
      if (seconds >= 20) _finishGame();
    });
  }

  void _finishGame() {
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
            builder: (context) => const MyBottomBar(initialIndex: 1),
          ),
        );
        return false;
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
                                SizedBox(width: 8,),
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
                  "Tap to Focus",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Tap the bubbles before the timer runs out. Stay calm and focused — each tap adds a point!",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.4),
                ),
                const SizedBox(height: 25),

                // --- Game Body ---
                Expanded(
                  child: _buildBody(),
                ),

                const SizedBox(height: 15),

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
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              isRunning
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              color: AppColors.primaryColor,
                              size: 35,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 25),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---- Body ----
  Widget _buildBody() {
    if (stage == 0) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          "assets/baloonsgame.png",
          height: 320,
          fit: BoxFit.contain,
        ),
      );
    } else if (stage == 1) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: bubbles.map((pos) {
            return Positioned(
              left: pos.dx,
              top: pos.dy,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    score++;
                    _generateBubbles();
                  });
                },
                child: Container(
                  height: 40 + Random().nextInt(30).toDouble(),
                  width: 40 + Random().nextInt(30).toDouble(),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor2,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else if (stage == 3) {
      double anxietyScore = (total - score) / total * 100;
      String feedback;
      Color color;
      if (score >= 16) {
        feedback = "Low Anxiety Level";
        color = AppColors.primaryGreenColor;
      } else if (score >= 10) {
        feedback = "Moderate Anxiety";
        color = Colors.orange;
      } else {
        feedback = "High Anxiety";
        color = Colors.red;
      }

      return Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Popup",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(height: 12,),
                Text(
                  "$score / $total",
                  style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor),
                ),
                const SizedBox(height: 8),
                Text(
                  feedback,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.topLeft,
            child: Text("Feedback",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black)),
          ),
          const SizedBox(height: 8),
          const Text(
            "Great focus and reaction speed! You’re mastering calm control.",
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              feedback,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
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
              widthFactor: score / total,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }

  // ---- Buttons ----
  Widget _buildButtons() {
    if (stage == 0) {
      return ElevatedButton(
        onPressed: _startGame,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: const Text("Start",
            style: TextStyle(color: Colors.white, fontSize: 16)),
      );
    } else if (stage == 1) {
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
              onPressed: _finishGame,
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
                  score = 0;
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
