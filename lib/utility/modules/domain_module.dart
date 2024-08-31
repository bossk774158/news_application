import 'package:news_application/features/news/repository/news_usecase.dart';
import 'package:news_application/utility/modules/base_module.dart';

void domainModule() {
  injector.registerLazySingleton(() => GetNewsUseCase(injector()));
}
