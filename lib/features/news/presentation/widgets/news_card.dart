import 'package:flutter/material.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/features/news/presentation/pages/full_article_page.dart';
import 'package:news_application/utility/text_style.dart';

class NewsCard extends StatelessWidget {
  final List<NewsModel> newsList;
  final int currentIndex;
  final bool isSaved;

  const NewsCard({required this.newsList, required this.currentIndex, required this.isSaved, super.key});

  @override
  Widget build(BuildContext context) {
    final news = newsList[currentIndex];
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullArticlePage(
                  newsList: newsList,
                  currentIndex: currentIndex,
                ),
              ),
            ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isSaved)
                  news.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            news.imageUrl!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                const SizedBox(height: 10),
                Text(news.title, style: TextStyles.header18),
                const SizedBox(height: 8),
                Text(news.sourceName ?? 'Source Name', style: TextStyles.body14),
                const SizedBox(height: 8),
                Text(news.pubDate.toLocal().toString(), style: TextStyles.bodyGrey14),
                const SizedBox(height: 16),
                Text(news.description.isNotEmpty ? news.description : "No description available.",
                    maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyles.body14),
              ],
            ),
          ),
        ));
  }
}
