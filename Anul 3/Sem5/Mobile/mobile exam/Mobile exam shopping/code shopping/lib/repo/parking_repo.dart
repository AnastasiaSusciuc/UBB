import 'dart:collection';

import 'package:logger/logger.dart';


import '../dao/parking_dao.dart';
import '../models/parking.dart';
import '../networking/rest_client.dart';

class ParkingRepo {
  static bool hasInternet = true;
  static bool hasSync = false;
  static late final Logger logger;
  static final queue = Queue<Parking>();
  static final deleteQueue = Queue<int>();

  static late final ParkingDao parkingDao;
  static late final RestClient client;

  Future<bool> addParking(Parking parking) async {
    print("Add parking repo");
    try {
      if (hasInternet) {
        await client.postParking(parking).then((it) {
          return parkingDao.insertParking(it);
        }).onError((error, stackTrace) {});
      } else {
        parking.id = DateTime.now().millisecondsSinceEpoch;
        await parkingDao.insertParking(parking);
        queue.add(parking);
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<List<Parking>> getParkings() async {
    print("get parkings");
    Future<List<Parking>> res = parkingDao.findAllParkings();

    try {
      if (hasInternet) {
        res = client.getParkings().then((value) {
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

  Future<List<Parking>> getAvailableParkings() async {
    print("get available parkings");
    Future<List<Parking>> res;
    try {
      if (hasInternet) {
        print("REPO HAS INT");
        res = client.getAvailableParkings().then((value) {
          print("DA");
          print(value);
          return value;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          return [];
        });
        return res;
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return [];
  }

  Future<void> syncLocalStorage(Future<List<Parking>> listParking) async {
    List<Parking> listParkings = await listParking;

    for (var parking in listParkings) {
      if (parking.id == null) {
        continue;
      }
      var exists = await parkingDao.findParkingById(parking.id!);

      if (exists == null) {
        await parkingDao.insertParking(parking);
      }
    }
    hasSync = true;
  }

  Future<Parking> takeParking(int id) {
    print("borrow parking $id");
    Borrow obj = Borrow(id, "ceva");

    var parking = client.borrowParking(obj).then((value) {
      print("take");
      print(value);
      return value;
    });
    return parking;
  }

  Future<List<Parking>> getAllParkings() async {
    print("get all parkings");
    Future<List<Parking>> res;
    try {
      if (hasInternet) {
        res = client.getAllParkings().then((value) {
          print("All parkings");
          print(value);
          return value;
        }).onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          throw Exception("Cannot connect");

        });
        return res;
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return [];
  }

  Future<bool> deleteParking(int id) async {

    print("REPO DELETE $id");

    try {

      print("HAS internet $hasInternet");
      // todo
      if (hasInternet) {
        print("Sending delete request to server");
        await client
            .deleteParking(id)
            .then((it) => print(it.number))
            .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        });
      }
      else {
        deleteQueue.add(id);
      }

      final teacher = await parkingDao.findParkingById(id);
      if (teacher == null) return false;
      parkingDao.deleteParking(teacher);
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

}

class Borrow {
  int id = 1;
  String studentName = "J";

  Borrow(this.id, this.studentName);

  Map toJson() => {
    'id': id,
    'student': studentName,
  };

}

// client.borrowParking(obj.toJson());