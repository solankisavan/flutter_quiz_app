// Quiz Controller to manage state and load JSON from assets
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../views/result_screen.dart';
import 'activity_controller.dart';

class QuizController extends GetxController {
  List<Map<String, dynamic>> quizData = [];
  var selectedAnswers = <String?>[].obs;
  final RxDouble progress = 1.0.obs;
  final RxInt timeLeft = 15.obs;
  final activityController = Get.put(ActivityController());

  final List<Map<String, dynamic>> activity = [
    {"label": "KOTLIN", "score": 20, "color": Colors.greenAccent},

    {"label": "HTML", "score": 26, "color": Colors.redAccent},
    {"label": "Js", "score": 20, "color": Colors.amber},
    {"label": "REACT", "score": 25, "color": Colors.cyan},
    {"label": "CPP", "score": 27, "color": Colors.blueGrey},
    {"label": "PYTHON", "score": 22, "color": Colors.purple},
  ];

  final RxInt remainingSeconds = 0.obs;
  Timer? _timer;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    loadQuizData();
  }

  Future<void> loadQuizData() async {
    final String response = await rootBundle.loadString('assets/quetions.json');
    final data = jsonDecode(response);
    if (data is List) {
      quizData = data.map((e) => e as Map<String, dynamic>).toList();
    } else if (data is Map<String, dynamic> && data.containsKey('questions')) {
      quizData = (data['questions'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    } else {
      quizData = [];
    }
    selectedAnswers.value = List.filled(quizData.length, null);
    currentIndex = 0;
    remainingSeconds.value = quizData.length * 30;
    startTimer();
    update();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        submitQuiz(); // Auto submit
      }
    });
  }

  void submitQuiz() {
    _timer?.cancel();
    final score = calculateScore();
    final total = quizData.length;

    // Use Get.offNamed or Get.off to go to result screen
    // Get.offNamed(
    //   '/result',
    //   arguments: {'score': score, 'total': total, 'userName': 'Savan Solanki'},
    // );
    activityController.updateActivity(
        "KOTLIN", score, total);

    Get.off(
          () => ResultScreen(
        score: score,
        total: total,
        userName: "Savan Solanki",
      ),
    );
  }

  void selectAnswer(int index, String option) {
    selectedAnswers[index] = option;
    update();
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < quizData.length; i++) {
      if (selectedAnswers[i] == quizData[i]['answer']) {
        score++;
      }
    }
    return score;
  }
}
