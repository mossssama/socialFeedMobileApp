import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/firebase_client.dart';
import '../../../../core/models.dart';
import 'register_api.dart';

class RegisterApiFirebaseImpl extends RegisterApi {
  final FirebaseClient _firebase;

  RegisterApiFirebaseImpl(FirebaseClient firebaseClient) : _firebase = firebaseClient;

  @override
  Future<Result<User?>> registerWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _firebase.signUpWithEmailAndPassword(email, password);
      if (response.isSuccess) {
        return Result.success(response.data);
      } else {
        return Result.failure(response.error);
      }
    } catch (e) {
      return Result.failure('Error logging in: $e');
    }
  }
}
