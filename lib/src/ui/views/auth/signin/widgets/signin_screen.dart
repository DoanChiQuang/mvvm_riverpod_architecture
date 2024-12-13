import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mvvm_riverpod_architecture/src/constants/assets.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';
import 'package:mvvm_riverpod_architecture/src/routing/app_router.dart';
import 'package:mvvm_riverpod_architecture/src/ui/views/auth/signin/widgets/signin_form_widget.dart';
import 'package:mvvm_riverpod_architecture/src/ui/widgets/custom_center.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomCenter(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Image(
                    image: AssetImage(Assets.logo),
                    width: 80,
                  ),
                  gapH24,
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  gapH24,
                  SigninFormWidget(),
                  gapH24,
                  Text(
                    'or',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  gapH24,
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(Sizes.s56),
                    ),
                    onPressed: () {},
                    icon: Brand(
                      Brands.google,
                      size: Sizes.iconMd,
                    ),
                    label: Text(
                      'Continue with google',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  gapH24,
                  TextButton(
                    onPressed: () => context.goNamed(AppRoute.signUp.name),
                    child: const Text("Don't have an account?"),
                  )
                ],
              ),
            ),
            gapH16,
            Text(
              'Copyright © 2024 Akashic Team',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
