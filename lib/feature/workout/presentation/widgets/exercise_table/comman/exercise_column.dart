import 'package:flutter/material.dart';

class ExerciseColumn extends StatelessWidget {
  final int? flex;
  final double? width;
  final Widget child;
  final Alignment alignment;

  const ExerciseColumn({
    super.key,
    required this.child,
    this.flex,
    this.width,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {

    if (flex != null) {
      return Expanded(
        flex: flex!,
        child: Align(
          alignment: alignment,
          child: child,
        ),
      );
    }
    
    return SizedBox(
      width: width,
      child: Align(
        alignment: alignment,
        child: child,
      ),
    );
  }
}