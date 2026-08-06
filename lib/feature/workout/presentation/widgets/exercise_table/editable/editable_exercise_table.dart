import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/add_set_button.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/editable/editable_set_row.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_table_header.dart';

class EditableExerciseTable extends StatefulWidget {
  final List<RoutineSetEntity> sets;
  final VoidCallback? onAddSet;
  final RoutineExerciseEntity exercise;

  const EditableExerciseTable({
    super.key,
    required this.sets,
    this.onAddSet,
    required this.exercise
  });

  @override
  State<EditableExerciseTable> createState() => _EditableExerciseTableState();

}

class _EditableExerciseTableState extends State<EditableExerciseTable> {
  static const _layout = ExerciseTableLayout.editableStrength;

  final List<TextEditingController> _weightControllers = [];
  final List<TextEditingController> _repsControllers = [];
  final List<TextEditingController> _distanceControllers = [];
  final List<TextEditingController> _durationControllers = [];

  int _lastKnownLength = 0;
  List<RoutineSetEntity> get _sets => widget.exercise.setValueList;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void didUpdateWidget(covariant EditableExerciseTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_lastKnownLength != _sets.length) {
      _disposeControllers();
      _initializeControllers();
    }
  }

  void _initializeControllers() {
    for (final set in widget.sets) {
      _weightControllers.add(TextEditingController(text: set.setWeight?.toString() ?? ''));
      _repsControllers.add(TextEditingController(text: set.setRepsCount?.toString() ?? ''));
      _distanceControllers.add(TextEditingController(text: set.setDistance?.toString() ?? ''));
      _durationControllers.add(TextEditingController(text: set.setDuration?.toString() ?? ''));
    }
    _lastKnownLength = _sets.length;
  }

  void _disposeControllers() {
    for (final c in _weightControllers) c.dispose();
    for (final c in _repsControllers) c.dispose();
    for (final c in _distanceControllers) c.dispose();
    for (final c in _durationControllers) c.dispose();
    _weightControllers.clear();
    _repsControllers.clear();
    _distanceControllers.clear();
    _durationControllers.clear();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /* final layout = ExerciseTableLayout.forExerciseType(
      widget.exercise.exerciseType,
      mode: ExerciseTableMode.editable,
    ); */

    return Column(
      children: [

        ExerciseTableHeader(layout: _layout),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _sets.length,
          itemBuilder: (context, index) {

            final set = _sets[index];

            return EditableSetRow(
              layout: _layout,
              isEven: index.isEven,
              setNumber: set.setCount,
              weightController: _weightControllers[index],
              repsController: _repsControllers[index],
              distanceController: _distanceControllers[index],
              durationController: _durationControllers[index],
              onWeightChanged: (value) {
                set.setWeight =
                    double.tryParse(value);
              },

              onRepsChanged: (value) {
                set.setRepsCount =
                    int.tryParse(value);
              },

              onDistanceChanged: (value) {
                set.setDistance = int.tryParse(value);
              },
              
              onDurationChanged: (value) {
                set.setDuration = int.tryParse(value);
              } 
            );
          },
        ),

        AddSetButton(
          onPressed: widget.onAddSet,
        ),
      ],
    );
  }
}