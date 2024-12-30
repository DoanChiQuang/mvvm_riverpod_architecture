import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/onboarding/view_model/onboarding_viewmodel.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/onboarding/widgets/onboarding_banner_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingViewModelProvider);
    return Scaffold(
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            const OnboardingBannerWidget(),
            gapH16,
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(Sizes.s56),
              ),
              onPressed: !onboardingState.isLoading
                  ? () async {
                      final onboardingViewModel =
                          ref.read(onboardingViewModelProvider.notifier);
                      await onboardingViewModel.completeOnboarding();
                      if (context.mounted) {
                        context.goNamed(AppRoute.signIn.name);
                      }
                    }
                  : null,
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
