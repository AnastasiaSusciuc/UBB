// import '../../models/my_entity.dart';
// import '../../repo/entity_repo.dart';
//
// class Screen2ViewModel {
//   final MyEntityRepo _repo;
//
//   Screen2ViewModel(this._repo);
//
//   Future<bool> addMyEntity(MyEntity myEntity) {
//     print("VM add");
//     return _repo.addMyEntity(myEntity);
//   }
//
//   Future<List<MyEntity>> getMyEntities() {
//     return [];
//     print("VM get all");
//     // return _repo.getAllMyEntitys();
//   }
//
//   Future<bool> updateMyEntity(MyEntity myEntity) {
//     print("VM update");
//     return _repo.updateMyEntity(myEntity);
//   }
//
//   Future<MyEntity> getEntityById(int id) {
//     print("VM get by id");
//     return _repo.getEntityById(id);
//   }
//
//   Future<List<MyEntity>> getMyEntitiesProp() {
//     print("VM get all with property");
//     return _repo.getAllMyEntitiesWithoutSyncProp();
//   }
//
//   Future<bool> doSth(int i) async{
//     print("VM do sth");
//     return _repo.doSth(i);
// }
//
// }