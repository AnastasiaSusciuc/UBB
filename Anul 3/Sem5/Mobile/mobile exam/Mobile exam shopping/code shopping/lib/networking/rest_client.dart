import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;

import '../models/parking.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("spaces")
  Future<List<Parking>> getParkings();

  @GET("spaces")
  Future<List<Parking>> getAllParkings();

  @GET("free")
  Future<List<Parking>> getAvailableParkings();

  @GET("parking/{id}")
  Future<Parking> getParking(@Path() String id);

  @POST("space")
  Future<Parking> postParking(@Body() Parking parking);

  @POST("take")
  Future<Parking> borrowParking(@Body() Object obj);

  @PUT("space/{id}")
  Future<Parking> putParking(@Path() String id, @Body() Parking parking);

  @DELETE("space/{id}")
  Future<Parking> deleteParking(@Path() int id);
}
