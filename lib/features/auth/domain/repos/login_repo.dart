import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models.dart';

abstract class LoginRepository {
  Future<Result<User?>> loginUser({required String email, required String password});

  Future<Result<void>> logoutUser();
}
