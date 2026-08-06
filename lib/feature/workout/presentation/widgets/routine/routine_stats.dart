import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';

class RoutineStats extends StatelessWidget {
  final RoutineEntity routine;

  const RoutineStats({
    super.key,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              value: "${routine.estimatedDuration}",
              unit: "min",
              label: "Duration",
            ),
          ),

          const VerticalDivider(
            thickness: 0.4,
            color: Color.fromARGB(255, 187, 186, 186),
          ),

          Expanded(
            child: _StatItem(
              value: "${routine.workoutList?.length ?? 0}",
              label: "Exercises",
            ),
          ),

          const VerticalDivider(
            thickness: 0.4,
            color: Color.fromARGB(255, 187, 186, 186),
          ),

          Expanded(
            child: _StatItem(
              value: "${routine.estimatedDuration}",
              label: "Sets",
            ),
          ),

          const VerticalDivider(
            thickness: 0.4,
            color: Color.fromARGB(255, 187, 186, 186),
          ),

          const Expanded(
            child: Center(
              child: Icon(Icons.accessibility_new, size: 36, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final String? unit;

  const _StatItem({
    required this.value,
    required this.label,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: value),
              if (unit != null)
                TextSpan(
                  text: " $unit",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}