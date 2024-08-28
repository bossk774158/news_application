import 'dart:convert';

class NewsSource {
  final String? id;
  final String name;

  NewsSource({
    this.id,
    required this.name,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class NewsModel {
  final NewsSource source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  NewsModel({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: NewsSource.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }
}

class GetNewsResponseEntity {
  final String status;
  final int totalResults;
  final List<NewsModel> articles;

  GetNewsResponseEntity({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory GetNewsResponseEntity.fromJson(Map<String, dynamic> json) {
    return GetNewsResponseEntity(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: (json['articles'] as List).map((articleJson) => NewsModel.fromJson(articleJson)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((article) => article.toJson()).toList(),
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
