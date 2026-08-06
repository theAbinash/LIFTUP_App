import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

class WorkoutCompletedPage extends StatelessWidget {
  final WorkoutSessionEntity session;

  const WorkoutCompletedPage({
    super.key,
    required this.session,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Test"),
          ],
        )
        ),
    );
  }
  
}