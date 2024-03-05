import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/model/project_model.dart';
import 'package:todo_application/model/sub_task_model.dart';
import 'package:todo_application/widget/ShowModalForm.dart';

class ProjectDetails extends StatefulWidget {
  final ProjectModel project;
  const ProjectDetails({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late Box<ProjectModel> projectBox;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    projectBox = Hive.box<ProjectModel>('projects');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Project Details",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
        backgroundColor: Color(0x4Dffba42),
        actions: [
          IconButton(
              onPressed: () {
                int projectIndex =
                    projectBox.values.toList().indexOf(widget.project);
                if (projectIndex != -1) {
                  projectBox.deleteAt(projectIndex);
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(FontAwesomeIcons.trash)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0x4Dffba42),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.project.title,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Color(0xFF013c58)),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFf5a201),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "${widget.project.category} Priority",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Description",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFF013c58)),
                  ),
                ),
                Text(
                  widget.project.description,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xCC00537a)),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Due Date",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xFF013c58)),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.calendar),
                              SizedBox(width: 10),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(widget.project.dueDate!),
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Color(0xCC00537a)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tasks",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xFF013c58)),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.tasks),
                              SizedBox(width: 10),
                              Text(
                                "${widget.project.completedTask}/${widget.project.totalTask}",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Color(0xCC00537a)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: double.infinity,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub-Tasks",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFF013c58)),
                      ),
                    ),
                    ShowFormModal(
                        formKey: _formKey,
                        isTask: false,
                        isSubTask: true,
                        project: widget.project)
                  ],
                ),
                SizedBox(height: 15),
                ValueListenableBuilder(
                  valueListenable: projectBox.listenable(),
                  builder: (BuildContext context, Box<ProjectModel> projectBox,
                      Widget? child) {
                    if (widget.project.taskList.isEmpty) {
                      return Center(
                        child: Text(
                          "No Task Available",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        SubTaskModel task = widget.project.taskList[index];
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
                            contentPadding: EdgeInsets.symmetric(horizontal: 6),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: const Color(0xFFffad47),
                            checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
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
                              ],
                            ),
                            value: task.isDone,
                            onChanged: (val) {
                              setState(() {
                                task.isDone = val!;
                                if (task.isDone) {
                                  widget.project.completedTask++;
                                } else {
                                  widget.project.completedTask--;
                                }
                                projectBox.putAt(
                                    widget.project.id - 1, widget.project);
                              });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: widget.project.taskList.length,
                    );
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
