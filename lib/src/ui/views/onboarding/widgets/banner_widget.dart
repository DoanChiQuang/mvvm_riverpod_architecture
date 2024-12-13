import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/assets.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

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
            'Welcome to\nTask Management',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          const Image(image: AssetImage(Assets.banner)),
        ],
      ),
    );
  }
}
