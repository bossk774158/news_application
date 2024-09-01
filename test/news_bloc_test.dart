import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/business_logic/news_bloc.dart';
import 'package:news_application/features/news/business_logic/news_event.dart';
import 'package:news_application/features/news/business_logic/news_state.dart';
import 'package:news_application/features/news/repository/news_model.dart';

import 'mocks.mocks.dart';

void main() {
  late NewsBloc newsBloc;
  late MockGetNewsUseCase mockGetNewsUseCase;

  setUp(() {
    mockGetNewsUseCase = MockGetNewsUseCase();
    newsBloc = NewsBloc(mockGetNewsUseCase);
  });

  final tNewsModel = NewsModel(
    articleId: '123',
    title: 'Test Title',
    link: 'https://example.com',
    description: 'Test Description',
    content: 'Test Content',
    pubDate: DateTime.now(),
    imageUrl: 'https://example.com/image.jpg',
    sourceId: 'test_source',
    sourceName: 'Test Source',
    sourceUrl: 'https://example.com',
    sourcePriority: 1,
    sourceIcon: 'https://example.com/icon.jpg',
    language: 'en',
    country: ['us'],
    category: ['test'],
    duplicate: false,
    keywords: null,
    creator: null,
    videoUrl: null,
  );

  final tNewsResponseEntity = GetNewsResponseEntity(
    status: 'success',
    totalResults: 1,
    results: [tNewsModel],
    nextPage: null,
  );

  final tNewsResponseModel = GetNewsResponseModel(entity: tNewsResponseEntity);

  blocTest<NewsBloc, NewsState>(
    'emits [NewsLoadingState, SuccessGetNewsState] when GetNewsEvent is added and data is fetched successfully',
    build: () {
      when(mockGetNewsUseCase.call(params: 'business')).thenAnswer((_) async => Left(tNewsResponseModel));
      return newsBloc;
    },
    act: (bloc) => bloc.add(GetNewsEvent(topic: 'business')),
    expect: () => [
      NewsLoadingState(),
      SuccessGetNewsState(entity: tNewsResponseEntity),
    ],
    verify: (_) {
      verify(mockGetNewsUseCase.call(params: 'business')).called(1);
    },
  );

  blocTest<NewsBloc, NewsState>(
    'emits [NewsLoadingState, ErrorGetNewsState] when GetNewsEvent is added and fetching fails',
    build: () {
      when(mockGetNewsUseCase.call(params: 'business')).thenAnswer(
        (_) async => Right(Error()),
      );
      return newsBloc;
    },
    act: (bloc) => bloc.add(GetNewsEvent(topic: 'business')),
    expect: () => [
      NewsLoadingState(),
      ErrorGetNewsState(message: 'Instance of \'Error\'', statusCode: 400),
    ],
  );
}
