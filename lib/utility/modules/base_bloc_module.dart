import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/features/news/business_logic/news_bloc.dart';
import 'package:news_application/utility/modules/base_module.dart';

class AppBloc {
  static List<BlocProvider> getAllProviders() => [
        BlocProvider<NewsBloc>(create: (context) => injector.get<NewsBloc>()),
      ];
}
