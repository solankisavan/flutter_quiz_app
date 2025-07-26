// Quiz Controller to manage state and load JSON from assets
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  List<Map<String, dynamic>> quizData = [];
  var selectedAnswers = <String?>[].obs;

  final List<Map<String, dynamic>> activity = [
    {"label": "KOTLIN", "score": 20, "color": Colors.greenAccent},

    {"label": "HTML", "score": 26, "color": Colors.redAccent},
    {"label": "Js", "score": 20, "color": Colors.amber},
    {"label": "REACT", "score": 25, "color": Colors.cyan},
    {"label": "CPP", "score": 27, "color": Colors.blueGrey},
    {"label": "PYTHON", "score": 22, "color": Colors.purple},
  ];


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
