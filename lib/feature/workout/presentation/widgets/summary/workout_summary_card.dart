import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/theme/app_card.dart';
import 'package:liftup/feature/workout/presentation/widgets/summary/body_overview_placeholder.dart';
import 'package:liftup/feature/workout/presentation/widgets/summary/workout_summary_section.dart';

class WorkoutSummaryCard extends StatelessWidget {
  final String duration;
  final String volume;
  final String sets;

  final bool isRunning;

  final VoidCallback onDurationTap;

  const WorkoutSummaryCard({
    super.key,
    required this.duration,
    required this.volume,
    required this.sets,
    required this.isRunning,
    required this.onDurationTap,
  });

  @override
  Widget build(BuildContext context) {

    return AppCard(
      child: Row(
              children: [
                Expanded(
                  child: WorkoutSummarySection(
                    title: "Duration",
                    value: duration,
                    icon: isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    onTap: onDurationTap,
                  ),
                ),

                Expanded(
                  child: WorkoutSummarySection(
                    title: "Volume",
                    value: volume,
                    icon: Icons.fitness_center,
                  ),
                ),

                Expanded(
                  child: WorkoutSummarySection(
                    title: "Sets",
                    value: sets,
                    icon: Icons.check_circle_outline,
                  ),
                ),

                //const BodyOverviewPlaceholder(),
              ],
          ),
    );
  }
}