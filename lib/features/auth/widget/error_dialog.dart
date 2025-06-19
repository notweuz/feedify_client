import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'OK',
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog(
      context: context,
      builder: (context) => ErrorDialog(
        title: title,
        message: message,
        buttonText: buttonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(buttonText),
        ),
      ],
    );
  }
} 