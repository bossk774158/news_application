import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/features/news/business_logic/news_bloc.dart';
import 'package:news_application/features/news/business_logic/news_event.dart';
import 'package:news_application/features/news/business_logic/news_state.dart';
import 'package:news_application/features/news/presentation/pages/saved_article_page.dart';
import 'package:news_application/features/news/presentation/widgets/news_list.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsBloc _bloc;
  bool isLoading = false;
  String selectedTopic = "LATEST";

  final List<String> topics = ["LATEST", "business", "entertainment", "politics", "health", "technology"];

  @override
  void initState() {
    _bloc = BlocProvider.of<NewsBloc>(context);
    _fetchNews();
    super.initState();
  }

  void _fetchNews() {
    _bloc.add(GetNewsEvent(topic: selectedTopic == "LATEST" ? null : selectedTopic));
  }

  Widget renderTopicChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: topics.map((topic) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(topic.toUpperCase()),
              selected: selectedTopic == topic,
              onSelected: (bool selected) {
                if (selected) {
                  setState(() {
                    selectedTopic = topic;
                    _fetchNews();
                  });
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget renderNews() {
    return BlocConsumer<NewsBloc, NewsState>(
      bloc: _bloc,
      listener: (BuildContext context, NewsState state) {
        if (state is NewsLoadingState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is SuccessGetNewsState) {
          setState(() {
            isLoading = false;
          });
        } else if (state is ErrorGetNewsState) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (BuildContext context, NewsState state) {
        if (state is NewsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessGetNewsState) {
          return NewsList(newsList: state.entity.results);
        } else if (state is ErrorGetNewsState) {
          return const Center(child: Text('Failed to load news'));
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmarks),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedArticlesPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          renderTopicChips(),
          Expanded(child: renderNews()),
        ],
      ),
    );
  }
}
