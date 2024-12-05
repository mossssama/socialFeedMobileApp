import '../entities/feeds_entity.dart';

abstract class FeedsRepository {
  Future<FeedsEntity> getFeeds();
}
