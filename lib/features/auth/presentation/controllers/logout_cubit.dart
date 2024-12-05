import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants.dart';
import '../../../../core/shared_prefs.dart';
import '../../domain/use_cases/logout_use_case.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;

  LogoutCubit(this.logoutUseCase) : super(LogoutInitial());

  Future<void> logoutUser() async {
    emit(LogoutLoading());
    try {
      final result = await logoutUseCase.call();
      if (result.isSuccess) {
        emit(LogoutSuccess());
        await SharedPrefs.clear();
        await Hive.box(hiveFeedCacheBox).clear();
      } else {
        emit(LogoutFailure(message: result.error ?? "Try Again"));
      }
    } catch (error) {
      emit(LogoutFailure(message: error.toString()));
    }
  }
}
