import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final int questionIndex;
  final int totalQuestions;
  final String questionText;
  final List<String> options;
  final int selectedIndex;
  final Function(int) onOptionTap;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const QuizCard({
    super.key,
    required this.questionIndex,
    required this.totalQuestions,
    required this.questionText,
    required this.options,
    required this.selectedIndex,
    required this.onOptionTap,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.blueAccent,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Question progress and Quit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Question: ${questionIndex + 1}/$totalQuestions",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.blue),
                ),
                const Text(
                  "Quit",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Question
            Text(
              questionText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            /// Options
            ...options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () => onOptionTap(index),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade800 : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.blue.shade800 : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 10),

            /// See Result
            const Text(
              "See Result ⌄",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),

            /// Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onPrevious,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Previous", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Next",style: TextStyle(color: Colors.white),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
