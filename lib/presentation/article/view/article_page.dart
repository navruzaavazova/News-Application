import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/constants/app_string.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.content,
      required this.url,
      required this.source,
      required this.publishAt});

  final String imageUrl;
  final String name;
  final String content;
  final String url;
  final String source;
  final String publishAt;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(source,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: width * 0.07)),
        backgroundColor: const Color.fromARGB(255, 26, 26, 27),
      ),
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 26, 26, 27),
      body: ListView(
        padding: EdgeInsets.all(width * 0.05),
        children: [
          Text(name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: width * 0.072)),
          SizedBox(height: width * 0.03),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              height: width * 0.6,
              width: double.infinity,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 40,
                ),
              ),
              errorWidget: (context, url, error) => const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(AppString.errorWithImage),
                ),
              ),
            ),
          ),
          SizedBox(height: width * 0.03),
          Text(
            'Published: ${publishAt.substring(0, 10)}',
            style: TextStyle(
              fontSize: width * 0.04,
              color: const Color.fromARGB(255, 208, 203, 203),
            ),
          ),
          SizedBox(height: width * 0.05),
          Text(
            content.replaceAll(RegExp(r'\[\+\d+.*?\]'), ''),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(225, 255, 253, 253),
                fontSize: width * 0.044),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: width * 0.05),
          TextButton(
              onPressed: () => _launchUrl(url),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Read More',
                style: TextStyle(
                    color: Color.fromARGB(255, 26, 26, 27),
                    fontSize: width * 0.07),
              ),),
        ],
      ),
    );
  }
}
