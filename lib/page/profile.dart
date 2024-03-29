import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../model/project_model.dart';
import '../model/task_model.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late Box<TaskModel> taskBox;
  late Box<ProjectModel> projectBox;
  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<TaskModel>('tasks');
    projectBox = Hive.box<ProjectModel>('projects');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFffba42),
        ),
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                      color: Color(0xFFffba42),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(100, 50))),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfilePicture(
                          name: "Hilmy Ammar Darmawan",
                          fontsize: 50,
                          radius: 80,
                          tooltip: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Hilmy Ammar Darmawan",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Hilmy",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35,
                    left: 0,
                    right: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFFc5c5c5),
                                  offset: Offset(0, 5),
                                  blurRadius: 5,
                                  spreadRadius: 0)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Overview",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            projectBox.length.toString(),
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Total Project",
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0x4Dffc300),
                                      thickness: 2,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            taskBox.length.toString(),
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Total Tasks",
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFFc5c5c5),
                                  offset: Offset(0, 5),
                                  blurRadius: 5,
                                  spreadRadius: 0)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Personal Information",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Email",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "hilmy.ammar21@ui.ac.id",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Color(0xFF00537a),
                                thickness: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Phone Number",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "0811-2873-9278",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Color(0xFF00537a),
                                thickness: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Hobbies",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Playing video games, Watching Cinema",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Color(0xFF00537a),
                                thickness: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Major",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Computer Science",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Color(0xFF00537a),
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
