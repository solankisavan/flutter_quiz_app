import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz_rush/views/quiz_screen.dart';

import '../controller/activity_controller.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": "assets/kotlin.png", "label": "KOTLIN"},
    {"icon": "assets/html.png", "label": "HTML"},
    {"icon": "assets/js.png", "label": "JAVASCRIPT"},
    {"icon": "assets/react.png", "label": "REACT"},
    {"icon": "assets/cpp.png", "label": "C++"},
    {"icon": "assets/python.png", "label": "PYTHON"},
  ];
  final activityController = Get.put(ActivityController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF2FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/user.png"),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Savan Solanki",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("ID-1809", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.diamond, color: Colors.blue),
                        SizedBox(width: 4),
                        Text("160"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 11),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),

                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/banner.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(16),
                    height: 150,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Test Your Knowledge with\nQuizzes",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "You're just looking for a playful way to learn\nnew facts...",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                              ),
                              child: Text("Play Now"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search),
                    SizedBox(width: 12),
                    Icon(Icons.tune),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: InkWell(
                        onTap: () {
                          final label = cat['label'];

                          if (label == 'KOTLIN') {
                            print("Kotlin category selected");

                            Get.to(
                              () => QuizScreen(),
                              arguments: {"category": "Kotlin"},
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(cat['icon'], width: 30),
                            ),
                            SizedBox(height: 4),
                            Text(cat['label'], style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Recent Activity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              ...activityController.activity.map((item) => ActivityCard(item: item)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ActivityCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            backgroundImage: AssetImage(
              "assets/${item['label'].toLowerCase()}.png",
            ),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['label'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item['totalScore'].toString(), style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: item['score'] / 30,
                color: item['color'],
                backgroundColor: Colors.grey.shade300,
              ),
              Text("${item['score']}/30", style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
