import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_page.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_save_page.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_card.dart';

class WorkoutSessionPage extends StatefulWidget {
  final WorkoutSessionEntity session;

  const WorkoutSessionPage({super.key, required this.session});

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  late WorkoutSessionEntity session;
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    session = widget.session;
    _elapsed = session.elapsedDuration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isRunning) {
        setState(() {
          _elapsed += const Duration(seconds: 1);
          session.elapsedDuration = _elapsed;
        });
      }
    });
  }

  void _pauseTimer() => setState(() => _isRunning = false);
  void _resumeTimer() => setState(() => _isRunning = true);

  void _pauseAndExit() {
    _pauseTimer();
    session.elapsedDuration = _elapsed; 
    
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => WorkoutWidget(pausedSession: session),
    ),
    (route) => false,
  );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = d.inHours;
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));

    if (hours > 0) return "$hours hr $minutes min";
    if (d.inMinutes > 0) return "$minutes min $seconds s";
    return "$seconds s";
  }

  int _getTotalSets() {
    return session.exerciseList.fold<int>(
      0,
      (sum, exercise) => sum + exercise.setValueList.length,
    );
  }

  int _getCompletedSets() {
    return session.exerciseList.fold<int>(
      0,
      (sum, exercise) =>
          sum + exercise.setValueList.where((s) => s.isCompleted).length,
    );
  }

  double _getTotalVolumeKg() {
    double total = 0;
    for (var exercise in session.exerciseList) {
      for (var set in exercise.setValueList) {
        if (set.setWeight != null && set.setRepsCount != null) {
          total += set.setWeight! * set.setCount;
        }
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      appBar: AppBar(
        title: Text(session.routineName),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          onPressed: _pauseAndExit,
        ),
        actions: [
          SizedBox(
            width: 90.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(6.r),
                ),
              ),
              onPressed: _finishWorkout,
              child: Text(
                "Finish",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal
                ),
              ),
            )
          )
          
        ],
      ),
      body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _isRunning ? _pauseTimer : _resumeTimer,
                        child: _buildStat(
                          "Duration",
                          _formatDuration(_elapsed),
                          icon: Icons.access_time,
                        ),
                      ),
                      _buildStat(
                        "Volume",
                        "${_getTotalVolumeKg().toStringAsFixed(0)} kg",
                        icon: Icons.fitness_center,
                      ),
                      _buildStat(
                        "Sets",
                        "${_getCompletedSets()}/${_getTotalSets()}",
                        icon: Icons.check_circle_outline,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Divider(height: 1.h, color: Colors.grey,),
                  SizedBox(height: 10.h),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: session.exerciseList.length,
                    itemBuilder: (context, index) {
                      final workout = session.exerciseList[index];
                      return ExerciseCard(
                        exercise: workout,
                        workoutSession: true,
                        onSetComplete: (setIndex) {
                        final currentSet = workout.setValueList[setIndex];
                        currentSet.isCompleted = !(currentSet.isCompleted);
                        setState(() {});
                      },
                        );
                    },
                  ),
                  
                ],
              ),
            )
    );
  }

  void _finishWorkout() {
    final allSets = session.exerciseList.expand((e) => e.setValueList).toList();

    bool hasAnyValue = allSets.any((set) =>
      set.isCompleted && (
      (set.setWeight != null && set.setWeight! > 0) ||
      (set.setRepsCount != null && set.setRepsCount! > 0) ));

    if (!hasAnyValue) {
      showDialog(
        context: context, 
        builder: (_) => AlertDialog(
          content: const Text("You haven't done your workout yet."),
          actions: [
            TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
          ],
        )
        );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WorkoutSavePage(
          duration: _elapsed,
          totalVolumeKg: _getTotalVolumeKg(),
          completedSets: allSets.where((s) => s.isCompleted).length,
          totalSets: allSets.length,
          session: session,
        ),
      )
    );
  }
}

Widget _buildStat(String title, String value, {required IconData icon}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 13.sp,
          ),
        ),
      ],
    );
}