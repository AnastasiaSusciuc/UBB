
import 'package:access/models/my_entity.dart';
import 'package:access/repo/entity_repo.dart';

class Screen2ViewModel {
  final MyEntityRepo _repo;

  Screen2ViewModel(this._repo);

  Future<List<MyEntity>> getMyEntitiesBetween(int start, int end) async {
    print("SALI1");
    var ceva = await _repo.getAllMyEntitiesWhSync();
    print("SALI2");

    List<MyEntity> my_list = [];

    for (var c in ceva) {
      print("rule ${c.name} ${c.from} ${c.to}" );
      print("start $start $end");

      if (c.from! >= start && c.to! <= end) {
        print(c.name);
        my_list.add(c);
      }
    }
    return my_list;
  }

  Future<List<MyEntity>> getMyEntitiesLevel(int level) async {

    // try {
      var ceva = await _repo.getAllMyEntitiesWhSync();
    // } on Exception {
    //
    // }
    List<MyEntity> my_list = [];

    for (var c in ceva) {

      if (c.level == level) {
        print(c.name);
        my_list.add(c);
      }
    }
    my_list.sort((a,b)  {
      int cmp = a.from!.compareTo(b.from!);
      if (cmp == 0){
        int cmp2 = a.to!.compareTo(b.to!);
        if (cmp2 == 0){
          return a.status!.compareTo(b.status!);
        } else {
          return cmp2;
        }
      } else {
        return cmp;
      }
    });

    return my_list;
  }

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