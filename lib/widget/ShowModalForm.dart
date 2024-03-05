import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:todo_application/model/project_model.dart';
import 'package:todo_application/model/sub_task_model.dart';
import 'package:todo_application/model/task_model.dart';

class ShowFormModal extends StatefulWidget {
  const ShowFormModal(
      {super.key,
      required GlobalKey<FormState> formKey,
      required this.isTask,
      required this.isSubTask,
      this.project})
      : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final bool isTask;
  final bool isSubTask;
  final ProjectModel? project;

  @override
  State<ShowFormModal> createState() => _showFormModalState();
}

class _showFormModalState extends State<ShowFormModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late Box<TaskModel> taskBox;
  late Box<ProjectModel> projectBox;
  late Box<SubTaskModel> subTaskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<TaskModel>('tasks');
    projectBox = Hive.box<ProjectModel>('projects');
    subTaskBox = Hive.box<SubTaskModel>('subTasks');
  }

  String? selectedCategory;
  final List<String> categoryList = ['Priority', 'Daily'];
  final List<String> priorityList = ["High", "Medium", "Low"];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16,
                      right: 16,
                      top: 20),
                  child: Wrap(children: [
                    Form(
                        key: widget._formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.isTask
                                    ? "Add New Task"
                                    : widget.isSubTask
                                        ? "Add New Sub-Task"
                                        : "Add New Project",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Title",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                  hintText: 'Title',
                                  hintStyle: const TextStyle(
                                      color: Color(0xffDDDADA), fontSize: 14),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(15),
                                  suffixIcon: const SizedBox(
                                    width: 100,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          VerticalDivider(
                                            color: Colors.black,
                                            indent: 10,
                                            endIndent: 10,
                                            thickness: 0.1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Icon(Icons
                                                .drive_file_rename_outline_rounded),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none)),
                            ),
                            const SizedBox(height: 10),
                            if (!widget.isSubTask)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date",
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: _dateController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: 'Date',
                                            hintStyle: const TextStyle(
                                                color: Color(0xffDDDADA),
                                                fontSize: 14),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15),
                                            suffixIcon: SizedBox(
                                              width: 70,
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const VerticalDivider(
                                                      color: Colors.black,
                                                      indent: 10,
                                                      endIndent: 10,
                                                      thickness: 0.1,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        _selectDate(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .calendar_today_rounded),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.isTask
                                              ? "Category"
                                              : "Priority",
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        DropdownButtonFormField(
                                            isExpanded: true,
                                            value: selectedCategory,
                                            decoration: InputDecoration(
                                              hintText: widget.isTask
                                                  ? 'Category'
                                                  : 'Priority',
                                              hintStyle: const TextStyle(
                                                  color: Color(0xffDDDADA),
                                                  fontSize: 14),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              suffixIcon: const SizedBox(
                                                width: 70,
                                                child: IntrinsicHeight(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      VerticalDivider(
                                                        color: Colors.black,
                                                        indent: 10,
                                                        endIndent: 10,
                                                        thickness: 0.1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        child: Icon(Icons
                                                            .drive_file_rename_outline_rounded),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            items: widget.isTask
                                                ? categoryList
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList()
                                                : priorityList
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select category.';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                selectedCategory = value;
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                            if (!widget.isSubTask && !widget.isTask)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    minLines: 4,
                                    maxLines: 4,
                                    controller: _descriptionController,
                                    decoration: InputDecoration(
                                        hintText: 'Description ',
                                        hintStyle: const TextStyle(
                                            color: Color(0xffDDDADA),
                                            fontSize: 14),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none)),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (widget._formKey.currentState!
                                        .validate()) {
                                      if (widget.isTask) {
                                        final newTask = TaskModel(
                                          title: _titleController.text,
                                          date: DateTime.parse(
                                              _dateController.text),
                                          isDone: false,
                                          category: selectedCategory!,
                                        );
                                        taskBox.add(newTask);
                                      } else if (widget.isSubTask) {
                                        final newSubTask = SubTaskModel(
                                            title: _titleController.text,
                                            isDone: false,
                                            parentId: widget.project!.id);
                                        widget.project!.addTask(newSubTask);
                                        projectBox.putAt(widget.project!.id - 1,
                                            widget.project!);
                                      } else if (!widget.isSubTask &&
                                          !widget.isTask) {
                                        int nextId = projectBox.length + 1;
                                        final newProject = ProjectModel(
                                            totalTask: 0,
                                            completedTask: 0,
                                            dueDate: DateTime.parse(
                                                _dateController.text),
                                            title: _titleController.text,
                                            description:
                                                _descriptionController.text,
                                            category: selectedCategory!,
                                            taskList: [],
                                            id: nextId);
                                        projectBox.add(newProject);
                                      }

                                      reset();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 100),
                                      backgroundColor: const Color(0xFFffad47)),
                                  child: Text(
                                    widget.isTask
                                        ? "Create Task"
                                        : widget.isSubTask
                                            ? "Create Sub-Task"
                                            : "Create Project",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),
                  ]),
                );
              });
        },
        icon: const FaIcon(
          FontAwesomeIcons.plus,
          color: Color(0xFFff8800),
        ));
  }

  reset() {
    widget._formKey.currentState?.reset();
    _titleController.clear();
    _dateController.clear();
    setState(() {
      selectedCategory = null;
    });
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
