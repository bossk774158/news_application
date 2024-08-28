import 'package:news_application/features/news/repository/news_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class SuccessGetNewsState extends NewsState {
  GetNewsResponseEntity entity;

  SuccessGetNewsState({required this.entity});
}

class ErrorGetNewsState extends NewsState {
  String message;
  int statusCode = 0;

  ErrorGetNewsState({this.message = '', required this.statusCode});
}
