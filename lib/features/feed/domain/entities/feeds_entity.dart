class FeedsEntity {
  final List<Feed> feeds;
  FeedsEntity({
    required this.feeds,
  });
}

class Feed {
  final String postOwnerName;
  final String postOwnerImageUrl;
  final String postDuration;
  final String? postTextContent;
  final String? postImageContentUrl;
  final int numberOfReactions;
  final int numberOfShares;
  final bool isReacted;

  Feed({
    required this.postOwnerName,
    required this.postOwnerImageUrl,
    required this.postDuration,
    required this.postTextContent,
    required this.postImageContentUrl,
    required this.numberOfReactions,
    required this.numberOfShares,
    required this.isReacted,
  });
}
