// Quiz Screen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_rush/views/result_screen.dart';

import '../controller/quiz_controller.dart';

class QuizScreen extends StatelessWidget {
  final controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final category = args['category'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C47A1),
        foregroundColor: Colors.white,
        title: Text('${category} Quiz', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: GetBuilder<QuizController>(
        builder: (c) {
          if (c.quizData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: c.quizData.length + 1,
            itemBuilder: (context, index) {
              if (index == c.quizData.length) {
                // Submit button
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      int score = c.calculateScore();
                      int total = c.quizData.length;
                      Get.off(
                        () => ResultScreen(
                          score: score,
                          total: total,
                          userName: "Savan Solanki",
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0C47A1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Submit',style: TextStyle(color: Colors.white),),
                  ),
                );
              }

              var question = c.quizData[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question['question'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...(question['options'] as List<dynamic>).map((option) {
                        bool isSelected = c.selectedAnswers[index] == option;
                        return ListTile(
                          title: Text(option.toString()),
                          leading: Radio<String>(
                            value: option.toString(),
                            groupValue: c.selectedAnswers[index],
                            onChanged: (value) {
                              c.selectAnswer(index, value!);
                            },
                          ),
                          tileColor: isSelected
                              ? Colors.blue.withOpacity(0.1)
                              : null,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
