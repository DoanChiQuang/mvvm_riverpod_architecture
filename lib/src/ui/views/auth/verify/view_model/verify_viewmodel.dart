import 'dart:async';

import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/verify/view_model/verify_state.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/loading_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verify_viewmodel.g.dart';

@riverpod
class VerifyViewModel extends _$VerifyViewModel {
  @override
  VerifyState build() {
    return VerifyState(LoadingStateEnum.initial, null, false);
  }

  Future<void> sendEmailVerification() async {
    state = VerifyState(LoadingStateEnum.loading, null, false);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.sendEmailVerification();
      state = VerifyState(LoadingStateEnum.success, null, false);
    } on Exception catch (e) {
      state = VerifyState(LoadingStateEnum.error, e, false);
    }
  }

  void setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final authRepository = ref.watch(authRepositoryProvider);
        await authRepository.reload();
        final isVerified = authRepository.currentUser?.emailVerified ?? false;
        if (isVerified) {
          state = VerifyState(LoadingStateEnum.success, null, true);
          timer.cancel();
        }
      },
    );
  }

  Future<void> signOut() async {
    state = VerifyState(LoadingStateEnum.loading, null, false);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signOut();
      state = VerifyState(LoadingStateEnum.success, null, false);
    } on Exception catch (e) {
      state = VerifyState(LoadingStateEnum.error, e, false);
    }
  }
}
