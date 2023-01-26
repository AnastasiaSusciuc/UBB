import 'package:floor/floor.dart';

import '../model/recipe.dart';


@dao
abstract class RecipeDao {
  @Query('SELECT * FROM Recipe')
  Future<List<Recipe>> findAllRecipes();

  @Query('SELECT * FROM Recipe WHERE id = :id')
  Future<Recipe?> findRecipeById(String id);

  @insert
  Future<void> insertRecipe(Recipe recipe);

  @delete
  Future<void> deleteRecipe(Recipe recipe);

  @update
  Future<void> updateRecipe(Recipe recipe);
}