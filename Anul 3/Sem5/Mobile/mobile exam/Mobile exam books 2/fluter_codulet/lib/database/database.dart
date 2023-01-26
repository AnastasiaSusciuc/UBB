// database.dart
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/book_dao.dart';
import '../models/book.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Book])
abstract class AppDatabase extends FloorDatabase {
  BookDao get bookDao;
}