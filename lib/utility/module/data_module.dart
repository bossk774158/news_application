import 'package:news_application/features/news/repository/news_data_source.dart';
import 'package:news_application/features/news/repository/news_repository.dart';
import 'package:news_application/utility/module/base_module.dart';

void dataModule() {
  // datasource
  injector.registerLazySingleton<NewsDataSource>(() => NewsDataSourceImpl());

  // repository
  injector.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(injector()));
}
