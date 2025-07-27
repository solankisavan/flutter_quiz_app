import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_rush/controller/activity_controller.dart';
import 'package:quiz_rush/controller/quiz_controller.dart';
import 'package:quiz_rush/views/result_screen.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final category = args['category'];

    // Create controller and inject with category
    final controller = Get.put(QuizController());
    final activityController = Get.put(ActivityController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF1559D6),
        foregroundColor: Colors.white,
        title: Text('$category Quiz',
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: GetBuilder<QuizController>(
        builder: (c) {
          if (c.quizData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Global timer display
              Obx(() {
                final minutes = (c.remainingSeconds.value ~/ 60)
                    .toString()
                    .padLeft(2, '0');
                final seconds = (c.remainingSeconds.value % 60)
                    .toString()
                    .padLeft(2, '0');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Time Left: $minutes:$seconds",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),

              const SizedBox(height: 8),

              // FIX: wrap ListView.builder with Expanded
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: c.quizData.length + 1,
                  itemBuilder: (context, index) {
                    if (index == c.quizData.length) {
                      // Submit button at end
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            c.submitQuiz();
                            final score = c.calculateScore();
                            final total = c.quizData.length;
                            activityController.updateActivity(
                                category, score, total);

                            Get.off(
                                  () => ResultScreen(
                                score: score,
                                total: total,
                                userName: "Savan Solanki",
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1559D6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }

                    final question = c.quizData[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
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
                            const SizedBox(height: 12),
                            ...(question['options'] as List<dynamic>)
                                .map((option) {
                              final isSelected =
                                  c.selectedAnswers[index] == option;
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
