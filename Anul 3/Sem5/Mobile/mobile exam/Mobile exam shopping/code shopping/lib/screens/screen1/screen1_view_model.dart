import '../../models/parking.dart';
import '../../repo/parking_repo.dart';

class Screen1ViewModel {
  final ParkingRepo _repo;

  Screen1ViewModel(this._repo);

  Future<bool> addParking(Parking parking) {
    print("VM parking");
    return _repo.addParking(parking);
  }

  Future<List<Parking>> getParkings() {
    return _repo.getParkings();
  }

  bool getSyncStatus() {
    return ParkingRepo.hasSync;
  }

  Future<bool> deleteParking(int id){
    print("Delete parking");
    return _repo.deleteParking(id);
  }

}