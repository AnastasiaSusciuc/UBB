import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/teacher/teacher.dart';
import '../../repo/teacher_repo.dart';
import '../add/add_screen.dart';
import 'edit_view_model.dart';

class EditScreen extends StatefulWidget {
  final Teacher teacher;

  const EditScreen({Key? key, required this.teacher}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final EditViewModel _viewModel = EditViewModel(TeacherRepo());
  late TextFieldDescriptor _titleDescriptor;
  late TextFieldDescriptor _urlDescriptor;
  late TextFieldDescriptor _dateDescriptor;
  late TextFieldDescriptor _albumDescriptor;
  // late TextFieldDescriptor selectedDate;

  InputDecoration _getDecoration(String title) => InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Colors.grey),
      );

  @override
  void initState() {
    super.initState();
    _titleDescriptor = TextFieldDescriptor(
        controller: TextEditingController()..text = widget.teacher.lastName ?? "",
        decoration: _getDecoration("Last Name"));
    _urlDescriptor = TextFieldDescriptor(
        controller: TextEditingController()..text = widget.teacher.url ?? "",
        decoration: _getDecoration("URL"));
    _dateDescriptor = TextFieldDescriptor(
        controller: TextEditingController()..text = widget.teacher.yearsExperience.toString() ?? "",
        decoration: _getDecoration("Years of Experience"));
    _albumDescriptor = TextFieldDescriptor(
      controller: TextEditingController()..text = widget.teacher.firstName ?? "",
      decoration: _getDecoration("First name"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit teacher"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                decoration: _titleDescriptor.decoration,
                controller: _titleDescriptor.controller,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                decoration: _urlDescriptor.decoration,
                controller: _urlDescriptor.controller,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                decoration: _dateDescriptor.decoration,
                controller: _dateDescriptor.controller,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                decoration: _albumDescriptor.decoration,
                controller: _albumDescriptor.controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _viewModel.updateTeacher(
                    Teacher(
                        id: widget.teacher.id,
                        lastName: _titleDescriptor.controller.text,
                        url: _urlDescriptor.controller.text,
                        firstName: _albumDescriptor.controller.text.isNotEmpty
                            ? _albumDescriptor.controller.text
                            : null,
                        yearsExperience: int.parse(_dateDescriptor.controller.text)),
                  ).then((_) => Navigator.of(context).pop());
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text("Edit teacher !"),
              ),
              const Icon(
                Icons.photo_outlined,
                size: 200,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
