import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CustomCupertinoActionSheet extends StatelessWidget {
  const CustomCupertinoActionSheet({
    super.key,
    this.defaultText,
    this.destructiveText,
    this.onDefaultPressed,
    this.onDestructivePressed,
  });

  final String? defaultText;
  final String? destructiveText;
  final Function()? onDefaultPressed;
  final Function()? onDestructivePressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: false,
          onPressed: () {
            onDefaultPressed!();
            context.pop();
          },
          child: Text(defaultText ?? 'Default'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            onDestructivePressed!();
            context.pop();
          },
          child: Text(destructiveText ?? 'Destructive'),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
