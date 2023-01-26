import 'package:access/models/my_entity.dart';
import 'package:access/screen/screen1/screen1_view_model.dart';
import 'package:access/screen/screen1/show_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../repo/entity_repo.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {

  final Screen1ViewModel _viewModel = Screen1ViewModel(serviceLocator<MyEntityRepo>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Staff Section'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              BookForm(screen1ViewModel: _viewModel),
            ],
          ),
        ));
  }
}

final _formKey = GlobalKey<FormState>();

class BookForm extends StatefulWidget {
  final Screen1ViewModel screen1ViewModel;

  const BookForm({Key? key, required this.screen1ViewModel}) : super(key: key);

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  late Screen1ViewModel viewModel;
  late String studentName;
  String name = "";
  int level = 0;
  String status = "";
  int from = 0;
  int to = 0;

  @override
  Widget build(BuildContext context) {
    var nameEdit = TextEditingController();
    var statusEdit = TextEditingController();
    var levelEdit = TextEditingController();
    var fromEdit = TextEditingController();
    var toEdit = TextEditingController();
    viewModel = widget.screen1ViewModel;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameEdit,
            decoration: const InputDecoration(
              labelText: "Name",
            ),
            onChanged: (value) => {name = value},
          ),
          TextFormField(
            controller: levelEdit,
            decoration: const InputDecoration(
              labelText: "Level",
            ),
            onChanged: (value) => {level = int.parse(value)},
          ),
          TextFormField(
            controller: statusEdit,
            decoration: const InputDecoration(
              labelText: "Status",
            ),
            onChanged: (value) => {status = value},
          ),
          TextFormField(
            controller: fromEdit,
            decoration: const InputDecoration(
              labelText: "From",
            ),
            onChanged: (value) => {from = int.parse(value)},
          ),
          TextFormField(
            controller: toEdit,
            decoration: const InputDecoration(
              labelText: "To",
            ),
            onChanged: (value) => {to = int.parse(value)},
          ),
          ElevatedButton(
              onPressed: () async {
                print(name);
                print(status);
                print(level);
                print(status);
                print(from);
                print(to);
                nameEdit.clear();
                statusEdit.clear();
                levelEdit.clear();
                toEdit.clear();
                fromEdit.clear();

                viewModel.addMyEntity(MyEntity(
                    name: name,
                    level: level,
                    status: status,
                    from: from,
                    to: to));
              },
              child: const Text("Save")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowList(viewModel: viewModel)));
              },
              child: const Text("See all rules"))
        ],
      ),
    );
  }
}

