import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/models.dart';

abstract class RegisterApi {
  Future<Result<User?>> registerWithEmailAndPassword(String email, String password);
}
