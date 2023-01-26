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

  TeacherDao? _teacherDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Teacher` (`id` TEXT, `lastName` TEXT, `firstName` TEXT, `url` TEXT, `yearsExperience` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TeacherDao get teacherDao {
    return _teacherDaoInstance ??= _$TeacherDao(database, changeListener);
  }
}

class _$TeacherDao extends TeacherDao {
  _$TeacherDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _teacherInsertionAdapter = InsertionAdapter(
            database,
            'Teacher',
            (Teacher item) => <String, Object?>{
                  'id': item.id,
                  'lastName': item.lastName,
                  'firstName': item.firstName,
                  'url': item.url,
                  'yearsExperience': item.yearsExperience
                }),
        _teacherUpdateAdapter = UpdateAdapter(
            database,
            'Teacher',
            ['id'],
            (Teacher item) => <String, Object?>{
                  'id': item.id,
                  'lastName': item.lastName,
                  'firstName': item.firstName,
                  'url': item.url,
                  'yearsExperience': item.yearsExperience
                }),
        _teacherDeletionAdapter = DeletionAdapter(
            database,
            'Teacher',
            ['id'],
            (Teacher item) => <String, Object?>{
                  'id': item.id,
                  'lastName': item.lastName,
                  'firstName': item.firstName,
                  'url': item.url,
                  'yearsExperience': item.yearsExperience
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Teacher> _teacherInsertionAdapter;

  final UpdateAdapter<Teacher> _teacherUpdateAdapter;

  final DeletionAdapter<Teacher> _teacherDeletionAdapter;

  @override
  Future<List<Teacher>> findAllTeachers() async {
    return _queryAdapter.queryList('SELECT * FROM Teacher',
        mapper: (Map<String, Object?> row) => Teacher(
            id: row['id'] as String?,
            lastName: row['lastName'] as String?,
            firstName: row['firstName'] as String?,
            url: row['url'] as String?,
            yearsExperience: row['yearsExperience'] as int?));
  }

  @override
  Future<Teacher?> findTeacherById(String id) async {
    return _queryAdapter.query('SELECT * FROM Teacher WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Teacher(
            id: row['id'] as String?,
            lastName: row['lastName'] as String?,
            firstName: row['firstName'] as String?,
            url: row['url'] as String?,
            yearsExperience: row['yearsExperience'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> insertTeacher(Teacher teacher) async {
    await _teacherInsertionAdapter.insert(teacher, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTeacher(Teacher phteacheroto) async {
    await _teacherUpdateAdapter.update(phteacheroto, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTeacher(Teacher teacher) async {
    await _teacherDeletionAdapter.delete(teacher);
  }
}
