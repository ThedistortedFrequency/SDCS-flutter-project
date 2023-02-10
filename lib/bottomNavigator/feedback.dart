// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sdcs/Utils/routes.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final _emailadController = TextEditingController();
  @override
  void dispose() {
    _feedbackController.dispose();
    _emailadController.dispose();

    super.dispose();
  }

  Future addfeedbackDetails(String feedback, String email) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    await FirebaseFirestore.instance.collection("Feedback").add({
      "timestamp": FieldValue.serverTimestamp(),
      "feedback details": feedback,
      "Email Address": email
    });
    Navigator.pushNamedAndRemoveUntil(
        context, Screen.feedsubmitScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    // Personal Information
                    const Center(
                      child: Text(
                        "Feedback",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    // Email
                    TextFormField(
                      controller: _emailadController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                          hintText: "Enter your email",
                          label: Text("Email"),
                          border: OutlineInputBorder()),
                      validator: MultiValidator([
                        RequiredValidator(errorText: " Required"),
                        EmailValidator(errorText: "Not a valid email.")
                      ]),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    // feedback submition

                    TextFormField(
                      controller: _feedbackController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          hintText: "Tell us about your experience.",
                          label: Text("Feedback"),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    Card(
                      elevation: 10,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            addfeedbackDetails(_feedbackController.text.trim(),
                                _emailadController.text.trim());
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                              child: Text(
                            "Submit Feedback",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // for queries
                    const Text(
                      "For queries contact at",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87),
                    ),
                    const Text(
                      "sdcsapp@gmail.com",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Feedsubmit extends StatelessWidget {
  const Feedsubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              color: Colors.transparent,
              child: Image.asset("assets/tick.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Feedback Submitted",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const Text(
              "Your Feedback has been successfully submitted.",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: Colors.black),
            ),
            const Text(
              "Thanks for using SDCS.",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.transparent,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Screen.homePageScreen);
                    },
                    child: const Center(child: Text("Back to Home"))),
              ),
            )
          ],
        ),
      )),
    );
  }
}
