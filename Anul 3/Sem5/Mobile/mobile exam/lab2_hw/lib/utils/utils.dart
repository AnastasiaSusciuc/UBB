import 'dart:io';

import '../repo/recipe_repo.dart';
import 'package:http/http.dart' as http;

class Utils {
  static Future<bool> get internetSync async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'));
      bool bHas = (response.statusCode == 200);
      print(bHas.toString());
      if (bHas) {
        RecipeRepo.hasInternet = true;
        for (var value in RecipeRepo.queuedRecipes) {
          RecipeRepo().addRecipe(value).then((elem) => RecipeRepo.queuedRecipes.remove(value));
        }
        return true;
      }
      RecipeRepo.hasInternet = false;
      return false;
    } on SocketException catch (_) {
      RecipeRepo.hasInternet = false;
      return false;
    }
  }
}