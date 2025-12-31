import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customizedbutton extends StatelessWidget {

  final String buttonText;
  final VoidCallback? onPressed;
  final Color? textColor;

  const Customizedbutton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[850],
                foregroundColor: textColor ?? theme.colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)
                )
              ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontWeight: FontWeight.normal
        ),
      ),
      ),
    );
    
  }

}