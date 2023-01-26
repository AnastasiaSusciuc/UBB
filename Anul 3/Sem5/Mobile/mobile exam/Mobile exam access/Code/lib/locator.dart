import 'package:access/repo/entity_repo.dart';
import 'package:access/screen/screen1/screen1_view_model.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerLazySingleton<MyEntityRepo>(() => MyEntityRepo());
}
