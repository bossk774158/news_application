import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/features/news/repository/news_usecase.dart';

import 'mocks.mocks.dart';

void main() {
  late GetNewsUseCase getNewsUseCase;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    getNewsUseCase = GetNewsUseCase(mockNewsRepository);
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

  test('should get news for the given topic from the repository', () async {
    // Arrange
    when(mockNewsRepository.getNews('business')).thenAnswer((_) async => Left(tNewsResponseModel));

    // Act
    final result = await getNewsUseCase.call(params: 'business');

    // Assert
    expect(result, Left(tNewsResponseModel));
    verify(mockNewsRepository.getNews('business'));
    verifyNoMoreInteractions(mockNewsRepository);
  });

  test('should return an error when repository fails to fetch news', () async {
    // Arrange
    final tError = Error();
    when(mockNewsRepository.getNews('business')).thenAnswer((_) async => Right(tError));

    // Act
    final result = await getNewsUseCase.call(params: 'business');

    // Assert
    expect(result, Right(tError));
    verify(mockNewsRepository.getNews('business'));
    verifyNoMoreInteractions(mockNewsRepository);
  });
}
