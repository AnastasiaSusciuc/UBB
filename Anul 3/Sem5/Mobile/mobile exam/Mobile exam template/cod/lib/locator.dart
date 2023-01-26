import 'package:get_it/get_it.dart';
import 'package:template_cod/repo/entity_repo.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerLazySingleton<MyEntityRepo>(() => MyEntityRepo());
}
