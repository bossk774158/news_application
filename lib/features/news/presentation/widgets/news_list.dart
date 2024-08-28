import 'package:flutter/material.dart';
import 'package:news_application/features/news/presentation/pages/full_article_page.dart';
import 'package:news_application/features/news/repository/news_model.dart';

class NewsList extends StatelessWidget {
  final List<NewsModel> newsList;

  const NewsList({required this.newsList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return ListTile(
          leading: Image.network(news.urlToImage ?? '', fit: BoxFit.cover),
          title: Text(news.title),
          subtitle: Text(news.description ?? 'description'),
          trailing: Text(news.publishedAt.toLocal().toString()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullArticlePage(news: news),
              ),
            );
          },
        );
      },
    );
  }
}
