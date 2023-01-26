import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;
import '../model/recipe.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://localhost:8080/api")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/cocktails")
  Future<List<Recipe>> getRecipes();

  @GET("/cocktails/{id}")
  Future<Recipe> getRecipe(@Path() String id);

  @POST("/cocktails")
  Future<Recipe> postRecipe(@Body() Recipe recipe);

  @PUT("/cocktails")
  Future<Recipe> putRecipe(@Body() Recipe recipe);

  @DELETE("/cocktails/{id}")
  Future<Recipe> deleteRecipe(@Path() String id);
}