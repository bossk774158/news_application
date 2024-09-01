import 'package:news_application/features/news/repository/news_model.dart';
import 'package:equatable/equatable.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SuccessGetNewsState extends NewsState with EquatableMixin {
  final GetNewsResponseEntity entity;

  SuccessGetNewsState({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class ErrorGetNewsState extends NewsState with EquatableMixin {
  final String message;
  final int statusCode;

  ErrorGetNewsState({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
