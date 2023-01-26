import 'dart:io';

import '../repo/book_repo.dart';

class Utils {

  static Future<bool> get checkInternetConnection async {
    try {
      final result = await InternetAddress.lookup('example.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        BookRepo.hasInternet = true;
        while(BookRepo.queue.isNotEmpty) {
          BookRepo().addBook(BookRepo.queue.first);
          BookRepo.queue.removeFirst();
        }
        return true;
      }
      BookRepo.hasInternet = false;
      return false;
    } on SocketException catch (_) {
      BookRepo.hasInternet = false;
      return false;
    }
  }
}
