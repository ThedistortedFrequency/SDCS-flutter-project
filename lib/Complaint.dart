// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Complaint extends StatefulWidget {
  const Complaint({Key? key}) : super(key: key);

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  String dropdownValue = 'Flickering Issues';
  final _formKey = GlobalKey<FormState>();
  final _polenumberController = TextEditingController();
  final _problemdescController = TextEditingController();
  @override
  void dispose() {
    _polenumberController.dispose();

    _problemdescController.dispose();
    super.dispose();
  }

  Future addComplaintDetails(var polenumber, var problemdesc) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    await FirebaseFirestore.instance
        .collection("Complaints")
        .add({"Pole Number": polenumber, "Problem description": problemdesc});
    Navigator.of(context).pop();
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
                          hintText: "Problem Discription/Additional Info.",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Card(
                      elevation: 10,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            addComplaintDetails(
                                _polenumberController.text.trim(),
                                _problemdescController.text.trim());
                          }
                          // ScaffoldMessenger.of(context).showMaterialBanner()
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
