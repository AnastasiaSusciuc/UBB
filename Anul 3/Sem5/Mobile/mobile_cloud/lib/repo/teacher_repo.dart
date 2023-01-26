import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../DAOs/teacher_dao.dart';
import '../models/teacher/teacher.dart';
import '../networking/rest_client.dart';

class TeacherRepo {
  static bool hasInternet = true;
  static late final Logger logger;
  static final queue = Queue<Teacher>();

  static late final TeacherDao personDao;
  static late final RestClient client;

  Future<bool> addTeacher(Teacher teacher) async {
    try {
      if (hasInternet) {
        await client
            .postTeacher(teacher)
            .then((it) => personDao.insertTeacher(it))
            .onError((error, stackTrace) {});
      } else {
        teacher.id = DateTime.now().millisecondsSinceEpoch.toString();
        await personDao.insertTeacher(teacher);
        queue.add(teacher);
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> deleteTeacher(String id) async {
    try {
      final teacher = await personDao.findTeacherById(id);
      if (teacher == null) return false;
      personDao.deleteTeacher(teacher);
      if (hasInternet) {
        await client
            .deleteTeacher(id)
            .then((it) => print(it.firstName))
            .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        });
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> updateTeacher(Teacher teacher) async {
    try {
      await personDao.updateTeacher(teacher);
      if (hasInternet) {
        await client
            .putTeacher(teacher.id!, teacher)
            .then((it) => print(it.toString()))
            .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        });
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<List<Teacher>> getTeachers() async {
    var res = personDao.findAllTeachers();
    try {
      if (hasInternet) {
        res = client.getTeachers().then((it) {
          debugPrint(it.toString());
          return it;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          return [];
        });
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return res;
  }
}
