// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<String> docIds = [];
  Future getdocIds() async {
    await FirebaseFirestore.instance
        .collection("Complaints")
        .orderBy("timestamp", descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIds.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: getdocIds(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIds.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.grey[100],
                          title: GetuserName(documentId: docIds[index]),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class GetuserName extends StatelessWidget {
  final String documentId;
  GetuserName({required this.documentId});
  @override
  Widget build(BuildContext context) {
    CollectionReference Complaints =
        FirebaseFirestore.instance.collection('Complaints');
    return FutureBuilder<DocumentSnapshot>(
      future: Complaints.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('Pole Number:  ${data['Pole Number']}'
              '\n'
              'Pole Address: ${data['Pole Address']}'
              '\n'
              'Problem Description: ${data['Problem description']}');
        }
        return const Text('loading..');
      },
    );
  }
}
