import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod_architecture/src/utils/helpers/alert_dialogs.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    debugPrint('isLoading: $isLoading, hasError: $hasError');
    if (!isLoading && hasError) {
      final message = error.toString();
      showExceptionAlertDialog(
        context: context,
        title: 'Error',
        exception: message,
      );
    }
  }
}
