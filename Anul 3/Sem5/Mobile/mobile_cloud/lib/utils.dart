import 'dart:io';

import 'package:mobile_cloud/repo/teacher_repo.dart';

class Utils {

  static Future<bool> get checkInternetConnection async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        TeacherRepo.hasInternet = true;
        while(TeacherRepo.queue.isNotEmpty) {
          TeacherRepo().addTeacher(TeacherRepo.queue.first);
          TeacherRepo.queue.removeFirst();
        }
        return true;
      }
      TeacherRepo.hasInternet = false;
      return false;
    } on SocketException catch (_) {
      TeacherRepo.hasInternet = false;
      return false;
    }
  }
}
