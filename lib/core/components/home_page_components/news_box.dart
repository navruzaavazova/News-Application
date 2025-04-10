import 'package:flutter/material.dart';
import 'package:news_app/config/route_arguments/article_arguments.dart';
import 'package:news_app/core/components/home_page_components/description_box.dart';
import 'package:news_app/core/components/home_page_components/image_box.dart';
import 'package:news_app/core/constants/app_route_names.dart';

class NewsBox extends StatelessWidget {
  const NewsBox(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.publishedAt,
      required this.url,
      required this.source, required this.content});
  final String name;
  final String imageUrl;
  final String publishedAt;
  final String url;
  final String source;
  final String content;



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRouteNames.articlePage,
            arguments: ArticleArguments(
                image: imageUrl, name: name, content: content, url: url, source: source, publishAt: publishedAt)),
        child: SizedBox(
          height: width * 0.3,
          child: Row(
            children: [
              ImageBox(width: width, imageUrl: imageUrl),
              DescriptionBox(
                width: width,
                title: name,
                publishedAt: publishedAt,
                source: source,
                url: url,
              )
            ],
          ),
        ),
      ),
    );
  }
}
