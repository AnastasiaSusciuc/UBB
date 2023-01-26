import 'dart:io';

import 'package:code_shopping/repo/parking_repo.dart';


class Utils {

  static Future<bool> get checkInternetConnection async {
    try {
      final result = await InternetAddress.lookup('example.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        ParkingRepo.hasInternet = true;

        while(ParkingRepo.queue.isNotEmpty) {
          ParkingRepo().addParking(ParkingRepo.queue.first);
          ParkingRepo.queue.removeFirst();
        }
        while(ParkingRepo.deleteQueue.isNotEmpty) {
          ParkingRepo().deleteParking(ParkingRepo.deleteQueue.first);
          ParkingRepo.deleteQueue.removeFirst();
        }
        return true;
      }
      ParkingRepo.hasInternet = false;
      return false;
    } on SocketException catch (_) {
      ParkingRepo.hasInternet = false;
      return false;
    }
  }
}
