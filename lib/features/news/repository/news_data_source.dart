import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:http/http.dart' as http;

class FetchDataError extends Error {
  final String message;
  final int statusCode;

  FetchDataError(this.message, this.statusCode);

  @override
  String toString() => 'FetchDataError: $message (Status Code: $statusCode)';
}

abstract class NewsDataSource {
  Future<Either<GetNewsResponseModel, Error>> getNews(String? topic);
}

class NewsDataSourceImpl implements NewsDataSource {
  static const _baseUrl = "https://newsdata.io/api/1/latest";
  String apiKey = dotenv.env['GOOGLE_NEWS_API_KEY']!;

  @override
  Future<Either<GetNewsResponseModel, Error>> getNews(String? topic) async {
    String url = '$_baseUrl?apikey=$apiKey&domain=bbc&language=en';

    if (topic != null && topic.isNotEmpty) {
      url += '&category=$topic';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final newsResponse = GetNewsResponseModel.fromJson(jsonResponse);
      return Left(newsResponse);
    } else {
      return Right(FetchDataError('Failed to fetch news', response.statusCode));
    }
  }
}
