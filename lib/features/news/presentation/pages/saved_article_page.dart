import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_application/features/news/presentation/widgets/news_card.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/features/news/presentation/pages/full_article_page.dart';

class SavedArticlesPage extends StatefulWidget {
  const SavedArticlesPage({super.key});

  @override
  _SavedArticlesPageState createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> with RouteAware {
  late Future<List<NewsModel>> _savedArticlesFuture;

  Future<List<NewsModel>> _getSavedArticles() async {
    final box = await Hive.openBox<NewsModel>('saved_articles');
    return box.values.toList();
  }

  @override
  void initState() {
    super.initState();
    _savedArticlesFuture = _getSavedArticles();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _savedArticlesFuture = _getSavedArticles(); // Refresh the data when the page is accessed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles'),
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: _savedArticlesFuture,
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
                return Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullArticlePage(
                              newsList: savedArticles,
                              currentIndex: index,
                            ),
                          ),
                        ).then((_) {
                          setState(() {
                            _savedArticlesFuture = _getSavedArticles();
                          });
                        });
                      },
                      child: NewsCard(
                        newsList: savedArticles,
                        currentIndex: index,
                        isSaved: true,
                      ),
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
