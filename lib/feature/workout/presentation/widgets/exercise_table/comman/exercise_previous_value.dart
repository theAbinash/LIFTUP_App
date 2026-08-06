import 'package:flutter/material.dart';

class ExercisePreviousValue extends StatelessWidget {
  final double? weight;
  final int? reps;
  final int? distance;
  final int? duration;

  const ExercisePreviousValue({
    super.key,
    this.weight,
    this.reps,
    this.distance,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    String text = "-";

    if (weight != null || reps != null) {
      final weightText = weight?.toStringAsFixed(
            weight! % 1 == 0 ? 0 : 1,
          ) ??
          "-";

      final repsText = reps?.toString() ?? "-";

      text = "$weightText × $repsText";
    } else if (distance != null) {
      text = "${distance} m";
    } else if (duration != null) {
      text = "${duration}s";
    }

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}