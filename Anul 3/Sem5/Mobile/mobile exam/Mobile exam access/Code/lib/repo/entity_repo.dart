import 'dart:collection';
import 'dart:convert';

import 'package:logger/logger.dart';

import '../dao/my_entity_dao.dart';
import '../models/my_entity.dart';
import '../networking/rest_client.dart';

class MyEntityRepo {
  static bool hasInternet = true;
  static bool hasSync = false;
  static late final Logger logger;
  static final queue = Queue<MyEntity>();

  static late final MyEntityDao myEntityDao;
  static late final RestClient client;

  Future<MyEntity> getById(int id) async {
    var res = client.getMyEntity(id).then((value) {
      print(value);
      return value;
    });
    return res;
  }

  Future<bool> addMyEntity(MyEntity myEntity) async {
    print("Add myEntity repo");
    try {
      if (hasInternet) {
        await client.postMyEntity(myEntity).then((it) {
          return myEntityDao.insertMyEntity(it);
        }).onError((error, stackTrace) {});
      } else {
        myEntity.id = DateTime.now().millisecondsSinceEpoch;
        await myEntityDao.insertMyEntity(myEntity);
        queue.add(myEntity);
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<List<MyEntity>> getAllMyEntities() {
    print("get all myEntities");
    Future<List<MyEntity>> res = myEntityDao.findMyEntities();
    try {
      if (hasInternet) {
        res = client.getAllMyEntities().then((value) {
          print(value);
          return value;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          return [];
        });
        syncLocalStorage(res);
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return res;
  }

  Future<List<MyEntity>> getAllMyEntitiesWhSync() {
    print("get all myEntities W S");
    Future<List<MyEntity>> res = myEntityDao.findMyEntities();
    try {
      if (hasInternet) {
        res = client.getAllMyEntities().then((value) {
          print(value);
          return value;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          throw Exception("A problem with get entities");
          return [];
        });
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return res;
  }

  Future<bool> updateMyEntity(MyEntity teacher) async {
    try {
      await myEntityDao.updateMyEntity(teacher);
      if (hasInternet) {
        await client
            .editMyEntity(teacher)
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

  Future<void> syncLocalStorage(Future<List<MyEntity>> listBook) async {
    List<MyEntity> listBooks = await listBook;

    for (var book in listBooks) {
      if (book.id == null) {
        continue;
      }
      var exists = await myEntityDao.findMyEntityById(book.id!);

      if (exists == null) {
        await myEntityDao.insertMyEntity(book);
      }
    }
    hasSync = true;
  }

}

class Borrow {
  String id = "1";
  String studentName = "J";

  Borrow(this.id, this.studentName);

  Map toJson() => {
    'id': id,
    'student': studentName,
  };

}
