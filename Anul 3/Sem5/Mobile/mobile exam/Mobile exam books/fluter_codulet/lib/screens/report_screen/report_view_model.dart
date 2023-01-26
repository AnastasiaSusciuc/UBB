import '../../models/book.dart';
import '../../repo/book_repo.dart';

class ReportViewModel {
  final BookRepo _repo;

  ReportViewModel(this._repo);

  Future<List<Book>> getReport() async {
    print("VM get report");
    var books = await _repo.getAllBooks();

    print(books[0].title);

    books.sort((a, b) => b.usedCount!.compareTo(a.usedCount!));

    List<Book> result = [];
    for (var i = 0; i < 10; i++) {
      print(books[i].title);
      result.add(books[i]);
    }

    return result;
  }

}