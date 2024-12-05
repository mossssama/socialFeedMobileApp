import 'package:flutter/material.dart';

import 'post_content_widget.dart';
import 'post_header_widget.dart';
import 'post_reaction_widget.dart';

class PostWidget extends StatelessWidget {
  final String postOwnerName;
  final String postOwnerImageUrl;
  final String postDuration;
  final String? postTextContent;
  final String? postImageContentUrl;
  final int numberOfReactions;
  final int numberOfShares;
  final bool isReacted;

  const PostWidget({
    super.key,
    required this.postOwnerName,
    required this.postOwnerImageUrl,
    required this.postDuration,
    this.postTextContent,
    this.postImageContentUrl,
    required this.numberOfReactions,
    required this.numberOfShares,
    required this.isReacted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeaderWidget(postOwnerName: postOwnerName, postDuration: postDuration, postOwnerImageUrl: postOwnerImageUrl),
        const SizedBox(height: 10.0),
        PostContentWidget(postTextContent: postTextContent, postImageContentUrl: postImageContentUrl),
        const SizedBox(height: 10.0),
        PostReactionWidget(reactionCount: numberOfReactions, shareCount: numberOfShares, isReacted: isReacted),
      ],
    );
  }
}
