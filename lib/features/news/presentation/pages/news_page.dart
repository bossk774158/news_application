import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/features/news/business_logic/news_bloc.dart';
import 'package:news_application/features/news/business_logic/news_event.dart';
import 'package:news_application/features/news/business_logic/news_state.dart';
import 'package:news_application/features/news/presentation/widgets/news_list.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsBloc _bloc;
  bool isLoading = false;

  @override
  void initState() {
    _bloc = BlocProvider.of<NewsBloc>(context);
    _bloc.add(GetNewsEvent());

    super.initState();
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
          return NewsList(newsList: state.entity.articles);
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
      appBar: AppBar(title: Text('News')),
      body: renderNews(),
    );
  }
}
