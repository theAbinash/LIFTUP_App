import 'package:flutter/material.dart';

class AppConfirmDialog {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    String? message,
    String confirmText = "Discard",
    String cancelText = "Cancel",
    Color confirmColor = Colors.red,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: message != null ? Text(message) : null,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(confirmText, style: TextStyle(color: confirmColor)),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}