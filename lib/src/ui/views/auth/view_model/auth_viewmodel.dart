import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/domain/model/user/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRepository _authRepository;

  @override
  FutureOr<void> build() {
    _authRepository = ref.watch(authRepositoryProvider);
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _authRepository.signOut(),
    );
  }

  Future<bool> updatePassword({required String password}) async {
    state = const AsyncLoading();
    AsyncValue result = await AsyncValue.guard(
      () => _authRepository.updatePassword(password: password),
    );
    if (result.hasError) {
      state = AsyncError(
        result.error.toString(),
        StackTrace.current,
      );
    }
    return result.hasError == false;
  }

  Future<void> sendMail() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _authRepository.sendEmailVerification(),
    );
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _authRepository.reload(),
    );
  }

  UserModel? getCurrentUser() {
    return _authRepository.currentUser;
  }
}
