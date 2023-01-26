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

  ParkingDao? _parkingDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Parking` (`id` INTEGER, `number` TEXT, `address` TEXT, `status` TEXT, `count` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ParkingDao get parkingDao {
    return _parkingDaoInstance ??= _$ParkingDao(database, changeListener);
  }
}

class _$ParkingDao extends ParkingDao {
  _$ParkingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _parkingInsertionAdapter = InsertionAdapter(
            database,
            'Parking',
            (Parking item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'address': item.address,
                  'status': item.status,
                  'count': item.count
                }),
        _parkingUpdateAdapter = UpdateAdapter(
            database,
            'Parking',
            ['id'],
            (Parking item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'address': item.address,
                  'status': item.status,
                  'count': item.count
                }),
        _parkingDeletionAdapter = DeletionAdapter(
            database,
            'Parking',
            ['id'],
            (Parking item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'address': item.address,
                  'status': item.status,
                  'count': item.count
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Parking> _parkingInsertionAdapter;

  final UpdateAdapter<Parking> _parkingUpdateAdapter;

  final DeletionAdapter<Parking> _parkingDeletionAdapter;

  @override
  Future<List<Parking>> findAllParkings() async {
    return _queryAdapter.queryList('SELECT * FROM Parking',
        mapper: (Map<String, Object?> row) => Parking(
            id: row['id'] as int?,
            number: row['number'] as String?,
            status: row['status'] as String?,
            address: row['address'] as String?,
            count: row['count'] as int?));
  }

  @override
  Future<Parking?> findParkingById(int id) async {
    return _queryAdapter.query('SELECT * FROM Parking WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Parking(
            id: row['id'] as int?,
            number: row['number'] as String?,
            status: row['status'] as String?,
            address: row['address'] as String?,
            count: row['count'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> insertParking(Parking parking) async {
    await _parkingInsertionAdapter.insert(parking, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateParking(Parking parking) async {
    await _parkingUpdateAdapter.update(parking, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteParking(Parking parking) async {
    await _parkingDeletionAdapter.delete(parking);
  }
}
