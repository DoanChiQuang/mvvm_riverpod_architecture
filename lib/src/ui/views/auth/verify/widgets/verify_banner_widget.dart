import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/assets.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';

class VerifyBannerWidget extends StatelessWidget {
  const VerifyBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Image(
            image: AssetImage(Assets.logo),
            width: 80,
          ),
          gapH16,
          Text(
            'Verify your email',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          const Image(image: AssetImage(Assets.notifyMail)),
          gapH16,
          Text(
            'An email has been sent to youremail@gmail.com with link to verify your account. If you have not received the email after a few minutes, please check your spam folder.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
