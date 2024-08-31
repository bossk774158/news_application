import 'package:news_application/features/news/business_logic/news_bloc.dart';
import 'package:news_application/utility/modules/base_module.dart';

void presentationModule() {
  injector.registerFactory(() => NewsBloc(
        injector(),
      ));
}
