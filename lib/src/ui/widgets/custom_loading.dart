import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.message = 'Loading...',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        gapW16,
        Text(message),
      ],
    );
  }
}
