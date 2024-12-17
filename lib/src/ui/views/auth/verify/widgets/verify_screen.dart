import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/verify/view_model/verify_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/verify/widgets/verify_banner_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  ConsumerState<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      final viewModel = ref.read(verifyViewModelProvider.notifier);
      viewModel.sendEmailVerification();
      viewModel.setTimerForAutoRedirect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(verifyViewModelProvider.notifier);
    ref.listen(verifyViewModelProvider, (prev, state) {
      if (state.isVerified) {
        context.goNamed(AppRoute.todos.name);
      }
    });
    return Scaffold(
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            const VerifyBannerWidget(),
            gapH16,
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(Sizes.s56),
              ),
              onPressed: () => viewModel.sendEmailVerification(),
              child: const Text('Resend'),
            ),
            gapH16,
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(Sizes.s56),
              ),
              onPressed: () => viewModel.signOut(),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
