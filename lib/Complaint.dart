// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sdcs/Utils/routes.dart';

class Complaint extends StatefulWidget {
  const Complaint({Key? key}) : super(key: key);

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  String dropdownValue = 'Flickering Issues';
  final _formKey = GlobalKey<FormState>();
  final _polenumberController = TextEditingController();
  final _poleaddController = TextEditingController();
  final _problemdescController = TextEditingController();
  @override
  void dispose() {
    _polenumberController.dispose();
    _poleaddController.dispose();
    _problemdescController.dispose();
    super.dispose();
  }

  Future addComplaintDetails(
      String polenumber, String poleadd, String problemdesc) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    await FirebaseFirestore.instance.collection("Complaints").add({
      "Pole Number": polenumber,
      "Pole Address": poleadd,
      "Problem description": problemdesc
    }).then((value) => value.id);
    Navigator.pushNamedAndRemoveUntil(
        context, Screen.compsubmitScreen, (route) => false);
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
                        "Complaint.",
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
                      controller: _polenumberController,
                      decoration: const InputDecoration(
                          hintText: "Enter Pole Number",
                          label: Text("Pole No."),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  // pole address.
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextFormField(
                      controller: _poleaddController,
                      decoration: const InputDecoration(
                          hintText: "Enter Pole Address",
                          label: Text("Pole Address"),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  // Dropdown menu

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Problem",
                          hintText: "Problem"),
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        "Flickering Issues",
                        "No Operation",
                        "External Damage",
                        "Open Utility Wiring",
                        "Misuse"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                  //  Problem description

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextFormField(
                      controller: _problemdescController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      maxLength: 70,
                      decoration: const InputDecoration(
                          hintText: "Problem Description/Additional Info.",
                          label: Text("Problem Description"),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                    ),
                  ),

                  // uploadin image option.
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          addComplaintDetails(
                              _polenumberController.text.trim(),
                              _poleaddController.text.trim(),
                              _problemdescController.text.trim());
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

class CompSubmit extends StatelessWidget {
  const CompSubmit({Key? key}) : super(key: key);

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
              "Complaint Submitted",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const Text(
              "Your Complaint has been successfully submitted.",
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
