// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RecipeDao? _recipeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Recipe` (`displayName` TEXT NOT NULL, `difficulty` TEXT NOT NULL, `steps` TEXT NOT NULL, `ingredients` TEXT NOT NULL, `id` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RecipeDao get recipeDao {
    return _recipeDaoInstance ??= _$RecipeDao(database, changeListener);
  }
}

class _$RecipeDao extends RecipeDao {
  _$RecipeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _recipeInsertionAdapter = InsertionAdapter(
            database,
            'Recipe',
            (Recipe item) => <String, Object?>{
                  'displayName': item.displayName,
                  'difficulty': item.difficulty,
                  'steps': item.steps,
                  'ingredients': item.ingredients,
                  'id': item.id
                }),
        _recipeUpdateAdapter = UpdateAdapter(
            database,
            'Recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'displayName': item.displayName,
                  'difficulty': item.difficulty,
                  'steps': item.steps,
                  'ingredients': item.ingredients,
                  'id': item.id
                }),
        _recipeDeletionAdapter = DeletionAdapter(
            database,
            'Recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'displayName': item.displayName,
                  'difficulty': item.difficulty,
                  'steps': item.steps,
                  'ingredients': item.ingredients,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Recipe> _recipeInsertionAdapter;

  final UpdateAdapter<Recipe> _recipeUpdateAdapter;

  final DeletionAdapter<Recipe> _recipeDeletionAdapter;

  @override
  Future<List<Recipe>> findAllRecipes() async {
    return _queryAdapter.queryList('SELECT * FROM Recipe',
        mapper: (Map<String, Object?> row) => Recipe(
            displayName: row['displayName'] as String,
            difficulty: row['difficulty'] as String,
            steps: row['steps'] as String,
            ingredients: row['ingredients'] as String,
            id: row['id'] as String));
  }

  @override
  Future<Recipe?> findRecipeById(String id) async {
    return _queryAdapter.query('SELECT * FROM Recipe WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Recipe(
            displayName: row['displayName'] as String,
            difficulty: row['difficulty'] as String,
            steps: row['steps'] as String,
            ingredients: row['ingredients'] as String,
            id: row['id'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertRecipe(Recipe recipe) async {
    await _recipeInsertionAdapter.insert(recipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    await _recipeUpdateAdapter.update(recipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) async {
    await _recipeDeletionAdapter.delete(recipe);
  }
}
