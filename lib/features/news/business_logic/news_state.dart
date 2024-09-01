import 'package:news_application/features/news/repository/news_model.dart';
import 'package:equatable/equatable.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

// Example state implementing Equatable
class NewsLoadingState extends NewsState with EquatableMixin {
  @override
  List<Object?> get props => []; // List all properties that should be compared
}

class SuccessGetNewsState extends NewsState with EquatableMixin {
  final GetNewsResponseEntity entity;

  SuccessGetNewsState({required this.entity});

  @override
  List<Object?> get props => [entity]; // Include the entity in comparison
}

class ErrorGetNewsState extends NewsState with EquatableMixin {
  final String message;
  final int statusCode;

  ErrorGetNewsState({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode]; // Include message and status code
}
