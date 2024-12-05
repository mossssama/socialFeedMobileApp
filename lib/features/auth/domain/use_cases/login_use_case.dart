import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models.dart';
import '../repos/login_repo.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Result<User?>> call({required String email, required String password}) {
    return repository.loginUser(email: email, password: password);
  }
}
