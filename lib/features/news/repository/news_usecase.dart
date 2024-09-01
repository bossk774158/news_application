import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/features/news/repository/news_repository.dart';
import 'package:news_application/utility/base_usecase.dart';

class GetNewsUseCase implements BaseUseCase<GetNewsResponseModel, String?> {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  @override
  Future<Either<GetNewsResponseModel, Error>> call({required String? params}) async {
    return await repository.getNews(params);
  }
}
