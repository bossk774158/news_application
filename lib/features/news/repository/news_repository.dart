import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/repository/news_data_source.dart';
import 'package:news_application/features/news/repository/news_model.dart';

abstract class NewsRepository {
  Future<Either<GetNewsResponseModel, Error>> getNews(String? topic);
}

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource bookingDataSource;

  NewsRepositoryImpl(this.bookingDataSource);

  @override
  Future<Either<GetNewsResponseModel, Error>> getNews(String? topic) {
    Future<Either<GetNewsResponseModel, Error>> response = bookingDataSource.getNews(topic);
    return response;
  }
}
