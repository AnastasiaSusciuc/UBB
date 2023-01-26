import 'dart:collection';
import 'dart:convert';

import 'package:logger/logger.dart';

import '../dao/book_dao.dart';
import '../models/book.dart';
import '../networking/rest_client.dart';

class BookRepo {
  static bool hasInternet = true;
  static bool hasSync = false;
  static late final Logger logger;
  static final queue = Queue<Book>();

  static late final BookDao bookDao;
  static late final RestClient client;

  Future<bool> addBook(Book book) async {
    print("Add book repo");
    try {
      if (hasInternet) {
        await client.postBook(book).then((it) {
          return bookDao.insertBook(it);
        }).onError((error, stackTrace) {});
      } else {
        book.id = DateTime.now().millisecondsSinceEpoch.toString();
        await bookDao.insertBook(book);
        queue.add(book);
      }
      return true;
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  Future<List<Book>> getStudentsBooks(String name) async {
    print("get books of a student");
    Future<List<Book>> res = bookDao.findAllBooks();

    try {
      if (hasInternet) {
        res = client.getBooks(name).then((value) {
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

  Future<List<Book>> getAvailableBooks() async {
    print("get available books");
    Future<List<Book>> res;
    try {
      if (hasInternet) {
        print("REPO HAS INT");
        res = client.getAvailableBooks().then((value) {
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

  Future<void> syncLocalStorage(Future<List<Book>> listBook) async {
    List<Book> listBooks = await listBook;

    for (var book in listBooks) {
      if (book.id == null) {
        continue;
      }
      var exists = await bookDao.findBookById(book.id!);

      if (exists == null) {
        await bookDao.insertBook(book);
      }
    }
    hasSync = true;
  }

  Future<Book> borrowBook(String? id, String studentName) {
    print("borrow book");
    Borrow obj = Borrow(id!, studentName);
    var book = client.borrowBook(obj.toJson()).then((value) {
      print("Borrow");
      print(value);
      return value;
    });
    return book;
  }

  Future<List<Book>> getAllBooks() async {
    print("get all books");
    Future<List<Book>> res;
    try {
      if (hasInternet) {
        res = client.getAllBooks().then((value) {
          print("All books");
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

// client.borrowBook(obj.toJson());