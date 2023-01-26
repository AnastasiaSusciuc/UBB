import 'dart:convert';

import 'package:flutter/material.dart';
import '../networking/rest_client.dart';
import '../provider/recipes.dart';
import 'package:logger/logger.dart';

import '../DAO/recipe_dao.dart';
import '../model/recipe.dart';

class RecipeRepo {
  static bool hasInternet = true;
  static List<Recipe> queuedRecipes = [];
  static late final RecipeDao recipeDao;
  static late final Logger logger;
  static late final RestClient client;

  Future<bool> addRecipe(Recipe recipe) async {
    try {
      if (hasInternet) {
        await client
            .postRecipe(recipe)
            .then((it) => recipeDao.insertRecipe(it))
            .onError((error, stackTrace) {});
      } else {
        recipe.id = DateTime.now().millisecondsSinceEpoch.toString();
        await recipeDao.insertRecipe(recipe);
        queuedRecipes.add(recipe);
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> deleteRecipe(String id) async {
    try {
      debugPrint("In DELETE function" + id.toString());
      final recipe = await recipeDao.findRecipeById(id);
      if (recipe == null) return false;
      debugPrint("Recipe FOUND");
      recipeDao.deleteRecipe(recipe);
      if (hasInternet) {
        await client
            .deleteRecipe(id)
            .then((it) => debugPrint("Deleted Recipe with id " + id.toString() + ' ' +it.toString()))
            .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        });
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> updateRecipe(Recipe recipe) async {
    try {
      await recipeDao.updateRecipe(recipe);
      if (hasInternet) {
        await client
            .putRecipe(recipe)
            .then((it) => print(it.toString()))
            .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        });
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<Recipe>> getRecipes() async {
    var res = recipeDao.findAllRecipes();
    try {
      if (hasInternet) {
        res = client.getRecipes().then((it) {
          debugPrint(it[0].toString());
          return it;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          return [];
        });
      }
    } on Exception catch (error) {
      return Future.error(error);
    }

    return res.then(
      (recipeDTO) => recipeDTO
          .map((element) => element)
          .toList(growable: true),
    );
  }
}