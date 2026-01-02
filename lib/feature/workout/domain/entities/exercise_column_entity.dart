import 'package:liftup/feature/workout/presentation/widgets/exercise_ui_config.dart';

class ExerciseColumnEntity {
  final int key;
  final String label;
  final double width;
  final bool? editable;

  const ExerciseColumnEntity({
    required this.key,
    required this.label,
    required this.width,
    this.editable = true,
  });

}

List<ExerciseColumnEntity> buildColumns(ExerciseUIConfig ui, bool workoutSession) {
  final columns = <ExerciseColumnEntity>[
    ExerciseColumnEntity(
      key: 1,
      label: 'SET',
      width: 70,
      editable: false,
    ),
  ];

  if (ui.showWeight) {
    columns.add(ExerciseColumnEntity(
      key: 2,
      label: 'KG',
      width: 70,
    ));
  }

  if (ui.showDuration) {
    columns.add(ExerciseColumnEntity(
      key: 3,
      label: 'TIME',
      width: 70,
    ));
  }

  if (ui.showDistance) {
    columns.add(ExerciseColumnEntity(
      key: 4,
      label: 'DIST',
      width: 70,
    ));
  }

  if (ui.showReps) {
    columns.add(ExerciseColumnEntity(
      key: 5,
      label: 'REPS',
      width: 70,
    ));
  }

  if (workoutSession) {
    columns.add(const ExerciseColumnEntity(
      key: 6,
      label: '',
      width: 36,
      editable: false,
    ));
  }

  return columns;
}
