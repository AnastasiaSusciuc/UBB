import 'dart:async';
import 'package:floor/floor.dart';
import 'package:mobile_cloud/DAOs/teacher_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/teacher/teacher.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Teacher])
abstract class AppDatabase extends FloorDatabase {
  TeacherDao get teacherDao;
}

