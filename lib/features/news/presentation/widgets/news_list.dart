import 'package:flutter/material.dart';
import 'package:news_application/features/news/presentation/widgets/news_card.dart';
import 'package:news_application/features/news/repository/news_model.dart';

class NewsList extends StatelessWidget {
  final List<NewsModel> newsList;

  const NewsList({required this.newsList, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: NewsCard(newsList: newsList, currentIndex: index),
            );
          },
        ),
      ),
    );
  }
}
