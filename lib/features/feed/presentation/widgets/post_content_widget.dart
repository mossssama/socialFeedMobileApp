import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'cached_image_progress_indicator.dart';

class PostContentWidget extends StatelessWidget {
  final String? postTextContent;
  final String? postImageContentUrl;

  const PostContentWidget({
    super.key,
    this.postTextContent,
    this.postImageContentUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (postTextContent != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              postTextContent!,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        const SizedBox(height: 6.0),
        if (postImageContentUrl != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: postImageContentUrl!,
                fit: BoxFit.contain,
                placeholder: (context, url) => const CachedImageProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
      ],
    );
  }
}
