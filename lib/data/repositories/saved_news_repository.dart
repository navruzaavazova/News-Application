import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:news_app/core/local/local_database_set_up.dart';
import 'package:news_app/data/models/article_model.dart';

class SavedNewsRepository {
  final db = LocalDatabaseSetUp.db;
  Future<void> saveLocally(
      {required List<ArticleModel> articles,
      required String country,
      required String category}) async {
    try {
      db.writeTxn(() async {
        final articleIsar = articles
            .map((article) => ArticleModel(
                  source: article.source,
                  author: article.author,
                  title: article.title,
                  description: article.description,
                  url: article.url,
                  urlToImage: article.urlToImage,
                  publishedAt: article.publishedAt,
                  content: article.content,
                  country: country,
                  category: category,
                ))
            .toList();
        await db.articleModels.putAll(articleIsar);
      });
    } catch (e) {
      log('Error with saving news $e');
    }
  }

  Future<List<ArticleModel>> showLocalArticleBySort(
      String? category) async {
    try {
      final savedNews = category != null
          ? await db.articleModels
              .where()
              .filter()
              .categoryEqualTo(category)
              .findAll()
          : await db.articleModels.where().findAll();
      return savedNews;
    } catch (e) {
      return [];
    }
  }
}
