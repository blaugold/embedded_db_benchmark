import 'package:flutter/material.dart';

void showErrorAlert(
  BuildContext context,
  Object? error,
  StackTrace stackTrace,
) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text('$error\n$stackTrace'),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
