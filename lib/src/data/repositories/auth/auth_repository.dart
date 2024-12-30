import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/user/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final firebaseAuth = FirebaseAuth.instance;
  return AuthRepository(firebaseAuth: firebaseAuth);
}

class AuthRepository {
  AuthRepository({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  UserModel? _convertUser(User? user) =>
      user == null ? null : UserModel.fromUser(user);

  UserModel? get currentUser => _convertUser(_firebaseAuth.currentUser);

  Stream<UserModel?> authStateChanges() =>
      _firebaseAuth.authStateChanges().map(_convertUser);

  Stream<UserModel?> userChanges() =>
      _firebaseAuth.userChanges().map(_convertUser);

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updatePassword({required String password}) async {
    try {
      await _firebaseAuth.currentUser?.updatePassword(password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> reload() async {
    try {
      await _firebaseAuth.currentUser?.reload();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
