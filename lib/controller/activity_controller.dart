import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityController extends GetxController {
  final RxList<Map<String, dynamic>> activity = <Map<String, dynamic>>[].obs;

  void updateActivity(String category, int score,int totalScore) {
    // Remove old entry if exists
    activity.removeWhere((item) => item['label'] == category);

    // Choose a color based on category (or random)
    Color color = _colorForCategory(category);

    // Add updated entry
    activity.add({
      "label": category,
      "score": score,
      "color": color,
      "totalScore":totalScore,
    });
  }

  Color _colorForCategory(String category) {
    switch (category.toUpperCase()) {
      case 'HTML':
        return Colors.redAccent;
      case 'KOTLIN':
        return Colors.greenAccent;
      case 'JS':
        return Colors.amber;
      case 'REACT':
        return Colors.cyan;
      case 'CPP':
        return Colors.blueGrey;
      case 'PYTHON':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}
