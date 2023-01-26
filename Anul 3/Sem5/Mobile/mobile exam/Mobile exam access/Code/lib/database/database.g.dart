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

  MyEntityDao? _myEntityDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `MyEntity` (`id` INTEGER, `name` TEXT, `level` INTEGER, `status` TEXT, `from` INTEGER, `to` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MyEntityDao get myEntityDao {
    return _myEntityDaoInstance ??= _$MyEntityDao(database, changeListener);
  }
}

class _$MyEntityDao extends MyEntityDao {
  _$MyEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _myEntityInsertionAdapter = InsertionAdapter(
            database,
            'MyEntity',
            (MyEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'level': item.level,
                  'status': item.status,
                  'from': item.from,
                  'to': item.to
                }),
        _myEntityUpdateAdapter = UpdateAdapter(
            database,
            'MyEntity',
            ['id'],
            (MyEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'level': item.level,
                  'status': item.status,
                  'from': item.from,
                  'to': item.to
                }),
        _myEntityDeletionAdapter = DeletionAdapter(
            database,
            'MyEntity',
            ['id'],
            (MyEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'level': item.level,
                  'status': item.status,
                  'from': item.from,
                  'to': item.to
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MyEntity> _myEntityInsertionAdapter;

  final UpdateAdapter<MyEntity> _myEntityUpdateAdapter;

  final DeletionAdapter<MyEntity> _myEntityDeletionAdapter;

  @override
  Future<List<MyEntity>> findMyEntities() async {
    return _queryAdapter.queryList('SELECT * FROM MyEntity',
        mapper: (Map<String, Object?> row) => MyEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            level: row['level'] as int?,
            status: row['status'] as String?,
            from: row['from'] as int?,
            to: row['to'] as int?));
  }

  @override
  Future<MyEntity?> findMyEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM MyEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MyEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            level: row['level'] as int?,
            status: row['status'] as String?,
            from: row['from'] as int?,
            to: row['to'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> insertMyEntity(MyEntity entity) async {
    await _myEntityInsertionAdapter.insert(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMyEntity(MyEntity entity) async {
    await _myEntityUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMyEntity(MyEntity entity) async {
    await _myEntityDeletionAdapter.delete(entity);
  }
}
