import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/assets.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    this.title = 'Nothing here',
    this.message = 'Add a new item to get started',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage(Assets.empty)),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
