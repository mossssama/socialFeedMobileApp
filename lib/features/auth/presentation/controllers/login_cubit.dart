import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());
    try {
      final result = await loginUseCase.call(email: email, password: password);
      if (result.isSuccess) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(message: result.error ?? "Try Again"));
      }
    } catch (error) {
      emit(LoginFailure(message: error.toString()));
    }
  }

  void reset() {
    emit(LoginInitial());
  }
}
