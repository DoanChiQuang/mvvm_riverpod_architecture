import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/onboarding/widgets/banner_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            const BannerWidget(),
            gapH16,
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(Sizes.s56),
              ),
              onPressed: () => context.goNamed(AppRoute.signIn.name),
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
