import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/business_logic/news_event.dart';
import 'package:news_application/features/news/business_logic/news_state.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/features/news/repository/news_usecase.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNewsUseCase;

  NewsBloc(
    this._getNewsUseCase,
  ) : super(NewsInitial()) {
    on<GetNewsEvent>(((event, emit) => _getTakenBookingSlots(event, emit)));
  }

  void _getTakenBookingSlots(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoadingState());
    final Either<GetNewsResponseModel, Error> result = await _getNewsUseCase();
    emit(result.fold((l) => SuccessGetNewsState(entity: l.entity),
        (error) => ErrorGetNewsState(message: error.toString(), statusCode: 400)));
  }
}
