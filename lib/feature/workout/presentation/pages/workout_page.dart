import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/presentation/pages/create_routine_page.dart';
import 'package:liftup/core/session/session_manager.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/domain/entities/bottom_sheet_menu.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_state.dart';
import 'package:liftup/feature/workout/presentation/pages/routine_page.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_session_page.dart';
import 'package:liftup/feature/workout/presentation/widgets/bottom_sheet_helper.dart';

class WorkoutWidget extends StatefulWidget {
  final WorkoutSessionEntity? pausedSession;
  const WorkoutWidget({super.key, this.pausedSession});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidget();

}

class _WorkoutWidget extends State<WorkoutWidget> {

  int userId = 0;
  WorkoutSessionEntity? _pausedSession;

  @override
  void initState(){
    super.initState();
    _loadUserId();
    _pausedSession = widget.pausedSession;
    context.read<RoutineBloc>().add(LoadRoutine(
      
    ));
  }

  Future<void> _loadUserId() async {
    final id = await SessionManager.getUserId();
    if(!mounted) return;

    setState(() {
      userId = id ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("Workout"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          BlocBuilder<RoutineBloc, RoutineState>(
        builder: (context, state){
          if(state is RoutineLoading){
            return const Center(child: CircularProgressIndicator(),);
          } else if(state is RoutineLoaded) {

            /* if(state.routineList.isEmpty){
              return RefreshIndicator( 
                onRefresh: () async {
                  context.read<RoutineBloc>().add(RefreshRoutine());
                },
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text("No exercises available"),
                      ),
                    )
                  ],
                ),
              );
            } */

            return RefreshIndicator(
              onRefresh: () async {
                context.read<RoutineBloc>().add(RefreshRoutine());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Quick start
                    SizedBox(height: 25,),
                    Text(
                      "Quick Start",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        // Handle Empty Workout Start
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 24, 23, 23),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 10.w),
                            Text(
                              "Start Empty Workout",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h,),

                    //Routine selection
                    Text(
                      "Routines",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (_) => const CreateRoutinePage(),
                                  ),
                                );
                            }, 
                            label: const Text(
                              "New Routine",
                              style: TextStyle(
                                fontWeight: FontWeight.normal
                              ),
                              ),
                            icon: const Icon(Icons.note_add_outlined),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                            )
                          ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {

                            }, 
                            label: const Text(
                              "Explore",
                              style: TextStyle(
                                fontWeight: FontWeight.normal
                              ),
                            ),
                            icon: const Icon(Icons.search),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                            )
                        )
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // My Routines section
                    Text(
                      "My Routines (${state.routineList.length})",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    if(state.routineList.isEmpty) 
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_) => const CreateRoutinePage(),
                            ),
                          );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 24, 23, 23),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                              "+ Add new routine",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                        )   
                      ),
                    ) else 
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.routineList.length,
                        itemBuilder: (context, index) {
                          final routine = state.routineList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RoutinePage(routineId: routine.routineId),
                                ),
                              );
                            },
                            child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 24, 23, 23),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          routine.routineName,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        ),

                                      Transform.translate(
                                        offset: const Offset(0, -2),
                                        child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(
                                          Icons.more_horiz, color: 
                                          Colors.white,
                                          size: 20,
                                          ),
                                        onPressed: () {
                                          showCustomBottomSheet(context, routine.routineName, [
                                            BottomSheetMenu(
                                              icon: Icons.ios_share_outlined,
                                              label: "Share Routine",
                                              onTap: () {
                                                
                                              },
                                            ),

                                          BottomSheetMenu(
                                            icon: Icons.copy,
                                            label: "Duplicate Routine",
                                            onTap: () {
                                              
                                            },
                                          ),

                                          BottomSheetMenu(
                                            icon: Icons.edit_outlined,
                                            label: "Edit Routine",
                                            onTap: () {
                                              // open edit page
                                            },
                                          ),

                                          BottomSheetMenu(
                                            icon: Icons.delete,
                                            label: "Delete Routine",
                                            color: Colors.red,
                                            onTap: () {
                                              
                                            },
                                          ),

                                          ]);
                                        },
                                      ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: 4),

                                  Text(
                                    routine.workoutList
                                            ?.map((e) => e.exerciseName)
                                            .take(3)
                                            .join(", ") ??
                                        "No exercises",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(height: 10.h),
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
                                      onPressed: () async {
                                        final session = WorkoutSessionEntity(
                                          workoutSessionId: DateTime.now().millisecondsSinceEpoch,
                                          routineName: routine.routineName,
                                          startTime: DateTime.now(),
                                          exerciseList: routine.workoutList ?? [], 
                                          routineId: routine.routineId, 
                                          userId: 1,
                                        );

                                        final returnedSession = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                             WorkoutSessionPage(session: session),
                                          ),
                                        );

                                        if(returnedSession != null && mounted) {
                                          final paused = returnedSession as WorkoutSessionEntity;
                                          if(!paused.isCompleted) {
                                            setState(() =>
                                              _pausedSession = paused
                                            );
                                          }
                                        } 
                                      },
                                      child: const Text(
                                        "Start Routine",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ),
                          )
                          );
                        }
                        ),

                      SizedBox(height: 100.h),
                  ],
                ),
              )
          );
          } else if (state is RoutineError){
            return Center(child: Text(state.message),);
          }

          return SizedBox();
        }
      ),
 
      if (_pausedSession !=  null)
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            border: Border(
              top: BorderSide(color: Colors.black54, width: 0.5),
            ),
          ),

          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Workout in Progress",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final resumed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                WorkoutSessionPage(session: _pausedSession!),
                          ),
                        );

                        if (resumed != null && mounted) {
                          final returned = resumed as WorkoutSessionEntity;
                          if (!returned.isCompleted) {
                            setState(() => _pausedSession = returned);
                          } else {
                            setState(() => _pausedSession = null);
                          }
                        }
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.blue),
                      label: Text(
                        "Resume",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(width: 20.w),

                    TextButton.icon(
                      onPressed: () {
                        setState(() => _pausedSession = null);
                      },
                      icon: const Icon(Icons.close, color: Colors.red),
                      label: const Text(
                        "Discard",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
        )
        )
      ],
      )
      
    );
  }
}
