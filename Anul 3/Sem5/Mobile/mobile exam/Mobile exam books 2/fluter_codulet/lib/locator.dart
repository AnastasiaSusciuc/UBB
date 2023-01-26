import 'package:fluter_codulet/repo/book_repo.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerLazySingleton<BookRepo>(() => BookRepo());
}
