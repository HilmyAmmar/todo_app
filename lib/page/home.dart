import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/model/project_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProjectModel> listProject = ProjectModel.getAllProject();
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Welcome, Hilmy",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Color(0xFF110E68))),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active_rounded,
                  size: 30,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFFf6f6f6), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFc5c5c5),
                          offset: Offset(3, 3),
                          blurRadius: 20,
                          spreadRadius: 0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today,",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(fontWeight: FontWeight.w400)),
                      ),
                      Text(
                        "${now.day} ${DateFormat('MMMM').format(now)} ${now.year}",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Projects",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    child: ListView.separated(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  color: Color(0xFF110E68),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFFc5c5c5),
                                        offset: Offset(5, 5),
                                        blurRadius: 5,
                                        spreadRadius: 0)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        listProject[index].name,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color(0xFFDFD4F8)),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              listProject[index].deadline,
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    color: Color(0xFFDFD4F8)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${listProject[index].completedTask}/${listProject[index].totalTask}",
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Color(0xFFDFD4F8)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 25),
                        itemCount: listProject.length),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
