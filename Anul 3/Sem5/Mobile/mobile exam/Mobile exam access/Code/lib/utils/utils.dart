import 'dart:io';

import 'package:access/repo/entity_repo.dart';

class Utils {
  static Future<bool> get checkInternetConnection async {
    // throw Error();
    try {
      final result = await InternetAddress.lookup('example.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        MyEntityRepo.hasInternet = true;
        while (MyEntityRepo.queue.isNotEmpty) {
          MyEntityRepo().addMyEntity(MyEntityRepo.queue.first);
          MyEntityRepo.queue.removeFirst();
        }
        return true;
      }
      MyEntityRepo.hasInternet = false;
      return false;
    } on SocketException catch (_) {
      MyEntityRepo.hasInternet = false;
      return false;
    }
  }
}
