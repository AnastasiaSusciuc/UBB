// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../DAO/recipe_dao.dart';
import '../model/recipe.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Recipe])
abstract class AppDatabase extends FloorDatabase {
  RecipeDao get recipeDao;
}