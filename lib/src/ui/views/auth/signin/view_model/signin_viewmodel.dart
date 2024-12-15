import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signin_viewmodel.g.dart';

@riverpod
class SigninViewModel extends _$SigninViewModel {
  @override
  dynamic build() {}

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // loading: true
    // success: false
    // data: null
    // error: null
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // success: true
      // data: null or 'Sign in successful.'
      // error: null
    } catch (e) {
      // success: false
      // data: null
      // error: e.message
    } finally {
      // loading: false
    }
  }  
}
