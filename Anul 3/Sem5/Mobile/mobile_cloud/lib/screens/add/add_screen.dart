import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cloud/models/teacher/teacher.dart';
import 'package:mobile_cloud/repo/teacher_repo.dart';
import 'add_view_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final AddViewModel _viewModel = AddViewModel(TeacherRepo());
  late TextFieldDescriptor _titleDescriptor;
  late TextFieldDescriptor _urlDescriptor;
  late TextFieldDescriptor _dateDescriptor;
  late TextFieldDescriptor _albumDescriptor;

  InputDecoration _getDecoration(String title) => InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Colors.grey),
      );

  @override
  void initState() {
    super.initState();
    _titleDescriptor = TextFieldDescriptor(
        controller: TextEditingController(),
        decoration: _getDecoration("Last name"));
    _urlDescriptor = TextFieldDescriptor(
        controller: TextEditingController(), decoration: _getDecoration("Facebook URL"));
    _dateDescriptor = TextFieldDescriptor(
        controller: TextEditingController(),
        decoration: _getDecoration("Years of experience"));
    _albumDescriptor = TextFieldDescriptor(
      controller: TextEditingController(),
      decoration: _getDecoration("First name"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add photo"),
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
                style: const TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _viewModel
                      .addTeacher(
                        Teacher(
                            lastName: _titleDescriptor.controller.text,
                            url: _urlDescriptor.controller.text,
                            firstName:
                                _albumDescriptor.controller.text.isNotEmpty
                                    ? _albumDescriptor.controller.text
                                    : null,
                            yearsExperience: int.parse(_dateDescriptor.controller.text)),
                      )
                      .then((_) => Navigator.of(context).pop());
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text("Add teacher !"),
              ),
              const Icon(
                Icons.photo,
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

class TextFieldDescriptor {
  final TextEditingController controller;
  final InputDecoration decoration;

  TextFieldDescriptor({
    required this.controller,
    required this.decoration,
  });
}
