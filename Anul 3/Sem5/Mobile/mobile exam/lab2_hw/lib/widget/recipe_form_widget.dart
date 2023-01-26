import 'package:flutter/material.dart';

class RecipeFormWidget extends StatelessWidget {
  final String name;
  final String difficulty;
  final String ingredients;
  final String steps;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedDifficulty;
  final ValueChanged<String> onChangedSteps;
  final ValueChanged<String> onChangedIngredients;
  final VoidCallback onSavedRecipe;

  const RecipeFormWidget({
    Key? key,
    this.name = '',
    this.difficulty = '',
    this.ingredients = '',
    this.steps = '',
    required this.onChangedName,
    required this.onChangedDifficulty,
    required this.onChangedSteps,
    required this.onChangedIngredients,
    required this.onSavedRecipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildName(),
            SizedBox(height: 8),
            buildDifficulty(),
            SizedBox(height: 8),
            buildSteps(),
            SizedBox(height: 8),
            buildIngredients(),
            SizedBox(height: 8),
            SizedBox(height: 12),
            buildButton(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        onChanged: onChangedName,
        validator: (name) {
          if (name != null && name.isEmpty) {
            return 'The name cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Name',
        ),
      );

  Widget buildDifficulty() => TextFormField(
        maxLines: 1,
        initialValue: difficulty,
        onChanged: onChangedDifficulty,
        validator: (location) {
          if (location != null && location.isEmpty) {
            return 'The difficulty cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Difficulty',
        ),
      );

  Widget buildSteps() => TextFormField(
        maxLines: 1,
        initialValue: steps,
        onChanged: onChangedSteps,
        validator: (type) {
          if (type != null && type.isEmpty) {
            return 'The steps cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Steps',
        ),
      );

  Widget buildIngredients() => TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        initialValue: ingredients,
        onChanged: onChangedIngredients,
        validator: (nrPlayers) {
          if (nrPlayers != null && nrPlayers.isEmpty) {
            return 'The ingredients cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Ingredients',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedRecipe,
          child: Text('Save'),
        ),
      );
}
