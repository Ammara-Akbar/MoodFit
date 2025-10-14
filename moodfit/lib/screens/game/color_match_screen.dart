import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moodfit/common_widgets/bottom_bar.dart';
import 'package:moodfit/utils/colors.dart';

class ColorMatchScreen extends StatefulWidget {
  const ColorMatchScreen({super.key});

  @override
  State<ColorMatchScreen> createState() => _ColorMatchScreenState();
}

class _ColorMatchScreenState extends State<ColorMatchScreen> {
  int stage = 0; // 0 = start, 1 = playing, 2 = result
  int seconds = 0;
  int correct = 0;
  int wrong = 0;
  Timer? timer;
  bool isRunning = false;
  Color? targetColor;
  List<Color> colorGrid = [];
  final List<Color> colorPalette = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];

  void _generateGrid() {
    final rand = Random();
    colorGrid = List.generate(
        25, (index) => colorPalette[rand.nextInt(colorPalette.length)]);
    targetColor = colorPalette[rand.nextInt(colorPalette.length)];
  }

  void _startGame() {
    setState(() {
      stage = 1;
      seconds = 0;
      correct = 0;
      wrong = 0;
      _generateGrid();
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
      stage = 2;
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
          MaterialPageRoute(builder: (_) => const MyBottomBar(initialIndex: 1)),
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
                // Header
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
                  "Color Match",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Match the shown color by tapping on tiles of the same color before time runs out!",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.4),
                ),
                const SizedBox(height: 25),

                // --- Body Section ---
                Expanded(child: _buildBody()),

                const SizedBox(height: 15),

                // Timer
                if (stage != 2)
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
                            Text(timeDisplay,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
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

  // ---- Game Body ----
  Widget _buildBody() {
    if (stage == 0) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child:
            Image.asset("assets/game2.png", height: 300, fit: BoxFit.contain),
      );
    } else if (stage == 1) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  "Match This Color",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: targetColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemCount: colorGrid.length,
                  itemBuilder: (context, index) {
                    final color = colorGrid[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (color == targetColor) {
                            correct++;
                          } else {
                            wrong++;
                          }
                          _generateGrid();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // --- Results ---
      String feedback;
      Color color;
      if (correct >= 12) {
        feedback = "Excellent Accuracy";
        color = AppColors.primaryGreenColor;
      } else if (correct >= 8) {
        feedback = "Balanced Performance";
        color = Colors.orange;
      } else {
        feedback = "Needs Practice";
        color = Colors.red;
      }

      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text("Popup",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 10),
                Text("Correct: $correct",
                    style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor)),
                Text("Wrong: $wrong",
                    style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor)),
                SizedBox(
                  height: 12,
                ),
                const Text("Anxiety Level: Moderate",
                    style: TextStyle(fontSize: 14, color: Colors.black54)),
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              feedback,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: correct / 20,
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
                  correct = 0;
                  wrong = 0;
                  seconds = 0;
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Play Again",
                  style: TextStyle(
                      color: AppColors.primaryColor2,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
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
