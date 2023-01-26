import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

import '../DAO/recipe_dao.dart';
import '../model/recipe.dart';
import '../repo/recipe_repo.dart';

class RecipesProvider extends ChangeNotifier {
  static List<Recipe> recipes = <Recipe>[];
  RecipeRepo recipeRepo = RecipeRepo();
  late RecipeDao recipeDao;

  late IOWebSocketChannel ws;

  RecipesProvider() {
    print("etc");
    this.ws = IOWebSocketChannel.connect(
      Uri.parse('ws://localhost:8081'),
    );

    this.ws.stream.listen((event) {
      print(event);
      var recipe = Recipe.fromJson(json.decode(event.toString()));
      print(recipe);
      print("i have arrived 2");
      addRecipe2(recipe);
    });
  }

  Future<bool> addRecipe(Recipe recipe) {
    recipes.add(recipe);
    return recipeRepo.addRecipe(recipe).then((value)  {
    notifyListeners(); return value;
    });
  }

  bool addRecipe2(Recipe recipe) {
    var goodRecipe = Recipe(
        displayName: recipe.displayName,
        steps: recipe.steps,
        difficulty: recipe.difficulty,
        ingredients: recipe.ingredients,
        id: recipe.id);
    recipes.add(goodRecipe);
    recipeDao.insertRecipe(recipe);
    notifyListeners();
    return true;
  }

  void deleteRecipe(String id) {
    recipes.removeWhere((element) => element.id == id);
    recipeRepo.deleteRecipe(id).then((value) => notifyListeners());
  }

  void updateRecipe(String id, String name, String difficulty, String ingredients,
      String steps) {
    Recipe recipe = recipes
        .where((element) => element.id == id)
        .first;
    recipe.displayName = name;
    recipe.ingredients = ingredients;
    recipe.steps = steps;
    recipe.difficulty = difficulty;
    recipeRepo.updateRecipe(recipe).then((value) =>
        notifyListeners());
  }
}