import 'package:get_it/get_it.dart';
import 'package:news_application/utility/modules/data_module.dart';
import 'package:news_application/utility/modules/domain_module.dart';
import 'package:news_application/utility/modules/presentation_module.dart';

GetIt injector = GetIt.instance;

void initModule() {
  dataModule();
  domainModule();
  presentationModule();
}
