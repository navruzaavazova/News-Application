import 'package:news_app/core/constants/app_string.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/models/news_model.dart';

class NewsRepository {
  final DioClient dioClient = DioClient();

  Future<List<ArticleModel>> getNews(
      {required String country, required String category}) async {
    try {
      final response = await dioClient
          .getRequest(endpoint: '/top-headlines', queryParameters: {
        'country': country,
        'category': category,
        'apiKey': AppString.apiKey,
      });
      final newsResponse = NewsModel.fromJson(response?.data);
      return newsResponse.articles;
    } catch (e) {
      throw Exception('Failed article loading $e');
    }
  }

  Future<List<ArticleModel>> searchNews({
    required String keyword,
    required String country,
  }) async {
    try {
      final response =
          await dioClient.getRequest(endpoint: '/everything', queryParameters: {
        'q': keyword,
        'apiKey': AppString.apiKey,
        'searchIn': 'title',
        'language': country,
      });
      final newsResponse = NewsModel.fromJson(response?.data);
      return newsResponse.articles;
    } catch (e) {
      throw Exception('Failed article loading $e');
    }
  }
}
