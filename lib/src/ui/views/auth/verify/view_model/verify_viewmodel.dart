import 'dart:async';

import 'package:mvvm_riverpod_architecture/src/data/repositories/auth/auth_repository.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/verify/view_model/verify_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verify_viewmodel.g.dart';

@riverpod
class VerifyViewModel extends _$VerifyViewModel {
  @override
  VerifyState build() {
    return VerifyState(false);
  }  

  Future<void> sendEmailVerification() async {
    // loading: true
    // success: false
    // data: null
    // error: null
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.sendEmailVerification();
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

  void setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final authRepository = ref.watch(authRepositoryProvider);
        await authRepository.reload();
        final isVerified = authRepository.currentUser?.emailVerified ?? false;
        if (isVerified) {
          state = VerifyState(true);
          timer.cancel();
        }
      },
    );
  }
}
