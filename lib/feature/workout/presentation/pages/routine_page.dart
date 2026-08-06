import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_state.dart';
import 'package:liftup/feature/workout/presentation/pages/create_routine_page.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_session_page.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_card.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/routine_exercise_body.dart';
import 'package:liftup/feature/workout/presentation/widgets/routine/routine_header.dart';

class RoutinePage extends StatefulWidget {
  final int routineId;
  const RoutinePage({super.key, required this.routineId});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {

  @override
  void initState(){
    super.initState();
    context.read<RoutineDetailBloc>().add(LoadRoutineDetail(widget.routineId));
  }

  void _startRoutine(routine) {
    final session = WorkoutSessionEntity(
      workoutSessionId: DateTime.now().millisecondsSinceEpoch,
      routineId: routine.routineId,
      routineName: routine.routineName,
      exerciseList: routine.workoutList ?? [],
      startTime: DateTime.now(),
      userId: 1,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WorkoutSessionPage(session: session)),
    );
  }

  @override
  Widget build(Object context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("Routine"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<RoutineDetailBloc, RoutineDetailState>(
        builder: (context, state) {
          if (state is RoutineDetailLoading) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (state is RoutineDetailLoaded) {
            final routine = state.routine;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoutineHeader(
                    routine: routine, 
                    onStart: () => _startRoutine(routine),
                  ),

                  SizedBox(height: 20.h),

                  // Chart placeholder
                  Container(
                    height: 140.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]
                          : Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        "Volume Chart",
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black54,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),

                  // Exercises Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exercises",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CreateRoutinePage(existingRoutine: routine)),
                          );
                          if (context.mounted) {
                            context.read<RoutineDetailBloc>().add(LoadRoutineDetail(widget.routineId));
                          }
                        },
                        child: Text(
                          "Edit Routine",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.normal
                            ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: routine.workoutList!.length,
                    itemBuilder: (context, index) {
                      final workout = routine.workoutList![index];
                      return ExerciseCard(
                        exercise: workout,
                        onExpand: () {},
                        child: RoutineExerciseBody(exercise: workout),
                        );
                    },
                  ),

                ],
              ),
              );
          } 
          return const SizedBox();
        },
      ) 
      );
  }
  
}
