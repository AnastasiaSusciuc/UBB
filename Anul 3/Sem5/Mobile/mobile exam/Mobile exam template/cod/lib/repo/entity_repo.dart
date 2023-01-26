import 'dart:collection';

import 'package:logger/logger.dart';

import '../dao/my_entity_dao.dart';
import '../models/my_entity.dart';
import '../networking/rest_client.dart';

class MyEntityRepo {
  static bool hasInternet = true;
  static bool hasSync1 = false;
  static bool hasSync2 = false;

  static final addQueue = Queue<MyEntity>();
  static final deleteQueue = Queue<MyEntity>();

  static late final MyEntityDao myEntityDao;
  static late final RestClient client;
  static late final Logger logger;

  static List <String> syncCateg = [];


  Future<MyEntity> getEntityById(int id) async {
    // todo: to work when offline
    print("get myEntity by id");
    logger.d("get myEntity by id");

    var res = client.getMyEntity(id).then((value) {
      print(value);
      return value;
    });
    return res;
  }

  Future<bool> addMyEntity(MyEntity myEntity) async {
    print("Add myEntity repo");
    logger.d("Add myEntity repo");
    try {
      if (hasInternet) {
        await client.postMyEntity(myEntity).then((it) {
          return myEntityDao.insertMyEntity(it);
        }).onError((error, stackTrace) {});
      } else {
        myEntity.id = DateTime.now().millisecondsSinceEpoch;
        await myEntityDao.insertMyEntity(myEntity);
        addQueue.add(myEntity);
      }
      return true;
    } on Exception catch (error) {
      throw Exception("A problem with add my entity");
    }
  }

  void updateMyEntityId(MyEntity myEntity) async {
    myEntityDao.updateMyEntity(myEntity);
  }

  Future<List<String>> getAllMyEntitys() {

    print("get all categories");
    logger.d("get all myEntitys");
    // Future<List<String>> res = syncCateg;
    var res;
    try {
      if (hasInternet) {
        res = client.getAllMyEntities().then((value) {
          print(value);
          return value;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          throw Exception("A problem with get all my entities");
        });
        // todo
        syncLocalStorage(res);
      }
      // else {
      //   return syncCateg;
      // }

    } on Exception catch (error) {
      return Future.error(error);
    }
    return res;
  }

  Future<List<MyEntity>> getAllMyEntitiesWithoutSync() {
    print("get all myEntities without sync");
    logger.d("get all myEntities without sync");
    // Future<List<MyEntity>> res = myEntityDao.findAllMyEntitys();
    var res;
    try {
      if (hasInternet) {
        res = client.getAllMyEntitiesEasy().then((value) {
          print("ALO");
          print(value);
          return value;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          throw Exception("A problem with get entities");
        });
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return res;
  }

  // Future<List<MyEntity>> getAllMyEntitiesWithoutSyncProp() {
  //   print("get all myEntities without sync");
  //   logger.d("get all myEntities without sync");
  //   Future<List<MyEntity>> res = myEntityDao.findAllMyEntitys();
  //   try {
  //     if (hasInternet) {
  //       res = client.getAllMyEntities().then((value) {
  //         print(value);
  //         return value;
  //       }).onError((error, stackTrace) {
  //         print(error);
  //         print(stackTrace);
  //         throw Exception("A problem with get entities");
  //       });
  //     }
  //   } on Exception catch (error) {
  //     return Future.error(error);
  //   }
  //   return res;
  // }

  Future<bool> updateMyEntity(MyEntity myEntity) async {
    print("Update my entity");
    logger.d("Update my entity");
    try {
      await myEntityDao.updateMyEntity(myEntity);
      if (hasInternet) {
        await client
            .editMyEntity(myEntity)
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

  Future<bool> deleteMyEntity(int id) async {
    logger.d("delete my entity");
    print("delete my entity $id");
    try {
      // final teacher = await myEntityDao.findMyEntityById(id);
      // if (teacher == null) return false;
      // myEntityDao.deleteMyEntity(teacher);
      if (hasInternet) {
        await client
            .deleteMyEntity(id)
            .then((it) => print(it))
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

  Future<void> syncLocalStorage(Future<List<String>> listMyEntity) async {
    print("Sync local storage");
    logger.d("sync");

    syncCateg = await listMyEntity;

    // for (var entity in listMyEntitys) {
    //   if (entity.id == null) {
    //     continue;
    //   }
    //   var exists = await myEntityDao.findMyEntityById(entity.id!);
    //
    //   if (exists == null) {
    //     await myEntityDao.insertMyEntity(entity);
    //   }
    // }
    hasSync1 = true;
  }

  Future<bool> doSth(int examId, String diff) async {
    print("enroll my exam");
    logger.d("enroll");
    try {
      if (hasInternet) {
        var ceva = SendObjJson(examId, diff);
        await client
            .postMyEntity2(ceva)
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

  Future<List<MyEntity>> getRecipeCateg(String categ) {

    print("Repo $categ");
    var res;
    try {
      if (hasInternet) {
        res = client.getRecipeCateg(categ).then((value) {
          print(value);
          return value;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          throw Exception("A problem with get all my entities");
        });
        // todo
        // syncLocalStorage(res);
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return res;
  }

}


class SendObjJson {
  int id = 1;
  String attribute = "J";

  SendObjJson(this.id, this.attribute);

  Map toJson() => {
    'id': id,
    'difficulty': attribute,
  };

}
