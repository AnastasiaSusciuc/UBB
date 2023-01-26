

import 'package:code_shopping/models/parking.dart';

import '../../repo/parking_repo.dart';

class BorrowViewModel {
  final ParkingRepo _repo;

  BorrowViewModel(this._repo);

  Future<List<Parking>> getAvailable() {
    return _repo.getAvailableParkings();
  }

  Future<Parking> borrowBook(int? id) async{
    var book = _repo.takeParking(id!);
    return await book;
  }

}