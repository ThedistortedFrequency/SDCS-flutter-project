// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sdcs/Register/registor-page.dart';
import 'package:sdcs/Utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetoforward();
  }

  _navigatetoforward() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistorPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: 120,
              width: 120,
              child: Image.asset(
                "assets/sdcs.png",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Streetlight Defect Complaints System",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
