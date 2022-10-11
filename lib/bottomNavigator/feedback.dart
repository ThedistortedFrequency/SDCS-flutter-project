import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
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
                    Center(
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

                    // feedback submition

                    TextFormField(
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
                          if (_formKey.currentState!.validate()) {}
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text(
                          //       "Submitted",
                          //       style: TextStyle(),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //     duration: Duration(seconds: 2),
                          //     backgroundColor: Colors.indigoAccent,
                          //   ),
                          // );
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
