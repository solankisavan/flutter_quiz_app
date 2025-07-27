import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_rush/views/dashboard_screen.dart';
import 'package:quiz_rush/views/quiz_screen.dart';
import 'package:quiz_rush/views/result_screen.dart';
import 'package:quiz_rush/views/splash_screen.dart';


void main(){
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    //   routes: {
    // '/': (context) =>  DashboardScreen(),
    // '/quiz': (context) => QuizScreen(),
    //
    // },
    );
  }
}
