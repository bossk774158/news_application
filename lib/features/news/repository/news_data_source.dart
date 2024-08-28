// news_data_source.dart
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsDataSource {
  Future<Either<GetNewsResponseModel, Error>> getNews();
}

class NewsDataSourceImpl implements NewsDataSource {
  static const _baseUrl = "https://newsapi.org/v2/";
  static const _apiKey = "c441f5a3edb24ae1ac9b834ebf32d771";

  @override
  Future<Either<GetNewsResponseModel, Error>> getNews() async {
    const endpoint = 'top-headlines?country=us';
    final url = Uri.parse('$_baseUrl$endpoint&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final newsResponse = GetNewsResponseModel.fromJson(jsonResponse);
      print(newsResponse);
      return Left(newsResponse);
    } else if (response.statusCode == 429) {
      print('API limit exceeded. Please try again later.');
      return Right(Error());
    } else {
      print('Failed to fetch news. Status code: ${response.statusCode}');
      return Right(Error());
    }
  }
}
