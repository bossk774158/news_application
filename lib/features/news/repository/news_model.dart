import 'dart:convert';
import 'package:hive/hive.dart';

part 'news_model.g.dart';

@HiveType(typeId: 1)
class NewsModel {
  @HiveField(0)
  final String articleId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String link;

  @HiveField(3)
  final List<String>? keywords;

  @HiveField(4)
  final List<String>? creator;

  @HiveField(5)
  final String? videoUrl;

  @HiveField(6)
  final String description;

  @HiveField(7)
  final String content;

  @HiveField(8)
  final DateTime pubDate;

  @HiveField(9)
  final String? imageUrl;

  @HiveField(10)
  final String? sourceId;

  @HiveField(11)
  final String? sourceName;

  @HiveField(12)
  final String? sourceUrl;

  @HiveField(13)
  final int? sourcePriority;

  @HiveField(14)
  final String? sourceIcon;

  @HiveField(15)
  final String language;

  @HiveField(16)
  final List<String> country;

  @HiveField(17)
  final List<String> category;

  @HiveField(18)
  final bool duplicate;

  NewsModel({
    required this.articleId,
    required this.title,
    required this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    required this.description,
    required this.content,
    required this.pubDate,
    this.imageUrl,
    this.sourceId,
    this.sourceName,
    this.sourceUrl,
    this.sourcePriority,
    this.sourceIcon,
    required this.language,
    required this.country,
    required this.category,
    required this.duplicate,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      articleId: json['article_id'] as String,
      title: json['title'] as String,
      link: json['link'] as String,
      keywords: (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList(),
      creator: (json['creator'] as List<dynamic>?)?.map((e) => e as String).toList(),
      videoUrl: json['video_url'] as String?,
      description: json['description'] as String,
      content: json['content'] as String,
      pubDate: DateTime.parse(json['pubDate']),
      imageUrl: json['image_url'] as String?,
      sourceId: json['source_id'] as String?,
      sourceName: json['source_name'] as String?,
      sourceUrl: json['source_url'] as String?,
      sourcePriority: json['source_priority'] as int?,
      sourceIcon: json['source_icon'] as String?,
      language: json['language'] as String,
      country: (json['country'] as List<dynamic>).map((e) => e as String).toList(),
      category: (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      duplicate: json['duplicate'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'link': link,
      'keywords': keywords,
      'creator': creator,
      'video_url': videoUrl,
      'description': description,
      'content': content,
      'pubDate': pubDate.toIso8601String(),
      'image_url': imageUrl,
      'source_id': sourceId,
      'source_name': sourceName,
      'source_url': sourceUrl,
      'source_priority': sourcePriority,
      'source_icon': sourceIcon,
      'language': language,
      'country': country,
      'category': category,
      'duplicate': duplicate,
    };
  }
}

class GetNewsResponseEntity {
  final String status;
  final int totalResults;
  final List<NewsModel> results;
  final String? nextPage;

  GetNewsResponseEntity({
    required this.status,
    required this.totalResults,
    required this.results,
    this.nextPage,
  });

  factory GetNewsResponseEntity.fromJson(Map<String, dynamic> json) {
    return GetNewsResponseEntity(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      results:
          (json['results'] as List<dynamic>).map((item) => NewsModel.fromJson(item as Map<String, dynamic>)).toList(),
      nextPage: json['nextPage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'results': results.map((news) => news.toJson()).toList(),
      'nextPage': nextPage,
    };
  }
}

class GetNewsResponseModel {
  GetNewsResponseEntity entity;

  GetNewsResponseModel({required this.entity});

  static GetNewsResponseModel fromJson(dynamic json) {
    return GetNewsResponseModel(
      entity: GetNewsResponseEntity.fromJson(json),
    );
  }
}
