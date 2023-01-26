
import 'package:access/models/my_entity.dart';
import 'package:access/repo/entity_repo.dart';

class Screen1ViewModel {
  final MyEntityRepo _repo;

  Screen1ViewModel(this._repo);

  Future<bool> addMyEntity(MyEntity myEntity) {
    print("VM my Entity");
    return _repo.addMyEntity(myEntity);
  }

  Future<List<MyEntity>> getMyEntities() {
    return _repo.getAllMyEntities();
  }

  Future<bool> updateMyEntity(MyEntity myEntity) {
    return _repo.updateMyEntity(myEntity);
  }

  Future<MyEntity> getEntityById(int id) {
    return _repo.getById(id);
  }

}