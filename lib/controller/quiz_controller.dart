// Quiz Controller to manage state and load JSON from assets
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  List<Map<String, dynamic>> quizData = [];
  var selectedAnswers = <String?>[].obs;

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
      quizData = (data['questions'] as List).map((e) => e as Map<String, dynamic>).toList();
    } else {
      quizData = [];
    }
    selectedAnswers.value = List.filled(quizData.length, null);

    update();
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
