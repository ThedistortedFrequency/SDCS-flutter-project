// ignore_for_file: file_names, unnecessary_string_interpolations, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sdcs/Utils/routes.dart';

class RegistorPage extends StatefulWidget {
  const RegistorPage({super.key});
  static String verify = "";

  @override
  State<RegistorPage> createState() => _RegistorPageState();
}

class _RegistorPageState extends State<RegistorPage> {
  TextEditingController countryController = TextEditingController();

  var phone = "";

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.indigo,
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/564x/6b/26/e2/6b26e25f35171794eac51268f14778ab.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const Text(
                    "Registration",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "We need to register you phone number!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          onChanged: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              });
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '${countryController.text + phone}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              RegistorPage.verify = verificationId;

                              Navigator.popAndPushNamed(
                                  context, Screen.otpPageScreen);
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );

                          // Navigator.pushNamed(context, Screen.otpPageScreen);
                        },
                        child: const Text(
                          "Get Otp",
                          style: TextStyle(fontSize: 22),
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
