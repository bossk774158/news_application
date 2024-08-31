import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/features/news/presentation/pages/full_article_page.dart';

class SavedArticlesPage extends StatelessWidget {
  const SavedArticlesPage({Key? key}) : super(key: key);

  Future<List<NewsModel>> _getSavedArticles() async {
    final box = await Hive.openBox<NewsModel>('saved_articles');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles'),
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: _getSavedArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading saved articles.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No saved articles.'));
          } else {
            final savedArticles = snapshot.data!;
            return ListView.builder(
              itemCount: savedArticles.length,
              itemBuilder: (context, index) {
                final article = savedArticles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.sourceName ?? 'Source Name'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullArticlePage(
                          newsList: savedArticles,
                          currentIndex: index,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
