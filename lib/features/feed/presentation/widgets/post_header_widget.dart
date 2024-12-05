import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'cached_image_progress_indicator.dart';

class PostHeaderWidget extends StatelessWidget {
  final String postOwnerName;
  final String postDuration;
  final String postOwnerImageUrl;

  const PostHeaderWidget({
    super.key,
    required this.postOwnerName,
    required this.postDuration,
    required this.postOwnerImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: CachedNetworkImage(
              imageUrl: postOwnerImageUrl,
              fit: BoxFit.cover,
              width: 40.0,
              height: 40.0,
              placeholder: (context, url) => const CachedImageProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postOwnerName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Text(
                postDuration,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
