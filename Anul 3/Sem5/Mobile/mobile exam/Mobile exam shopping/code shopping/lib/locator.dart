import 'package:code_shopping/repo/parking_repo.dart';
import 'package:code_shopping/screens/screen3/report_view_model.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerLazySingleton<ParkingRepo>(() => ParkingRepo());
  serviceLocator.registerLazySingleton<ReportVM>(() => ReportViewModel(serviceLocator<ParkingRepo>()));
}
