import 'package:equatable/equatable.dart';
import 'article_model.dart';

class NewsModel extends Equatable {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  const NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: (json['articles'] as List<dynamic>)
          .map((articleJson) =>
              ArticleModel.fromJson(articleJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object> get props => [status, totalResults, articles];
}
