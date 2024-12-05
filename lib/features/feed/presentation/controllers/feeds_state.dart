import 'package:equatable/equatable.dart';

import '../../domain/entities/feeds_entity.dart';

abstract class FeedsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeedsInitial extends FeedsState {}

class FeedsLoading extends FeedsState {}

class FeedsLoaded extends FeedsState {
  final FeedsEntity feedsEntity;

  FeedsLoaded(this.feedsEntity);

  @override
  List<Object?> get props => [feedsEntity];
}

class FeedsError extends FeedsState {
  final String message;

  FeedsError(this.message);

  @override
  List<Object?> get props => [message];
}
