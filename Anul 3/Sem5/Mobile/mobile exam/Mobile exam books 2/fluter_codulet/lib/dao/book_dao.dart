import 'package:floor/floor.dart';
import 'package:fluter_codulet/models/book.dart';


@dao
abstract class BookDao {
  @Query('SELECT * FROM Book')
  Future<List<Book>> findAllBooks();

  @Query('SELECT * FROM Book WHERE id = :id')
  Future<Book?> findBookById(String id);

  @insert
  Future<void> insertBook(Book book);

  @delete
  Future<void> deleteBook(Book book);

  @update
  Future<void> updateBook(Book book);
}