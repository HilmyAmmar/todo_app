import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:todo_application/model/task_model.dart';

class ShowFormModal extends StatefulWidget {
  const ShowFormModal({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<ShowFormModal> createState() => _showFormModalState();
}

class _showFormModalState extends State<ShowFormModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  late Box<TaskModel> taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<TaskModel>('tasks');
  }

  String? selectedCategory;
  final List<String> categoryList = ['Priority', 'Daily'];

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
                                "Add New Task",
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
                              "Name",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        "Priority",
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
                                            hintText: 'Priority',
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
                                          items: categoryList
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
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
                                              selectedCategory =
                                                  value as String?;
                                            });
                                          }),
                                    ],
                                  ),
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
                                      final newTask = TaskModel(
                                        title: _titleController.text,
                                        date: DateTime.parse(
                                            _dateController.text),
                                        isDone: false,
                                        category: selectedCategory!,
                                      );

                                      taskBox.add(newTask);

                                      Navigator.of(context).pop();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 100),
                                      backgroundColor: Color(0xFFffad47)),
                                  child: Text(
                                    "Create Task",
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
        icon: FaIcon(
          FontAwesomeIcons.add,
          color: Color(0xFFff8800),
        ));
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
