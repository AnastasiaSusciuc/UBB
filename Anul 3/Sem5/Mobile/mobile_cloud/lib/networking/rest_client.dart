import 'package:mobile_cloud/models/teacher/teacher.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/api")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/teachers")
  Future<List<Teacher>> getTeachers();

  @GET("/teachers/{id}")
  Future<Teacher> getTeacher(@Path() String id);

  @POST("/teachers")
  Future<Teacher> postTeacher(@Body() Teacher teacher);

  @PUT("/teachers/{id}")
  Future<Teacher> putTeacher(@Path() String id, @Body() Teacher teacher);

  @DELETE("/teachers/{id}")
  Future<Teacher> deleteTeacher(@Path() String id);
}
