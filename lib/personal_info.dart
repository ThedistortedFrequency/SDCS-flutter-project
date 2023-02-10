// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sdcs/Utils/routes.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phonenoController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phonenoController.dispose();
    super.dispose();
  }

  Future addUserDetails(
      String name, String email, String adderss, String phoneno) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    await FirebaseFirestore.instance.collection("users").add({
      "timestamp": FieldValue.serverTimestamp(),
      "Name": name,
      "Email": email,
      "Address": adderss,
      "Phone Number": phoneno,
    });
    Navigator.pushNamedAndRemoveUntil(
        context, Screen.homePageScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(),
                // Personal Information
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Center(
                    child: Text(
                      "Personal Information.",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        hintText: "Enter your name",
                        label: Text("Name"),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                ),
                // phone number
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    controller: _phonenoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "Enter Phone Number",
                        label: Text("Phone No"),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      } else if (value.length < 10) {
                        return "Invalid";
                      } else if (value.length > 10) {
                        return "Invalid";
                      }
                      return null;
                    },
                  ),
                ),

                //Email Address
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    controller: _emailController,
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
                ),

                // Address

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        hintText: "Enter your Address",
                        label: Text("Address"),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          addUserDetails(
                              _nameController.text.trim(),
                              _emailController.text.trim(),
                              _addressController.text.trim(),
                              _phonenoController.text.trim());
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
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
