import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repos/register_repo.dart';
import '../api/register_api.dart';
import '../../../../core/models.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterApi registerApi;

  RegisterRepositoryImpl(this.registerApi);

  @override
  Future<Result<User?>> registerUser({required String email, required String password}) async {
    final result = await registerApi.registerWithEmailAndPassword(email, password);
    return result;
  }
}
