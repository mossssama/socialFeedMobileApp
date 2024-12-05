import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models.dart';

abstract class RegisterRepository {
  Future<Result<User?>> registerUser({required String email, required String password});
}
