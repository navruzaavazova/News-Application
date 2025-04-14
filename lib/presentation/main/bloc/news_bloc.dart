
import 'package:news_app/core/state_management/spider_bloc_custom/spider_bloc_base/spider_bloc.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/repositories/news_repository.dart';
import 'package:news_app/data/repositories/saved_news_repository.dart';
import 'package:news_app/presentation/main/bloc/news_event.dart';
import 'package:news_app/presentation/main/bloc/news_state.dart';


class NewsBloc extends SpiderBloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository = NewsRepository();
  final SavedNewsRepository _savedNewsRepository = SavedNewsRepository();

  NewsBloc() : super(NewsInitial()) {
    on<GetNewsEvent>(getNews);
    on<GetSavedLocallyNews>(getSavedNews);
  }

  Future<void> getNews(GetNewsEvent event, emit) async {
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

  Future<void> getSavedNews(GetSavedLocallyNews savedEvent, emit)async{
    emit(NewsLoading());
    try {
      final savedArticles = _savedNewsRepository.showLocalArticleBySort(savedEvent.category);
      emit(NewsSuccess(savedArticles as List<ArticleModel>));
    } catch (e) {
      emit(NewsError(e.toString()));
    }


  }
}
