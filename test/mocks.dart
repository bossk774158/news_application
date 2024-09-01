import 'package:mockito/annotations.dart';
import 'package:news_application/features/news/repository/news_repository.dart';
import 'package:news_application/features/news/repository/news_usecase.dart';

@GenerateMocks([NewsRepository, GetNewsUseCase])
void main() {}
