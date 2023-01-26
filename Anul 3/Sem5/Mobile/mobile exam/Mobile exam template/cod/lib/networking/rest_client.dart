import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;

import '../models/my_entity.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("categories")
  Future<List<String>> getAllMyEntities();

  @GET("easiest")
  Future<List<MyEntity>> getAllMyEntitiesEasy();

  @GET("recipes/{id}")
  Future<List<MyEntity>> getRecipeCateg(@Path() String id);

  @GET("draft")
  Future<List<MyEntity>> getAllMyEntitiesProp();

  @GET("exam/{id}")
  Future<MyEntity> getMyEntity(@Path() int id);

  @POST("recipe")
  Future<MyEntity> postMyEntity(@Body() MyEntity myEntity);

  @POST("difficulty")
  Future<MyEntity> postMyEntity2(@Body() Object myEntity);

  @POST("entity")
  Future<MyEntity> editMyEntity(@Body() MyEntity myEntity);

  @PUT("entity/{id}")
  Future<MyEntity> putMyEntity(@Path() int id, @Body() MyEntity myEntity);

  @DELETE("recipe/{id}")
  Future<MyEntity> deleteMyEntity(@Path() int id);
}
