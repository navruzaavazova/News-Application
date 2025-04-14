import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox(
      {super.key,
      required this.width,
      required this.title,
      required this.publishedAt,
      required this.source,
      required this.url});
  final double width;
  final String title;
  final String publishedAt;
  final String source;
  final String url;

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
            Text(
              title,
              style: TextStyle(
                  fontSize: width * 0.034,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              'Source: ${source.split(' ').take(3).join(' ')}',
              style: TextStyle(
                fontSize: width * 0.03,
                color: const Color.fromARGB(255, 163, 155, 155),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'Published: ${publishedAt.substring(0, 10)}',
              style: TextStyle(
                fontSize: width * 0.03,
                color: const Color.fromARGB(255, 208, 203, 203),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
