import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models.dart';
import '../repos/register_repo.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<Result<User?>> call({required String email, required String password}) {
    return repository.registerUser(email: email, password: password);
  }
}
