import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const ErrorBanner({
    super.key,
    required this.message,
    this.onDismiss
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.redAccent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white,),
            const SizedBox(width: 8,),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white, fontSize: 14.sp
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
              ),
              IconButton(
                onPressed: onDismiss, 
                icon: const Icon(Icons.close, color: Colors.white))
          ],
        ),
      ),
    );
  }
}