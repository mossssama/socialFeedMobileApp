import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/firebase_client.dart';
import '../../../../core/models.dart';
import 'login_api.dart';

class LoginApiFirebaseImpl extends LoginApi {
  final FirebaseClient _firebase;

  LoginApiFirebaseImpl(FirebaseClient firebaseClient) : _firebase = firebaseClient;

  @override
  Future<Result<User?>> loginWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _firebase.signInWithEmailAndPassword(email, password);

      if (response.isSuccess) {
        return Result.success(response.data);
      } else {
        return Result.failure(response.error);
      }
    } catch (e) {
      return Result.failure('Error logging in: $e');
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      final response = await _firebase.signOut();

      if (response.isSuccess) {
        return Result.success(null);
      } else {
        return Result.failure(response.error);
      }
    } catch (e) {
      return Result.failure('Error logging in: $e');
    }
  }
}
