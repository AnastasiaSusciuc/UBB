import 'dart:async';
import 'package:access/models/my_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/my_entity_dao.dart';
part 'database.g.dart';

@Database(version: 1, entities: [MyEntity])
abstract class AppDatabase extends FloorDatabase {
  MyEntityDao get myEntityDao;
}