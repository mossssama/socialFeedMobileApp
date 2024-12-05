import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/get_it.dart';
import '../controllers/feeds_cubit.dart';
import '../controllers/feeds_state.dart';
import '../widgets/divider_widget.dart';
import '../widgets/posts_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FeedsCubit>()..getFeeds(),
      child: BlocBuilder<FeedsCubit, FeedsState>(
        builder: (context, state) {
          if (state is FeedsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedsLoaded) {
            return LoadedFeedsWidget(feedsState: state);
          } else if (state is FeedsError) {
            return Center(
              child: Text(
                'Failed to load posts: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text('No posts to display.'),
            );
          }
        },
      ),
    );
  }
}

class LoadedFeedsWidget extends StatelessWidget {
  final FeedsLoaded feedsState;

  const LoadedFeedsWidget({
    super.key,
    required this.feedsState,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: feedsState.feedsEntity.feeds
            .expand((post) => [
                  PostWidget(
                    postOwnerName: post.postOwnerName,
                    postOwnerImageUrl: post.postOwnerImageUrl,
                    postTextContent: post.postTextContent,
                    postDuration: post.postDuration,
                    postImageContentUrl: post.postImageContentUrl,
                    numberOfReactions: post.numberOfReactions,
                    numberOfShares: post.numberOfShares,
                    isReacted: post.isReacted,
                  ),
                  const DividerWidget(),
                ])
            .toList(),
      ),
    );
  }
}
