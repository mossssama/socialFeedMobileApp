import 'package:dio/dio.dart';
import 'package:social_feed/core/dio_client.dart';
import 'package:social_feed/features/feed/data/models/post_model.dart';

import 'feed_api.dart';

class FeedApiDioImpl extends FeedApi {
  final Dio _dio;

  FeedApiDioImpl(DioClient dioClient) : _dio = dioClient.dio;

  @override
  Future<FeedsModel> getLatestFeed() async {
    try {
      final response = await _dio.get("");
      if (response.statusCode == 200) {
        return FeedsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load feed');
      }
    } catch (e) {
      throw Exception('Error fetching verse: $e');
    }
  }
}
