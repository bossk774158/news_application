import 'package:flutter/material.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:hive/hive.dart';
import 'package:news_application/utility/helper.dart';
import 'package:news_application/utility/text_style.dart';

class FullArticlePage extends StatelessWidget {
  final List<NewsModel> newsList;
  final int currentIndex;

  const FullArticlePage({required this.newsList, required this.currentIndex, super.key});

  NewsModel get currentNews => newsList[currentIndex];

  Future<void> _saveArticle(BuildContext context, NewsModel news) async {
    final box = await Hive.openBox<NewsModel>('saved_articles');
    await box.put(news.articleId, news);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Article saved!')),
    );
  }

  Future<void> _unsaveArticle(BuildContext context, NewsModel news) async {
    final box = await Hive.openBox<NewsModel>('saved_articles');
    await box.delete(news.articleId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Article unsaved!')),
    );
  }

  Future<bool> _isArticleSaved(NewsModel news) async {
    final box = await Hive.openBox<NewsModel>('saved_articles');
    return box.containsKey(news.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentNews.title),
        actions: [
          FutureBuilder<bool>(
            future: _isArticleSaved(currentNews),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data == true) {
                return IconButton(
                  icon: Icon(Icons.bookmark_remove),
                  onPressed: () => _unsaveArticle(context, currentNews),
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.bookmark_add),
                  onPressed: () => _saveArticle(context, currentNews),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentNews.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  currentNews.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(currentNews.title, style: TextStyles.header24),
            const SizedBox(height: 10),
            Text(currentNews.description, style: TextStyles.body16),
            const SizedBox(height: 16),
            Text('Published on: ${getDateFormat(currentNews.pubDate)}', style: TextStyles.body14),
            const SizedBox(height: 16),
            Text(currentNews.content.isNotEmpty ? currentNews.content : "Content not available",
                style: TextStyles.body16),
            Spacer(),
            Row(
              mainAxisAlignment: currentIndex == 0 ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullArticlePage(
                            newsList: newsList,
                            currentIndex: currentIndex - 1,
                          ),
                        ),
                      );
                    },
                    child: Text('Previous'),
                  ),
                if (currentIndex < newsList.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullArticlePage(
                            newsList: newsList,
                            currentIndex: currentIndex + 1,
                          ),
                        ),
                      );
                    },
                    child: Text('Next'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
