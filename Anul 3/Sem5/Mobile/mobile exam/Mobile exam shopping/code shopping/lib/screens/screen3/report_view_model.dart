import 'package:code_shopping/models/parking.dart';
import 'package:code_shopping/repo/parking_repo.dart';

abstract class ReportVM {
  Future<List<Parking>> getReport();
}

class ReportViewModel extends ReportVM{
  final ParkingRepo _repo;

  ReportViewModel(this._repo);

  Future<List<Parking>> getReport() async {
    print("VM get report");
    var books = await _repo.getAllParkings();

    // final propertyA = d(a);
    // final propertyB = someProperty(b);
    //
    // if (propertyA < propertyB) {
    //   return -1;
    // } else if (propertyA > propertyB) {
    //   return 1;
    // } else {
    //   return 0;
    // }

    // books.sort((a, b) => {if (a.number < b.number) {
    //   return -1;
    // } else if (a.number > b.number) {
    // return 1;
    // } else {
    // return 0;
    // }})

    books.sort((a, b) => b.count!.compareTo(a.count!));

    List<Parking> result = [];
    for (var i = 0; i < 15; i++) {
      print(books[i].number);
      result.add(books[i]);
    }

    return result;
  }

}