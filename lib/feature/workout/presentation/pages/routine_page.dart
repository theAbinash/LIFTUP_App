import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_state.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_session_page.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_card.dart';

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
                  Text(
                    routine.routineName,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Created by ${routine.createdPersonName ?? ""}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 18.h),

                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat("Est Duration", "${routine.estimatedDuration} min"),
                      _buildStat("Exercises", "${routine.workoutList?.length ?? 0}"),
                      _buildStat("Sets", "${routine.estimatedDuration}"),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
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
                          MaterialPageRoute(
                            builder: (_) => WorkoutSessionPage(session: session),
                          ),
                        );
                      },
                      child: const Text(
                        "Start Routine",
                        style: TextStyle(
                          fontWeight: FontWeight.normal
                        ),
                        ),
                    ),
                  ),
                  SizedBox(height: 18.h),

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
                        onPressed: () {},
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

Widget _buildStat(String title, String value) {
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
