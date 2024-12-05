import '../models/post_model.dart';

abstract class FeedApi {
  Future<FeedsModel> getLatestFeed();
}
