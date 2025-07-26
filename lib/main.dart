import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_rush/views/dashboard_screen.dart';


void main(){
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
