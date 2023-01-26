import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;

import '../models/book.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/api/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("books/{student}")
  Future<List<Book>> getBooks(@Path() String student);

  @GET("all")
  Future<List<Book>> getAllBooks();

  @GET("available")
  Future<List<Book>> getAvailableBooks();

  @GET("books/{id}")
  Future<Book> getBook(@Path() String id);

  @POST("book")
  Future<Book> postBook(@Body() Book book);

  @POST("borrow")
  Future<Book> borrowBook(@Body() Object json);

  @PUT("books/{id}")
  Future<Book> putBook(@Path() String id, @Body() Book book);

  @DELETE("books/{id}")
  Future<Book> deleteBook(@Path() String id);
}
