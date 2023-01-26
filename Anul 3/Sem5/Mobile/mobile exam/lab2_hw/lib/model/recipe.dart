import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class Recipe {
  String displayName;
  String difficulty;
  String steps;
  String ingredients;
  @primaryKey
  String id;

  Recipe({
    required this.displayName,
    required this.difficulty,
    required this.steps,
    required this.ingredients,
    required this.id,
  });

  @override
  String toString() {
    return 'Recipe{displayName: $displayName, difficulty: $difficulty, steps: $steps, ingredients: $ingredients, id: $id}';
  }

  Map<String, dynamic> toJson() => {
    'displayName': displayName,
    'difficulty': difficulty,
    'steps': steps,
    'ingredients' : ingredients,
    'id': id
  };

  Recipe.fromJson(Map<String, dynamic> json)
      : displayName = json['displayName'],
        difficulty = json['difficulty'],
        steps = json['steps'],
        ingredients = json['ingredients'],
        id = json['id'];
}