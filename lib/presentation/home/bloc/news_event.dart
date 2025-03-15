part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable{const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsEvent extends NewsEvent {}