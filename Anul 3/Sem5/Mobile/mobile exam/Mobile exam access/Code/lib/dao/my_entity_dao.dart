import 'package:floor/floor.dart';
import '../models/my_entity.dart';


@dao
abstract class MyEntityDao {
  @Query('SELECT * FROM MyEntity')
  Future<List<MyEntity>> findMyEntities();

  @Query('SELECT * FROM MyEntity WHERE id = :id')
  Future<MyEntity?> findMyEntityById(int id);

  @insert
  Future<void> insertMyEntity(MyEntity entity);

  @delete
  Future<void> deleteMyEntity(MyEntity entity);

  @update
  Future<void> updateMyEntity(MyEntity entity);
}