import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/models.dart';

abstract class LoginApi {
  Future<Result<User?>> loginWithEmailAndPassword(String email, String password);

  Future<Result<void>> logout();
}
