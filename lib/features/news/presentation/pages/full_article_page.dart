import 'package:flutter/material.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:hive/hive.dart';

class FullArticlePage extends StatelessWidget {
  final List<NewsModel> newsList;
  final int currentIndex;

  const FullArticlePage({
    required this.newsList,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  NewsModel get currentNews => newsList[currentIndex];

  Future<void> _saveArticle(BuildContext context, NewsModel news) async {
    final box = await Hive.openBox<NewsModel>('saved_articles');
    await box.put(news.articleId, news);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Article saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentNews.title),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () => _saveArticle(context, currentNews),
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
            Text(
              currentNews.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentNews.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Published on: ${currentNews.pubDate.toLocal()}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              currentNews.content.isNotEmpty ? currentNews.content : "Content not available",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
