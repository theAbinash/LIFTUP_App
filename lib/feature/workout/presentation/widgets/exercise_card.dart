import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_column_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_ui_config.dart';
import 'package:liftup/feature/workout/presentation/widgets/table_header_row.dart';
import 'package:liftup/feature/workout/presentation/widgets/table_value_row.dart';
import 'package:liftup/feature/workout/presentation/widgets/table_widget.dart';

class ExerciseCard extends StatefulWidget {

  final RoutineExerciseEntity exercise;
  final bool isEditable;
  final bool workoutSession;
  final VoidCallback? onAddSet;
  final void Function(int setIndex)? onDeleteSet;
  final void Function(int setIndex)? onSetComplete;
  final Widget? extraWidget;

  const ExerciseCard({
    super.key,
    required this.exercise,
    this.isEditable = false,
    this.workoutSession = false,
    this.onAddSet,
    this.onDeleteSet,
    this.onSetComplete,
    this.extraWidget,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCard();

}

class _ExerciseCard extends State<ExerciseCard> {
  late ExerciseUIConfig uiConfig;

  @override
  void initState() {
    super.initState();
    uiConfig = getExerciseUIConfig(widget.exercise.exerciseType);
  }
 
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final columns = buildColumns(uiConfig, widget.workoutSession);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(widget.exercise.exerciseImageUrl ?? ''),
                backgroundColor: Colors.white,
                onBackgroundImageError: (_, __) {},
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  widget.exercise.exerciseName ?? '',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (widget.isEditable)
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // bottom sheet actions
                },
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // ---- Routine notes ----
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Add routine notes here",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8.h),

          // ---- Rest Timer row ----
          Row(
            children: [
              const Icon(Icons.timer, color: Colors.grey, size: 20),
              SizedBox(width: 6.h),
              const Text(
                "Rest Timer:",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              ),
              SizedBox(width: 6.w),
              /* Expanded(
                child: Text(
                  workout. ?? "OFF",
                  style: const TextStyle(color: Colors.white),
                ),
              ), */
            ],
          ),

          SizedBox(height: 12.h),

          TableHeaderRow(columns: columns, theme: theme),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.exercise.setValueList.length,
            itemBuilder: (context, index) {
              final set = widget.exercise.setValueList[index];
              final isEven = index  % 2 == 0;
              final isCompleted = set.isCompleted == true;

              final double weight = (set.prevSetWeight ?? 0) > 0
                                          ? set.prevSetWeight!
                                          : (set.setWeight ?? 0);

              final int reps = (set.prevRepsCount ?? 0) > 0
                                          ? set.prevRepsCount!
                                          : (set.setRepsCount ?? 0);

              final int duration = (set.prevSetDuration ?? 0) > 0
                                          ? set.prevSetDuration!
                                          : (set.setDuration ?? 0);

              final int distance = (set.prevSetDistance ?? 0) > 0
                                          ? set.prevSetDistance!
                                          : (set.setDistance ?? 0);

              return TableValueRow(
                columns: columns, 
                set: set, 
                theme: theme,
                onComplete: () => widget.onSetComplete?.call(index),
                );
            } 
            ),

          /* TableWidget(
            columns: columns, 
            exercises: widget.exercise, 
            theme: theme
            ), */

