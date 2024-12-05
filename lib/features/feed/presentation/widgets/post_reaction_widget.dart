import 'package:flutter/material.dart';

class PostReactionWidget extends StatelessWidget {
  final int reactionCount;
  final int shareCount;
  final bool isReacted;

  const PostReactionWidget({super.key, required this.reactionCount, required this.shareCount, this.isReacted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            isReacted ? Icons.favorite : Icons.favorite_border,
            color: isReacted ? Colors.red : Colors.grey,
          ),
          Text(
            '$reactionCount',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(width: 80),
          Icon(
            Icons.share,
            color: isReacted ? Colors.red : Colors.grey,
          ),
          Text(
            '$reactionCount',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
