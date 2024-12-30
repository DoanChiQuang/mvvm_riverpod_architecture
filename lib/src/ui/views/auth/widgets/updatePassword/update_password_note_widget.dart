import 'package:flutter/material.dart';
import 'package:mvvm_riverpod_architecture/src/constants/sizes.dart';

class UpdatePasswordNoteWidget extends StatelessWidget {
  const UpdatePasswordNoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.article_outlined,
              size: Sizes.iconMd,
            ),
            gapW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note: Your password must have',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '\u2022 At least 8 characters',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\u2022 At least 1 uppercase',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\u2022 At least 1 number',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\u2022 At least 1 special character',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