          /* Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: Text("SET", style: theme.textTheme.labelLarge),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: widget.workoutSession 
                    ? Text("PREVIOUS", style: theme.textTheme.labelLarge)
                    : const SizedBox.shrink(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: uiConfig.showWeight 
                    ? Text("KG", style: theme.textTheme.labelLarge)
                    : const SizedBox.shrink(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: uiConfig.showDuration 
                    ? Text("Time", style: theme.textTheme.labelLarge)
                    : const SizedBox.shrink(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: uiConfig.showDistance 
                    ? Text("Distance", style: theme.textTheme.labelLarge)
                    : const SizedBox.shrink(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: uiConfig.showReps 
                    ? Text("REPS", style: theme.textTheme.labelLarge)
                    : const SizedBox.shrink(),
                ),
                  Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: widget.workoutSession 
                      ? Icon(Icons.check, color: Colors.grey, size: 18)
                      : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
          

          // --- Set List ---
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.exercise.setValueList.length,
            itemBuilder: (context, setIndex) {
              final set = widget.exercise.setValueList[setIndex];
              final isEven = setIndex  % 2 == 0;
              final isCompleted = set.isCompleted == true;

              final double weight = (set.prevSetWeight ?? 0) > 0
                                          ? set.prevSetWeight!
                                          : (set.setWeight ?? 0);

              final int reps = (set.prevRepsCount ?? 0) > 0
                                          ? set.prevRepsCount!
                                          : (set.setRepsCount ?? 0);

              final int duration = (set.prevSetDuration ?? 0) > 0
                                          ? set.prevSetDuration!
                                          : (set.setDuration ?? 0);

              final int distance = (set.prevSetDistance ?? 0) > 0
                                          ? set.prevSetDistance!
                                          : (set.setDistance ?? 0);

              /* final String previousValue = (
                (exercise.exerciseType == Constants.exerciseTypeWithReps ? set.prevRepsCount : ) ||
                (exercise.exerciseType == Constants.exerciseTypeWithReps ? )
              ).toString();
 */
              final bgColor = isCompleted
                  ? Colors.green.withOpacity(0.3)
                  : (isEven
                      ? Colors.black 
                      : const Color.fromARGB(255, 40, 37, 37));

              return Slidable(
                key: ValueKey(set.setCount),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.26,
                  children: [
                    if(widget.isEditable)
                    SlidableAction(
                      onPressed: (_) => widget.onDeleteSet?.call(setIndex),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      //icon: Icons.delete,
                      label: 'Delete',
                      ),
                  ]
                ), 
                child: Container(
                  color: bgColor,
                  //color: isEven ? Colors.black : const Color.fromARGB(255, 40, 37, 37),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: set.setCount.toString(),
                          readOnly: true,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          style: theme.textTheme.bodySmall,
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: widget.workoutSession 
                          ? TextFormField(
                              //previous
                              initialValue: set.setCount.toString(),
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: theme.textTheme.bodySmall,
                            )
                          : const SizedBox.shrink(),
                      ),

                      Expanded(
                        flex: 1,
                        child: uiConfig.showWeight 
                          ? TextFormField(
                              initialValue: weight.toString(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: theme.textTheme.bodySmall,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                set.setWeight = double.tryParse(value);
                              },
                            )
                          : const SizedBox.shrink(),
                      ),

                      Expanded(
                        flex: 1,
                        child: uiConfig.showDuration 
                          ? TextFormField(
                              initialValue: duration.toString(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: theme.textTheme.bodySmall,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                set.setDuration = int.tryParse(value);
                              },
                            )
                          : const SizedBox.shrink(),
                      ),

                      Expanded(
                        flex: 1,
                        child: uiConfig.showDistance 
                          ? TextFormField(
                              initialValue: distance.toString(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: theme.textTheme.bodySmall,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                set.setDistance = int.tryParse(value);
                              },
                            )
                          : const SizedBox.shrink(),
                      ),

                      Expanded(
                        flex: 1,
                        child: uiConfig.showReps 
                          ? TextFormField(
                              initialValue: reps.toString(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: theme.textTheme.bodySmall,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                set.setRepsCount = int.tryParse(value);
                              },
                            )
                          : const SizedBox.shrink(),
                      ),

                      //Complete Icon
                      Expanded(
                        flex: 1,
                        child: widget.workoutSession 
                          ? IconButton(
                              icon: Icon(
                                set.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                                color: set.isCompleted ? Colors.green : Colors.grey,
                              ),
                              onPressed: () => widget.onSetComplete?.call(setIndex),
                            )
                          : const SizedBox.shrink(),
                      ),
                      
                    ],
                  ),
                ),
              );
            }
          ), */

          SizedBox(height: 10.h),

          // ---- Add Set Button ----
          if (widget.isEditable)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.onAddSet,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Add Set"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 40, 37, 37),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
              ),
          )
        ],
      ),
      );
  }
}