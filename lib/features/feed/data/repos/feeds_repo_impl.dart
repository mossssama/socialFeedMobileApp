import 'package:hive/hive.dart';
import 'package:social_feed/core/constants.dart';
import 'package:social_feed/features/feed/data/api/feed_api.dart';
import 'package:social_feed/features/feed/data/models/post_model.dart';
import 'package:social_feed/features/feed/domain/entities/feeds_entity.dart';
import 'package:social_feed/features/feed/domain/repos/feeds_repo.dart';

class FeedRepoistoryImpl implements FeedsRepository {
  final FeedApi _feedApi;
  final Box _cacheBox;

  FeedRepoistoryImpl(this._cacheBox, this._feedApi);

  @override
  Future<FeedsEntity> getFeeds() async {
    // Check if data exists in cache
    if (_cacheBox.containsKey(hiveFeedCacheKey)) {
      final cachedData = _cacheBox.get(hiveFeedCacheKey);
      return FeedsModel.fromJson(cachedData).toEntity();
    }

    // Fetch from API and cache it
    FeedsModel feedsModel = await _feedApi.getLatestFeed();
    _cacheBox.put(hiveFeedCacheKey, feedsModel.toJson());
    return feedsModel.toEntity();
  }
}
