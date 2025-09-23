import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_log/feature/workout/presentation/pages/create_routine_page.dart';
import 'package:gym_log/feature/workout/presentation/widgets/new_routine_card.dart';

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Routines",
                style: TextStyle(
                  fontSize: 16.sp, 
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                  ),
              ),

            SizedBox(height: 15.h),

            NewRoutineCard(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const CreateRoutinePage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                    )
                );
              },),
          ],
        ),
        )
    );
  }
}
