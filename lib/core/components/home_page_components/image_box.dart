import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/constants/app_string.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({super.key, required this.width, required this.imageUrl});
  final double width;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(width * 0.02),
        ),
        child: CachedNetworkImage(
          height: double.infinity,
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.black,
              size: 40,
            ),
          ),
          errorWidget: (context, url, error) => Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.05),
              child: Text(AppString.errorWithImage),
            ),
          ),
        ),
      ),
    );
  }
}