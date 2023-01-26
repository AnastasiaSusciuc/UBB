import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/recipe.dart';
import '../provider/recipes.dart';
import '../widget/recipe_form_widget.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;
  const EditRecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String difficulty;
  late String ingredients;
  late String steps;

  @override
  void initState() {
    super.initState();

    name = widget.recipe.displayName;
    difficulty = widget.recipe.difficulty;
    ingredients = widget.recipe.ingredients;
    steps = widget.recipe.steps;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Edit Recipe'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            final provider =
            Provider.of<RecipesProvider>(context, listen: false);
            provider.deleteRecipe(widget.recipe.id);

            Navigator.of(context).pop();
          },
        )
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: RecipeFormWidget(
          name: name,
          ingredients: ingredients,
          difficulty: difficulty,
          steps: steps,
          onChangedName: (name) => setState(() => this.name = name),
          onChangedDifficulty: (difficulty) =>
              setState(() => this.difficulty = difficulty),
          onChangedSteps: (steps) =>
              setState(() => this.steps = steps),
          onChangedIngredients: (ingredients) =>
              setState(() => this.ingredients = ingredients),
          onSavedRecipe: saveRecipe,
        ),
      ),
    ),
  );

  void saveRecipe() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      final provider = Provider.of<RecipesProvider>(context, listen: false);

      provider.updateRecipe(widget.recipe.id, name, difficulty, ingredients, steps);

      Navigator.of(context).pop();
    }
  }
}