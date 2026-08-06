import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/theme/app_insets.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_state.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_completed_page.dart';
import 'package:liftup/feature/workout/presentation/widgets/customizedButton.dart';

class WorkoutSavePage extends StatefulWidget {
  final Duration duration;
  final double totalVolumeKg;
  final int completedSets;
  final int totalSets;
  final WorkoutSessionEntity session;

  const WorkoutSavePage({
    super.key,
    required this.duration,
    required this.totalVolumeKg,
    required this.completedSets,
    required this.totalSets,
    required this.session
  });

  @override
  State<WorkoutSavePage> createState() => _WorkoutSavePageState();
}

class _WorkoutSavePageState extends State<WorkoutSavePage> {

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "${d.inHours}h $minutes $seconds s";
  }
  
  Future<void> _saveWorkout() async {

    final completedSession = widget.session.copyWith(
      endTime: DateTime.now(),
      totalSets: widget.completedSets,
      totalVolume: widget.totalVolumeKg,
      durationMs: widget.duration.inMilliseconds,
    );

    context.read<RoutineBloc>().add(
      SaveWorkoutData(completedSession),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController? _noteController;
    return BlocListener<RoutineBloc, RoutineState>(
      listener: (context, state) {
        if (state is SaveWorkoutSuccess) {
          Navigator.pushReplacement(context, 
            MaterialPageRoute(
              builder: (_) => WorkoutCompletedPage(session: state.session)
              )
            );
        }

        if (state is RoutineError) {  
          
        }
      },

      child: AppScaffold(
      appBar: AppBar(
        title: const Text("Save Workout"),
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
              onPressed: _saveWorkout,
              child: Text(
                "Save",
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
        padding: AppInsets.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.session.routineName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context), 
                  icon: const Icon(Icons.close)
                )
              ],
            ),

            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statItem("Duration", formatDuration(widget.duration)),
                _statItem("Volume", "${widget.totalVolumeKg.toStringAsFixed(0)} kg"),
                _statItem("Sets", widget.completedSets.toString()),
              ],
            ),

            SizedBox(height: 4.h),
            Divider(),

            _sectionLabel("When"),
            SizedBox(height: 5.h),
            Text(
              _formatDateTime(widget.session.startTime),
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
            Divider(),

            SizedBox(height: 5.h,),
            InkWell(
              onTap: () {

              },
              child: Row(
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add_a_photo_outlined),
                  ),

                  SizedBox(width: 16.h),
                  const Text(
                    "Add a photo / video",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Divider(),

            // Description
            _sectionLabel("Description"),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              maxLines: 3,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: "How did your workout go? Leave some notes here...",
                border: InputBorder.none,
              ),
            ),
            Divider(),

            // Visibility
            _settingsTile(
              title: "Visibility",
              value: "Everyone",
              onTap: () {},
            ),
            Divider(),

            // Routine settings
            _settingsTile(
              title: "Routine Settings",
              onTap: () {},
            ),

          SizedBox(height: 30.h),

          Center(
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 8.h,),

                            Text(
                              "Are you sure you want to discard this workout?",
                              textAlign: TextAlign.center,
                              //style: Theme.of(context).textTheme.titleSmall,
                            ),

                            SizedBox(height: 20.h),

                            Customizedbutton(
                              buttonText: "Discard Workout", 
                              textColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            ),

                            SizedBox(height: 5.h,),

                            Customizedbutton(
                              buttonText: "Cancel", 
                              onPressed: () => Navigator.pop(context),
                            ),
                            
                          ],
                        ),
                      ),
                    );
                  }
                  );
              },  
              child: const Text(
                "Discard Workout",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
              )
              ),
          )

          ],
        ),
      )
      ),
    );
    
  }

  // ---------- Helpers ----------
  Widget _statItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  Widget _settingsTile({
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }

  String _formatDateTime(DateTime dt) {
    return "${dt.day} ${_month(dt.month)} ${dt.year}, "
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  String _month(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[m - 1];
  }
  
}