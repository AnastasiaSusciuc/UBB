// database.dart
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/parking_dao.dart';
import '../models/parking.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Parking])
abstract class AppDatabase extends FloorDatabase {
  ParkingDao get parkingDao;
}