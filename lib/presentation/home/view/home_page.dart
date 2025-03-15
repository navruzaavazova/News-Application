import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/components/news_box.dart';
import 'package:news_app/presentation/home/bloc/news_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 27),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 26, 27),
        title: const Text(
          'Tesla News',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              context.read<NewsBloc>().add(GetNewsEvent());
              return const Center(child: Text('Loading news...'));
            } else if (state is NewsLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 40,
                ),
              );
            } else if (state is NewsSuccess) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return NewsBox(
                      name: article.title ?? 'n/a',
                      imageUrl: article.urlToImage ?? 'n/a',
                      publishedAt:
                          article.publishedAt ?? '${DateTime.now().day}',
                      url: article.url ?? 'n/a',
                      source: article.source?.name ?? 'Nowhere');
                },
              );
            } else if (state is NewsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
