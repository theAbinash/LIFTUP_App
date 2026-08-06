import 'package:flutter/material.dart';
import 'package:liftup/core/theme/app_card.dart';
import 'package:liftup/core/widgets/app_section_divider.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_header.dart';

class ExerciseCard extends StatelessWidget {
  final RoutineExerciseEntity exercise;
  final Widget child;
  final VoidCallback onExpand;
  final Widget? trailing;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.child,
    required this.onExpand,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      border: Border.all(color: Colors.transparent, width: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ExerciseHeader(
            title: exercise.exerciseName ?? "",
            imageUrl: exercise.exerciseImageUrl ?? "",
            bodyParts: exercise.exerciseBodyParts,
            equipments: exercise.exerciseEquipments,
            onToggleExpand: onExpand,
            trailing: trailing ?? const SizedBox.shrink(),
          ),
          
          const AppSectionDivider(),
          child,
          
        ],
      ),
    );
  }
}