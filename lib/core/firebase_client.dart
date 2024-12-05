import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import 'models.dart';

class FirebaseClient {
  final Logger logger;
  late FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  FirebaseClient({required this.logger});

  Future<Result<User?>> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i("User signed up: ${result.user?.uid}");
      return Result.success(result.user);
    } catch (e) {
      logger.f("Error signing up: $e");
      return Result.failure(e.toString().extractFirebaseError());
    }
  }

  Future<Result<User?>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i("User signed in: ${result.user?.uid}");
      return Result.success(result.user);
    } catch (e) {
      logger.f("Error signing in: $e");
      return Result.failure(e.toString().extractFirebaseError());
    }
  }

  Future<Result<void>> signOut() async {
    try {
      await firebaseAuth.signOut();
      logger.i("User signed out");
      return Result.success(null);
    } catch (e) {
      logger.f("Error signing out: $e");
      return Result.failure(e.toString().extractFirebaseError());
    }
  }

  Future<Result<void>> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      logger.i("Password reset email sent to: $email");
      return Result.success(null);
    } catch (e) {
      logger.f("Error sending password reset email: $e");
      return Result.failure(e.toString().extractFirebaseError());
    }
  }

  Future<Result<String?>> getIdToken({bool forceRefresh = false}) async {
    try {
      final token = await currentUser?.getIdToken(forceRefresh);
      logger.i("Fetched ID token");
      return Result.success(token);
    } catch (e) {
      logger.f("Error fetching ID token: $e");
      return Result.failure(e.toString().extractFirebaseError());
    }
  }
}

extension FirebaseStringHandlers on String {
  String extractFirebaseError() {
    int closingBracketIndex = indexOf(']');

    if (closingBracketIndex == -1) {
      return this;
    }
    int startIndex = indexOf(' ', closingBracketIndex);

    if (startIndex == -1) {
      return substring(closingBracketIndex + 1).trim();
    }
    return substring(startIndex + 1).trim();
  }
}
