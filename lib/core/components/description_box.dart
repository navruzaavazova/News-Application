
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox(
      {super.key,
      required this.width,
      required this.title,
      required this.publishedAt,
      required this.source, required this.url});
  final double width;
  final String title;
  final String publishedAt;
  final String source;
  final String url;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.03,
          horizontal: width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _launchUrl(url),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Source: $source', // Добавляем источник
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 105, 101, 101),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'Published: ${publishedAt.substring(0, 10)}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
