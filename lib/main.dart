import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdcs/Complaint.dart';
import 'package:sdcs/bottomNavigator/feedback.dart';
import 'package:sdcs/bottomNavigator/home_body.dart';
import 'package:sdcs/Register/otp_page.dart';
import 'package:sdcs/Register/registor-page.dart';
import 'package:sdcs/Utils/routes.dart';
import 'package:sdcs/electrificaition.dart';
import 'package:sdcs/home.dart';
import 'package:sdcs/onboarding/onboarding_screen.dart';
import 'package:sdcs/personal_info.dart';
import 'package:sdcs/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.jostTextTheme(),
      ),
      routes: {
        "/": (context) => const PersonalInfo(),
        Screen.complaintScreen: (context) => const Complaint(),
        Screen.personalScreen: (context) => const PersonalInfo(),
        Screen.registorScreen: (context) => const RegistorPage(),
        Screen.otpPageScreen: (context) => const OtpPage(),
        Screen.homePageScreen: (context) => const HomePage(),
        Screen.homeBodyScreen: (context) => const HomeBody(),
        Screen.feedbackScreen: (context) => const FeedbackPage(),
        Screen.electrificationScreen: (context) => const Electrification(),
        Screen.onboardingScreen: (context) => const OnboardingScreen(),
        Screen.splashScreen: (context) => const SplashScreen(),
        Screen.compsubmitScreen: (context) => const CompSubmit(),
        Screen.electsubmitScreen: (context) => const Electsubmit(),
        Screen.feedsubmitScreen: (context) => const Feedsubmit(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
