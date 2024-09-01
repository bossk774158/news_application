import 'package:get_it/get_it.dart';
import 'package:news_application/utility/module/data_module.dart';
import 'package:news_application/utility/module/domain_module.dart';
import 'package:news_application/utility/module/presentation_module.dart';

GetIt injector = GetIt.instance;

void initModule() {
  dataModule();
  domainModule();
  presentationModule();
}
