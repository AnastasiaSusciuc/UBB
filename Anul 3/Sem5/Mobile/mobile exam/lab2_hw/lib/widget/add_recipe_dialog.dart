import 'package:flutter/material.dart';
import '../widget/recipe_form_widget.dart';
import 'package:provider/provider.dart';

import '../model/recipe.dart';
import '../provider/recipes.dart';

class AddRecipeDialogWidget extends StatefulWidget {
  @override
  _AddRecipeDialogWidgetState createState() => _AddRecipeDialogWidgetState();
}

class _AddRecipeDialogWidgetState extends State<AddRecipeDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String difficulty = '';
  String ingredients = '';
  DateTime date = DateTime.now();
  String steps = '';

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget okayButton = TextButton(
      child: const Text("Okay"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error!"),
      content: const Text("Database persistence error! Please try again"),
      actions: [
        okayButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Form(
      key: _formKey,
      child: SingleChildScrollView(child:Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Recipe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 10),
        RecipeFormWidget(
          name: name,
          difficulty: difficulty,
          ingredients: ingredients,
          steps: steps,
          onChangedName: (name) => setState(() => this.name = name),
          onChangedDifficulty: (difficulty) =>
              setState(() => this.difficulty = difficulty),
          onChangedSteps: (steps) =>
              setState(() => this.steps = steps),
          onChangedIngredients: (ingredients) =>
              setState(() => this.ingredients = ingredients),
          onSavedRecipe: addRecipe,
        ),
      ],
    )),
  ));
  Future<void> addRecipe()
  async {
      final isValid = _formKey.currentState?.validate();
      if(!isValid!){
        return;
      } else {
        final recipe = Recipe(
          displayName: name,
          difficulty: difficulty,
          ingredients: ingredients,
          steps: steps,
          id: DateTime.now().toString()
        );

        print(date.toString());
        final provider = Provider.of<RecipesProvider>(
            context, listen: false);
        bool result = await provider.addRecipe(recipe);
        if(!result) { this.showAlertDialog(context);}
        Navigator.of(context).pop();
      }
  }
}