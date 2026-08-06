import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/routine/routine_stats.dart';

class RoutineHeader extends StatelessWidget {
  final RoutineEntity routine;
  final VoidCallback onStart;

  const RoutineHeader({
    super.key,
    required this.routine,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          routine.routineName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 6),

        Text(
          "Created by ${routine.createdPersonName}",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),

        const SizedBox(height: 24),

        RoutineStats(routine: routine),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onStart, 
            child: const Text(
              "Start Routine",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}