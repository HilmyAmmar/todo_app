import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/page/home.dart';

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
  final TextEditingController _dateController = TextEditingController();
  String? selectedPriority;
  final List<String> priorityList = ['High', 'Low'];
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
                              decoration: InputDecoration(
                                  hintText: 'Name',
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
                                          items: priorityList
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
                                              return 'Please select gender.';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              selectedPriority =
                                                  value.toString();
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
                                  onPressed: () {},
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
        icon: const Icon(
          Icons.add,
          color: Color(0xFFF57D1F),
        ));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
