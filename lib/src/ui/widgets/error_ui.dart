import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/assets.dart';

class ErrorUI extends StatelessWidget {
  const ErrorUI({
    super.key,
    this.title = 'Error',
    this.message = 'Something went wrong. Please try again.',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage(Assets.error)),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
