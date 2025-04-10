import 'package:flutter/material.dart';
import 'package:news_app/config/route_arguments/article_arguments.dart';
import 'package:news_app/core/constants/app_route_names.dart';
import 'package:news_app/presentation/archive/view/archive_page.dart';
import 'package:news_app/presentation/article/view/article_page.dart';
import 'package:news_app/presentation/home/view/home_page.dart';
import 'package:news_app/presentation/main/view/main_page.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRouteNames.articlePage:
        final args = settings.arguments as ArticleArguments;
        return MaterialPageRoute(
          builder: (_) => ArticlePage(
            name: args.name,
            content: args.content,
            imageUrl: args.image,
            url: args.url,
            source: args.source,
            publishAt: args.publishAt,
          ),
        );
      case AppRouteNames.archivePage:
        return MaterialPageRoute(builder: (_) => const ArchivePage());
      case AppRouteNames.mainPage:
        return MaterialPageRoute(builder: (_) => const MainPage());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not round')),
          ),
        );
    }
  }
}
