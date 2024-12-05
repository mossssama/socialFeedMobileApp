import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models.dart';
import '../../domain/repos/login_repo.dart';
import '../api/login_api.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApi loginApi;

  LoginRepositoryImpl(this.loginApi);

  @override
  Future<Result<User?>> loginUser({required String email, required String password}) async {
    final result = await loginApi.loginWithEmailAndPassword(email, password);
    return result;
  }

  @override
  Future<Result<void>> logoutUser() async {
    final result = await loginApi.logout();
    return result;
  }
}
