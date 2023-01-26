import 'package:fluter_codulet/controller/student_controller.dart';
import 'package:fluter_codulet/models/book.dart';
import 'package:fluter_codulet/repo/book_repo.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import 'my_borrowed_books.dart';
import 'owner_view_model.dart';

class OwnerScreen extends StatefulWidget {
  const OwnerScreen({super.key});

  @override
  State<OwnerScreen> createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {
  final OwnerViewModel _viewModel = OwnerViewModel(serviceLocator<BookRepo>());
  final TextEditingController _studentNameController = TextEditingController();

  Future<String> getPrefs() async {
    return await StudentControllerImpl.getStudentNameSP();
  }

  @override
  void initState() {
    super.initState();
    getPrefs().then((value) => setState(() {
          _studentNameController.text = value.toString();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Owner Section'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 500,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _studentNameController,
                    decoration: const InputDecoration(
                      labelText: "Your student name",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    StudentControllerImpl.setStudentNameSP(
                        _studentNameController.text);
                  },
                  child: const Text("Update name"),
                ),
              )),
              BookForm(ownerViewModel: _viewModel),
            ],
          ),
        ));
  }
}

final _formKey = GlobalKey<FormState>();

class BookForm extends StatefulWidget {
  final OwnerViewModel ownerViewModel;

  const BookForm({Key? key, required this.ownerViewModel}) : super(key: key);

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  late OwnerViewModel viewModel;
  late String studentName;
  String title = "";
  String status = "";
  int pages = 0;
  int usedCount = 0;

  @override
  Widget build(BuildContext context) {
    var titleEdit = TextEditingController();
    var statusEdit = TextEditingController();
    var pagesEdit = TextEditingController();
    var usedEdit = TextEditingController();
    viewModel = widget.ownerViewModel;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Title"),
          TextFormField(
            controller: titleEdit,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
            onChanged: (value) => {title = value},
          ),
          const Text("Status"),
          TextFormField(
            controller: statusEdit,
            decoration: const InputDecoration(
              labelText: "Status",
            ),
            onChanged: (value) => {status = value},
          ),
          const Text("Pages"),
          TextFormField(
            controller: pagesEdit,
            decoration: const InputDecoration(
              labelText: "Pages",
            ),
            onChanged: (value) => {pages = int.parse(value)},
          ),
          const Text("Used count"),
          TextFormField(
            controller: usedEdit,
            decoration: const InputDecoration(
              labelText: "Used count",
            ),
            onChanged: (value) => {usedCount = int.parse(value)},
          ),
          ElevatedButton(
              onPressed: () async {
                print(title);
                print(status);
                print(pages);
                print(usedCount);
                titleEdit.clear();
                statusEdit.clear();
                pagesEdit.clear();
                usedEdit.clear();

                viewModel.addBook(Book(
                    title: title,
                    student: await StudentControllerImpl.getStudentNameSP(),
                    status: status,
                    usedCount: usedCount,
                    pages: pages));
              },
              child: const Text("Save")),
          ElevatedButton(
              onPressed: () {
                // todo
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BorrowedBooks(viewModel: viewModel)));
              },
              child: const Text("See my books"))
        ],
      ),
    );
  }
}
