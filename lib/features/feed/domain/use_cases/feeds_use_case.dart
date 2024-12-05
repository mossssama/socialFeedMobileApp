import 'package:social_feed/features/feed/domain/entities/feeds_entity.dart';
import 'package:social_feed/features/feed/domain/repos/feeds_repo.dart';

class GetFeedsUseCase {
  final FeedsRepository _feedRepository;

  GetFeedsUseCase(this._feedRepository);

  Future<FeedsEntity> call() async {
    try {
      FeedsEntity feedsEntity = await _feedRepository.getFeeds();
      return feedsEntity;
    } catch (e) {
      throw Exception('Failed to fetch feeds info: $e');
    }
  }
}
