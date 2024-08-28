import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/repository/news_data_source.dart';
import 'package:news_application/features/news/repository/news_model.dart';

abstract class NewsRepository {
  Future<Either<GetNewsResponseModel, Error>> getNews();
}

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource bookingDataSource;

  NewsRepositoryImpl(this.bookingDataSource);

  @override
  Future<Either<GetNewsResponseModel, Error>> getNews() {
    Future<Either<GetNewsResponseModel, Error>> response = bookingDataSource.getNews();
    return response;
  }
}
