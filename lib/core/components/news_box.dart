import 'package:flutter/material.dart';
import 'package:news_app/core/components/description_box.dart';
import 'package:news_app/core/components/image_box.dart';


class NewsBox extends StatelessWidget {
  const NewsBox(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.publishedAt,
      required this.url,
      required this.source});
  final String name;
  final String imageUrl;
  final String publishedAt;
  final String url;
  final String source;



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      child: SizedBox(
        height: width * 0.3,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.05),
          ),
          child: Row(
            children: [
              ImageBox(width: width, imageUrl: imageUrl),
              DescriptionBox(
                  width: width,
                  title: name,
                  publishedAt: publishedAt,
                  source: source, url: url,)
            ],
          ),
        ),
      ),
    );
  }
}
