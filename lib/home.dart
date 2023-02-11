// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:sdcs/bottomNavigator/feedback.dart';
import 'package:sdcs/bottomNavigator/home_body.dart';
import 'package:sdcs/bottomNavigator/status.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List Screen = [const HomeBody(), const FeedbackPage(), const StatusPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Streetlight Defect Complaint System"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(
                () => currentIndex = index,
              ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.indigo,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: "Feedback",
              backgroundColor: Colors.indigo,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: "Status",
              backgroundColor: Colors.indigo,
            ),
          ]),
    );
  }
}
