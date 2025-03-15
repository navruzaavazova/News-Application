import 'package:news_app/core/constants/app_string.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/models/news_model.dart';

class NewsRepository {
  final DioClient dioClient = DioClient();

  Future<List<ArticleModel>> getNews() async {
    try {
      final response =
          await dioClient.getRequest(endpoint: '/everything', queryParameters: {
        'q': 'tesla',
        'from': '2025-03-14',
        'sortBy': 'publishedAt',
        'apiKey': AppString.apiKey,
      });
      final newsResponse = NewsModel.fromJson(response?.data);
      return newsResponse.articles;
    } catch (e) {
      throw Exception('Failed article loading $e');
    }
  }
}
