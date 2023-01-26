import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;

import '../models/my_entity.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("rules")
  Future<List<MyEntity>> getAllMyEntities();

  // @GET("available")
  // Future<List<MyEntity>> getAvailableMyEntities();
  //
  @GET("rule/{id}")
  Future<MyEntity> getMyEntity(@Path() int id);

  @POST("rule")
  Future<MyEntity> postMyEntity(@Body() MyEntity myEntity);
  //
  @POST("update")
  Future<MyEntity> editMyEntity(@Body() MyEntity myEntity);

  // @PUT("books/{id}")
  // Future<MyEntity> putMyEntity(@Path() String id, @Body() MyEntity myEntity);

  // @DELETE("books/{id}")
  // Future<MyEntity> deleteMyEntity(@Path() String id);
}
