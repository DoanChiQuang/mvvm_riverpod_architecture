import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/loading_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signin_viewmodel.g.dart';

@riverpod
class SigninViewModel extends _$SigninViewModel {
  @override
  LoadingState build() {
    return const LoadingState(LoadingStateEnum.initial, null);
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const LoadingState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const LoadingState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = LoadingState(LoadingStateEnum.error, e);
    }
  }
}
