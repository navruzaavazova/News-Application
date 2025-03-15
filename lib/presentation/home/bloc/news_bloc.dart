import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository = NewsRepository();

  NewsBloc() : super(NewsInitial()) {
    on<GetNewsEvent>(getNews);
  }

  Future<void> getNews(
      GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final articles = await _newsRepository.getNews();
      emit(NewsSuccess(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
