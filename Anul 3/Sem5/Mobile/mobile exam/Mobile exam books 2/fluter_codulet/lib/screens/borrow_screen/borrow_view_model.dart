import '../../controller/student_controller.dart';
import '../../models/book.dart';
import '../../repo/book_repo.dart';

class BorrowViewModel {
  final BookRepo _repo;

  BorrowViewModel(this._repo);

  Future<List<Book>> getAvailable() {
    return _repo.getAvailableBooks();
  }

  Future<Book> borrowBook(String? id) async{
    var studentName = await StudentControllerImpl.getStudentNameSP();
    var book = _repo.borrowBook(id, studentName);
    return await book;
  }

}