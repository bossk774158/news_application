import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/features/news/repository/news_repository.dart';
import 'package:news_application/utility/base_usecase.dart';

class GetNewsUseCase implements BaseUseCase<GetNewsResponseModel, NoParams> {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  @override
  Future<Either<GetNewsResponseModel, Error>> call({NoParams? params}) async {
    return await repository.getNews();
  }
}
