import '../../models/my_entity.dart';
import '../../repo/entity_repo.dart';

class Screen1ViewModel {
  final MyEntityRepo _repo;

  Screen1ViewModel(this._repo);

  Future<bool> addMyEntity(MyEntity myEntity) {
    print("VM add");
    return _repo.addMyEntity(myEntity);
  }

  // Future<List<MyEntity>> getMyEntities() {
  //   print("VM get all");
  //   return _repo.getAllMyEntitys();
  // }

  Future<bool> updateMyEntity(MyEntity myEntity) {
    print("VM update");
    return _repo.updateMyEntity(myEntity);
  }

  Future<MyEntity> getEntityById(int id) {
    print("VM get by id");
    return _repo.getEntityById(id);
  }

  Future<List<String>> getCateg() {
    print("VM get categ");
    return _repo.getAllMyEntitys();
  }

  Future<List<MyEntity>> getRecipeForCateg(String categ) {
    print("VM get recipe c $categ");
    return _repo.getRecipeCateg(categ);
  }

  Future<bool> deleteRecipe(int id){
    print("Delete teacher $id");
    return _repo.deleteMyEntity(id);
  }

}