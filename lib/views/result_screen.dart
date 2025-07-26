import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final String userName;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.userName,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleSize = size.width * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.blue,
                  Colors.green,
                  Colors.purple,
                  Colors.orange,
                  Colors.red,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF4EA1FF), Color(0xFF0C47A1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: circleSize * 0.85,
                        height: circleSize * 0.85,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0C47A1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Your Score",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${widget.score}/${widget.total}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),

                  const Text(
                    "Congratulation",
                    style: TextStyle(
                      color: Color(0xFF0C47A1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Great job, ${widget.userName}! You Did It",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFF0C47A1), fontSize: 16),
                  ),

                  SizedBox(height: size.height * 0.08),

                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.065,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C47A1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Share",
                        style: TextStyle(fontSize: size.width * 0.045, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.065,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C47A1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.offAllNamed('/');
                      },
                      child: Text(
                        "Back to Home",
                        style: TextStyle(fontSize: size.width * 0.045, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}