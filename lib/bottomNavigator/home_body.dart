import 'package:flutter/material.dart';
import 'package:sdcs/Utils/routes.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    // card-1 complaint
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      shadowColor: const Color.fromARGB(255, 14, 13, 13),
                      elevation: 7.0,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff131c85), Color(0xff827bd9)],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Screen.complaintScreen);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Complaints",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                height: 4.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // card-2 request for electrifications
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      shadowColor: const Color.fromARGB(255, 14, 13, 13),
                      elevation: 7.0,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff131c85), Color(0xff827bd9)],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Screen.electrificationScreen);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Electricfication Request",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                height: 4.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
