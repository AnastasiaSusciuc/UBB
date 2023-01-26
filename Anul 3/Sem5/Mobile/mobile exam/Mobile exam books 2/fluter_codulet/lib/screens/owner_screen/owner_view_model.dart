import '../../models/book.dart';
import '../../repo/book_repo.dart';

class OwnerViewModel {
  final BookRepo _repo;

  OwnerViewModel(this._repo);

  Future<bool> addBook(Book book) {
    print("VM book");
    return _repo.addBook(book);
  }

  Future<List<Book>> getBooks(String name) {
    return _repo.getStudentsBooks(name);
  }

  bool getSyncStatus() {
    return BookRepo.hasSync;
  }

}