import 'package:flutter/material.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/utility/helper.dart';
import 'package:news_application/utility/text_style.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({required this.news, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchInWebView(news.url),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    news.urlToImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              Text(news.title, style: TextStyles.header18),
              const SizedBox(height: 8),
              Text(news.source.name, style: TextStyles.bodyGrey14),
              const SizedBox(height: 8),
              Text(getDateFormat(news.publishedAt), style: TextStyles.body14),
              const SizedBox(height: 16),
              Text(news.description ?? "No description available.",
                  maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyles.body14),
            ],
          ),
        ),
      ),
    );
  }
}
