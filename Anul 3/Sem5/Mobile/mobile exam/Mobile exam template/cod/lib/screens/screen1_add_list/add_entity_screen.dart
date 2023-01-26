import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_cod/repo/entity_repo.dart';
import 'package:template_cod/screens/screen1_add_list/screen1_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/my_entity.dart';

class AddEntityScreen extends StatefulWidget {
  final Screen1ViewModel screen1ViewModel;

  const AddEntityScreen({Key? key, required this.screen1ViewModel})
      : super(key: key);

  @override
  State<AddEntityScreen> createState() => _AddEntityScreenState();
}

class _AddEntityScreenState extends State<AddEntityScreen> {
  late Screen1ViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = widget.screen1ViewModel;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Entity'),
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
  // late String studentName;

  //todo change
  String name = "";
  String description = "";
  String ingredients = "";
  String instructions = "";
  String category = "";
  String difficulty = "";

  @override
  Widget build(BuildContext context) {
    var nameEdit = TextEditingController();
    var ingredientsEdit = TextEditingController();
    var descriptionEdit = TextEditingController();
    var instructionsEdit = TextEditingController();
    var categoryEdit = TextEditingController();
    var difficultyEdit = TextEditingController();
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
            controller: descriptionEdit,
            decoration: const InputDecoration(
              labelText: "Description",
            ),
            onChanged: (value) => {description = value},
          ),
          TextFormField(
            controller: ingredientsEdit,
            decoration: const InputDecoration(
              labelText: "Ingredients",
            ),
            onChanged: (value) => {ingredients = value},
          ),
          TextFormField(
            controller: instructionsEdit,
            decoration: const InputDecoration(
              labelText: "Instructions",
            ),
            onChanged: (value) => {instructions = value},
          ),
          TextFormField(
            controller: categoryEdit,
            decoration: const InputDecoration(
              labelText: "Category",
            ),
            onChanged: (value) => {category = value},
          ),
          TextFormField(
            controller: difficultyEdit,
            decoration: const InputDecoration(
              labelText: "Difficulty",
            ),
            onChanged: (value) => {difficulty = value},
          ),
          ElevatedButton(
              onPressed: () async {

                if (MyEntityRepo.hasInternet == false) {
                  Fluttertoast.showToast(
                      msg: "No internet ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  Navigator.of(context).pop();
                }

                print(name);
                print(ingredients);
                print(description);
                print(ingredients);
                print(instructions);
                print(category);

                viewModel.addMyEntity(MyEntity(
                    name: nameEdit.text,
                    description: description,
                    ingredients: ingredients,
                    instructions: instructions,
                    category: category,
                    difficulty: difficulty
                )).then((value) => {
                    Navigator.pop(context)
              });
                Fluttertoast.showToast(
                    msg: "Added entity ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                nameEdit.clear();
                ingredientsEdit.clear();
                descriptionEdit.clear();
                categoryEdit.clear();
                instructionsEdit.clear();
                difficultyEdit.clear();

              },
              child: const Text("Save")),
        ],
      ),
    );
  }
}
