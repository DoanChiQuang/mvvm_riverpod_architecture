import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_viewmodel.g.dart';

@riverpod
class SignupViewModel extends _$SignupViewModel {
  @override
  dynamic build() {}

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // loading: true
    // success: false
    // data: null
    // error: null
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(
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
