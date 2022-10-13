// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sdcs/Utils/routes.dart';

class Electrification extends StatefulWidget {
  const Electrification({Key? key}) : super(key: key);

  @override
  State<Electrification> createState() => _ElectrificationState();
}

class _ElectrificationState extends State<Electrification> {
  final _formKey = GlobalKey<FormState>();
  final _areaController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _placedescController = TextEditingController();
  final _additionalinfoController = TextEditingController();

  @override
  void dispose() {
    _areaController.dispose();
    _pincodeController.dispose();
    _placedescController.dispose();
    _additionalinfoController.dispose();

    super.dispose();
  }

  Future addelectirficationDetails(
      var area, var pincode, String placedesc, String additionalinfo) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    await FirebaseFirestore.instance.collection("Electrification").add({
      "Area": area,
      "Pin Code": pincode,
      "Place Description": placedesc,
      "Additional Information": additionalinfo
    });
    Navigator.pushNamedAndRemoveUntil(
        context, Screen.electsubmitScreen, (route) => false);
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(),

                  // Complaint title

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                    child: Center(
                      child: Text(
                        "Electrification Request.",
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

                  // area
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextFormField(
                      controller: _areaController,
                      decoration: const InputDecoration(
                          hintText: "Area",
                          label: Text("Area"),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  //  Pincode
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextFormField(
                      controller: _pincodeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: " Enter Pin Code",
                          label: Text("Pin Code"),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        } else if (value.length < 6) {
                          return "Invalid";
                        } else if (value.length > 6) {
                          return "Invalid";
                        }
                        return null;
                      },
                    ),
                  ),
                  // place description

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextFormField(
                      controller: _placedescController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          hintText: "Place Discription.",
                          label: Text("Place Description"),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  //  Additional info.
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextFormField(
                      controller: _additionalinfoController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          hintText: "Enter Additional Info.",
                          label: Text("Additional Info"),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  // upload image options
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Upload Image",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text("Capture"))
                      ],
                    ),
                  ),

                  // Submit
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      elevation: 10,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            addelectirficationDetails(
                              _areaController.text.trim(),
                              _pincodeController.text.trim(),
                              _placedescController.text.trim(),
                              _additionalinfoController.text.trim(),
                            );
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
                            "Submit",
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
      ),
    );
  }
}

class Electsubmit extends StatelessWidget {
  const Electsubmit({Key? key}) : super(key: key);

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
              "Electrification Submitted",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const Text(
              "Your Electrification has been successfully submitted.",
              style: TextStyle(
                  fontSize: 16,
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
