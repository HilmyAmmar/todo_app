import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:todo_application/model/project_model.dart';
import 'package:todo_application/model/task_model.dart';
import 'package:todo_application/page/profile.dart';
import 'package:todo_application/page/project_details.dart';
import 'package:todo_application/widget/ShowModalForm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<TaskModel>? taskBox;
  Box<ProjectModel>? projectBox;

  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
    if (!_isInitialized) {
      taskBox = Hive.box<TaskModel>('tasks');
      projectBox = Hive.box<ProjectModel>('projects');
      _isInitialized = true;
    }
  }

  DateTime now = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffba42),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Hilmy",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        color: Color(0xFF0b1e33))),
              ),
              Text(
                "Today is ${now.day} ${DateFormat('MMMM').format(now)} ${now.year}",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
        backgroundColor: const Color(0xFFffba42),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0X4000537a),
                  border: Border.all(color: const Color(0x6600537a))),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyProfile()));
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.85),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Projects",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ShowFormModal(
                      formKey: _formKey, isTask: false, isSubTask: false)
                ],
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable:
                    Hive.box<ProjectModel>('projects').listenable(),
                builder: (BuildContext context, Box<ProjectModel> projectBox,
                    Widget? child) {
                  if (projectBox.isEmpty) {
                    return Center(
                      child: Text(
                        "No Project Available",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 150,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ProjectModel project = projectBox.getAt(index)!;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProjectDetails(project: project)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              color: (project.id % 2 == 1)
                                  ? const Color(0xFF00537a)
                                  : const Color(0xFFffba42),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFc5c5c5),
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      project.title,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: (project.id % 2 == 1)
                                              ? Colors.white
                                              : const Color(0xFF0b1e33),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today_rounded,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(project.dueDate),
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: (project.id % 2 == 1)
                                                    ? Colors.white
                                                    : const Color(0xFF0b1e33),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (project.completedTask != null)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                              color: (project.id % 2 == 1)
                                                  ? const Color(0xFFffba42)
                                                  : const Color(0xFF00537a),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            "In Progress",
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 8,
                                                color: (project.id % 2 == 1)
                                                    ? const Color(0xFF00537a)
                                                    : const Color(0xFFffba42),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  LinearPercentIndicator(
                                    animation: true,
                                    lineHeight: 8,
                                    animationDuration: 2000,
                                    percent: project.totalTask == null
                                        ? 0
                                        : project.completedTask /
                                            project.totalTask,
                                    barRadius: const Radius.circular(20),
                                    progressColor: (project.id % 2 == 1)
                                        ? const Color(0xFFffba42)
                                        : const Color(0xFF00537a),
                                    trailing: Text(
                                      "${project.completedTask}/${project.totalTask}",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: (project.id % 2 == 1)
                                              ? const Color(0xFFDFD4F8)
                                              : const Color(0xFF0b1e33),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 25),
                      itemCount: projectBox.length,
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Tasks",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ShowFormModal(
                      formKey: _formKey, isTask: true, isSubTask: false)
                ],
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: Hive.box<TaskModel>('tasks').listenable(),
                builder: (BuildContext context, Box<TaskModel> taskBox,
                    Widget? child) {
                  if (taskBox.isEmpty) {
                    return Center(
                        child: Text(
                      "No Task Available",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TaskModel task = taskBox.getAt(index)!;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: task.isDone
                              ? const Color(0xFFEEF5FF)
                              : Colors.white,
                          border: Border.all(color: const Color(0x1A0077b6)),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFc5c5c5),
                              offset: Offset(0, 3),
                              blurRadius: 3,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: CheckboxListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: const Color(0xFFffad47),
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      task.title,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            decoration: task.isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: task.category == "Priority"
                                            ? const Color(0xFFf5a201)
                                            : const Color(0xB3ffba42),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      task.category,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd').format(task.date!),
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          secondary: IconButton(
                            icon: const FaIcon(FontAwesomeIcons.trash),
                            onPressed: () {
                              taskBox.deleteAt(index);
                            },
                          ),
                          value: task.isDone,
                          onChanged: (val) {
                            setState(() {
                              task.isDone = val!;
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: taskBox.length,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
