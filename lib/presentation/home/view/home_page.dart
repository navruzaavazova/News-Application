import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/components/home_page_components/custom_tap_bar.dart';
import 'package:news_app/core/components/home_page_components/news_box.dart';
import 'package:news_app/core/constants/app_string.dart';
import 'package:news_app/core/local/set_parameters.dart';
import 'package:news_app/core/provider/spider_provider/spider_inheritance/spider_inheritance.dart';
import 'package:news_app/core/state_management/spider_bloc_custom/spider_bloc_builder/spider_bloc_builder.dart';
import 'package:news_app/presentation/main/bloc/news_bloc.dart';
import 'package:news_app/presentation/main/bloc/news_event.dart';
import 'package:news_app/presentation/main/bloc/news_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const CustomTapBar(
                      categories: AppString.categories,
                    ),

          Expanded(
            child: SpiderBlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitial) {
                  SpiderInheritance.of<NewsBloc>(context).add(GetNewsEvent(
                      country: SetParameters.getSavedLanguage(),
                      category: AppString.selectedCategory));
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
                        source: article.source?.name ?? 'Nowhere',
                        content: article.content ?? 'Not found',
                      );
                    },
                  );
                } else if (state is NewsError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
