import 'package:template_cod/repo/entity_repo.dart';
import '../../models/my_entity.dart';

class Screen3ViewModel {
  final MyEntityRepo _repo;

  Screen3ViewModel(this._repo);

  Future<List<MyEntity>> getReport() async {

    print("VM get report");
    var books = await _repo.getAllMyEntitiesWithoutSync();

    // print(books[0].title);
    //todo

    books.sort((a, b) => b.difficulty!.compareTo(a.difficulty!));

    List<MyEntity> result = [];
    for (var i = 0; i < 10; i++) {
      print(books[i].name);
      result.add(books[i]);
    }

    return result;
  }

  Future<MyEntity> getEntityById(int id) {
    print("VM get by id");
    return _repo.getEntityById(id);
  }

  Future<bool> setDifficlty(String dif, int id) {

    return _repo.doSth(id, dif);
  }
}
