import 'package:flutter_bloc/flutter_bloc.dart';
import 'feeds_state.dart';
import '../../domain/use_cases/feeds_use_case.dart';

class FeedsCubit extends Cubit<FeedsState> {
  final GetFeedsUseCase getFeedsUseCase;

  FeedsCubit(this.getFeedsUseCase) : super(FeedsInitial());

  Future<void> getFeeds() async {
    emit(FeedsLoading());
    try {
      final feeds = await getFeedsUseCase.call();
      emit(FeedsLoaded(feeds));
    } catch (e) {
      emit(FeedsError('Failed to fetch feeds: $e'));
    }
  }
}
