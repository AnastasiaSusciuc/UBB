import 'package:floor/floor.dart';
import '../models/parking.dart';


@dao
abstract class ParkingDao {
  @Query('SELECT * FROM Parking')
  Future<List<Parking>> findAllParkings();

  @Query('SELECT * FROM Parking WHERE id = :id')
  Future<Parking?> findParkingById(int id);

  @insert
  Future<void> insertParking(Parking parking);

  @delete
  Future<void> deleteParking(Parking parking);

  @update
  Future<void> updateParking(Parking parking);
}