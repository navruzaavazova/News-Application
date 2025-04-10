import 'package:isar/isar.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabaseSetUp {
  static late final Isar db;
  static Future<void> setUp() async {
    final appDir = await getApplicationDocumentsDirectory();
    db = await Isar.open([ArticleModelSchema],
    directory: appDir.path);
  }
}
