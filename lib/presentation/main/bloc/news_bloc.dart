import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/repositories/news_repository.dart';
import 'package:news_app/data/repositories/saved_news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository = NewsRepository();
  final SavedNewsRepository _savedNewsRepository = SavedNewsRepository();

  NewsBloc() : super(NewsInitial()) {
    on<GetNewsEvent>(getNews);
    on<GetSavedLocallyNews>(getSavedNews);
  }

  Future<void> getNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final articles = await _newsRepository.getNews(
          country: event.country, category: event.category);
      // _savedNewsRepository.saveLocally(articles: articles, category: event.category, country: event.country);
      emit(NewsSuccess(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> getSavedNews(GetSavedLocallyNews savedEvent, Emitter<NewsState> emit)async{
    emit(NewsLoading());
    try {
      final savedArticles = _savedNewsRepository.showLocalArticleBySort(savedEvent.category);
      emit(NewsSuccess(savedArticles as List<ArticleModel>));
    } catch (e) {
      emit(NewsError(e.toString()));
    }


  }
}
