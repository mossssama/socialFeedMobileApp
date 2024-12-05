import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/register_use_case.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> registerUser(String email, String password) async {
    emit(RegisterLoading());

    try {
      final result = await registerUseCase.call(email: email, password: password);
      if (result.isSuccess) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(message: result.error ?? "Try Again"));
      }
    } catch (error) {
      emit(RegisterFailure(message: error.toString()));
    }
  }
}
