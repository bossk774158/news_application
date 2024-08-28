import 'package:flutter/material.dart';
import 'package:news_application/features/news/repository/news_model.dart';

class FullArticlePage extends StatelessWidget {
  final NewsModel news;

  const FullArticlePage({required this.news, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(news.urlToImage ?? ''),
            SizedBox(height: 16),
            Text(news.title),
            SizedBox(height: 8),
            Text(news.publishedAt.toLocal().toString()),
            SizedBox(height: 16),
            Text(news.description ?? 'description'),
          ],
        ),
      ),
    );
  }
}
