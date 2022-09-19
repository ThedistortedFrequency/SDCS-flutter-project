// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sdcs/bottomNavigator/feedback.dart';
import 'package:sdcs/bottomNavigator/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List Screen = [
    const HomeBody(),
    const FeedbackPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0.0,
        title: const Text("Streetlight Defect Complaint System"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          onTap: (index) => setState(
                () => currentIndex = index,
              ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.teal,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: "Feedback",
              backgroundColor: Colors.teal,
            ),
          ]),
    );
  }
}
