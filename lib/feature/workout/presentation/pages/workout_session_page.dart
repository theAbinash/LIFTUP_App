import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

import 'package:liftup/feature/workout/presentation/controllers/exercise_set_controller_manager.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_page.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_save_page.dart';
import 'package:liftup/feature/workout/presentation/widgets/appbar/workout_app_bar.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_card.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/workout_exercise_body.dart';
import 'package:liftup/feature/workout/presentation/widgets/summary/workout_summary_card.dart';

class WorkoutSessionPage extends StatefulWidget {
  final WorkoutSessionEntity session;

  const WorkoutSessionPage({
    super.key,
    required this.session,
  });

  @override
  State<WorkoutSessionPage> createState() =>
      _WorkoutSessionPageState();
}

class _WorkoutSessionPageState
    extends State<WorkoutSessionPage> {

  late WorkoutSessionEntity session;
  late final ExerciseSetControllerManager _controllerManager;
  final Set<int> _expandedExercises = {};

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    session = widget.session;
    _elapsed = session.elapsedDuration;
    _controllerManager = ExerciseSetControllerManager();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controllerManager.dispose();
    super.dispose();
  }

  void _addSet(RoutineExerciseEntity exercise) {
    setState(() {
      exercise.setValueList.add(
        RoutineSetEntity(
          setCount: exercise.setValueList.length + 1,
          setWeight: 0,
          setRepsCount: 0,
        ),
      );
    });
  }

  void _showRestTimerBottomSheet(
  RoutineExerciseEntity exercise,
) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {

        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                title: const Text("Off"),
                onTap: () {
                  setState(() {
                    exercise.exerciseRestTime = 0;
                  });
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text("30 sec"),
                onTap: () {
                  setState(() {
                    exercise.exerciseRestTime = 30;
                  });
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text("60 sec"),
                onTap: () {
                  setState(() {
                    exercise.exerciseRestTime = 60;
                  });
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text("90 sec"),
                onTap: () {
                  setState(() {
                    exercise.exerciseRestTime = 90;
                  });
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text("120 sec"),
                onTap: () {
                  setState(() {
                    exercise.exerciseRestTime = 120;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

void _finishWorkout() {

  final allSets = session.exerciseList
      .expand((e) => e.setValueList)
      .toList();

  final hasWorkout = allSets.any(
    (set) =>
        set.isCompleted &&
        ((set.setWeight ?? 0) > 0 ||
            (set.setRepsCount ?? 0) > 0),
  );

  if (!hasWorkout) {

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Workout"),

        content: const Text(
          "You haven't completed any sets.",
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    return;
  }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutSavePage(
          duration: _elapsed,
          totalVolumeKg: _getTotalVolumeKg(),
          completedSets: _getCompletedSets(),
          totalSets: _getTotalSets(),
          session: session,
        ),
      ),
    );
  }

  //------------------------------------------------------------
  // Timer
  //------------------------------------------------------------

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!_isRunning) return;
        setState(() {
          _elapsed += const Duration(seconds: 1);
          session.elapsedDuration = _elapsed;
        });
      },
    );
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resumeTimer() {
    setState(() {
      _isRunning = true;
    });
  }

  void _toggleExpanded(
      RoutineExerciseEntity exercise) {
    setState(() {
      if (_expandedExercises
          .contains(exercise.exerciseId)) {
        _expandedExercises
            .remove(exercise.exerciseId);
      } else {
        _expandedExercises
            .add(exercise.exerciseId);
      }
    });
  }

  //------------------------------------------------------------
  // Pause Workout
  //------------------------------------------------------------

  void _pauseAndExit() {
    _pauseTimer();

    session.elapsedDuration = _elapsed;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutWidget(
          pausedSession: session,
        ),
      ),
      (route) => false,
    );
  }

  //------------------------------------------------------------
  // Helpers
  //------------------------------------------------------------

  String _formatDuration(Duration d) {
    String twoDigits(int n) =>
        n.toString().padLeft(2, "0");

    final hours = d.inHours;
    final minutes =
        twoDigits(d.inMinutes.remainder(60));
    final seconds =
        twoDigits(d.inSeconds.remainder(60));
        
    if (hours > 0) {
      return "$hours hr $minutes min";
    }

    if (d.inMinutes > 0) {
      return "$minutes min $seconds s";
    }

    return "$seconds s";
  }

  int _getTotalSets() {
    return session.exerciseList.fold(
      0,
      (sum, exercise) =>
          sum + exercise.setValueList.length,
    );
  }

  int _getCompletedSets() {
    return session.exerciseList.fold(
      0,
      (sum, exercise) =>
          sum +
          exercise.setValueList
              .where((e) => e.isCompleted)
              .length,
    );
  }

  double _getTotalVolumeKg() {
    double total = 0;

    for (final exercise
        in session.exerciseList) {
      for (final set
          in exercise.setValueList) {
        if (set.setWeight != null &&
            set.setRepsCount != null) {
          total +=
              set.setWeight! *
              set.setCount;
        }
      }
    }

    return total;
  }

  //------------------------------------------------------------
  // Build
  //------------------------------------------------------------

    @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: WorkoutAppBar(
        title: session.routineName,
        onClose: _pauseAndExit,
        onFinish: _finishWorkout,
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(16.w),

        itemCount: session.exerciseList.length + 1,

        separatorBuilder: (_, __) => SizedBox(height: 16.h),

        itemBuilder: (context, index) {

          /// Workout Summary
          if (index == 0) {
            return WorkoutSummaryCard(
              duration: _formatDuration(_elapsed),

              volume:
                  "${_getTotalVolumeKg().toStringAsFixed(0)} kg",

              sets:
                  "${_getCompletedSets()}/${_getTotalSets()}",

              isRunning: _isRunning,

              onDurationTap: () {
                if (_isRunning) {
                  _pauseTimer();
                } else {
                  _resumeTimer();
                }
              },
            );
          }

          /// Exercise Card
          final exercise = session.exerciseList[index - 1];

          return ExerciseCard(
            exercise: exercise,
            onExpand: () {
              _toggleExpanded(exercise);
            },
            child: WorkoutExerciseBody(
              exercise: exercise, 
              controllerManager: _controllerManager,

              onNotesChanged: (value) {
                exercise.exerciseNote = value;
              },
              onRestTimerTap: () {
                _showRestTimerBottomSheet(exercise);
              },
              onAddSet: () {
                _addSet(exercise);
              },
            ),
          );
        },
      ),
    );
  }

}