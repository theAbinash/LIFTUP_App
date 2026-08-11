
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/theme/theme_extensions.dart';
import 'package:liftup/core/widgets/app_confirm_dialog.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/presentation/pages/exercise_page.dart';
import 'package:liftup/core/utils/constants.dart';
import 'package:liftup/core/utils/validators.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/data/models/routine_model.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_event.dart';
import 'package:liftup/feature/workout/presentation/pages/reorder_exercises_page.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/editable_exercise_body.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_card.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_popup_menu.dart';

class CreateRoutinePage extends StatefulWidget {
  final RoutineEntity? existingRoutine;
  const CreateRoutinePage({super.key, this.existingRoutine});

  @override
  State<StatefulWidget> createState() => _CreateRoutinePage();
}

class _CreateRoutinePage extends State<CreateRoutinePage> {

  String routineTitle = "";
  final _routineTitleController = TextEditingController();
  List<RoutineExerciseEntity> selectedWorkouts = [];
  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;

  bool get isEditMode => widget.existingRoutine != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingRoutine;
    if (existing != null) {
      routineTitle = existing.routineName;
      _routineTitleController.text = existing.routineName;
      
      selectedWorkouts = (existing.workoutList ?? [])
          .map((w) => RoutineExerciseEntity(
                workoutId: w.workoutId,
                exerciseId: w.exerciseId,
                exerciseName: w.exerciseName,
                exerciseImageUrl: w.exerciseImageUrl,
                routineID: w.routineID,
                routineName: w.routineName,
                exerciseSeqNo: w.exerciseSeqNo,
                exerciseType: w.exerciseType,
                exerciseNote: w.exerciseNote,
                exerciseRestTime: w.exerciseRestTime,
                exerciseBodyParts: w.exerciseBodyParts,
                exerciseEquipments: w.exerciseEquipments,
                setValueList: List.of(w.setValueList),
              ))
          .toList();
    }
  }

  @override
  void dispose() {
    _routineTitleController.dispose();
    super.dispose();
  }

  void _markChanged() {
    if (!_hasChanges) setState(() => _hasChanges = true);
  }

  void _removeExercise(int index) {
    setState(() => selectedWorkouts.removeAt(index));
  }

  Future<void> _handleCancel() async {
    if (!_hasChanges) {
      Navigator.pop(context);
      return;
    }

    final discard = await AppConfirmDialog.show(
      context,
      title: "Are you sure you want to discard all changes?",
      confirmText: "Discard Changes",
    );

    if (discard && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _handleCancel();
      },
      child: AppScaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Edit Routine" : "Create Routine"),
        centerTitle: true,
        leading: TextButton(
          onPressed: _handleCancel,
          child: const Text("Cancel"),
        ),
        leadingWidth: 80,
        actions: [
          SizedBox(
            height: 40,
            width: 80,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final routine = RoutineModel(
                    routineId: widget.existingRoutine?.routineId ?? 0,
                    routineName: routineTitle,
                    routineCreatedPersonId: 1,
                    routineScope: Constants.exerciseScopePublic,
                    routineCreatedDate:
                        widget.existingRoutine?.routineCreatedDate ?? DateTime.now(),
                    workoutList: selectedWorkouts,
                  );
                
                if (isEditMode) {
                    context.read<RoutineBloc>().add(UpdateRoutine(routine));
                  } else {
                    context.read<RoutineBloc>().add(SaveRoutine(routine));
                  }
                Navigator.pop(context);
              }
            },
            child: Text(isEditMode ? "Update" : "Save"),
          ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextFormField(
                controller: _routineTitleController,
                style: context.text.bodyLarge,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: context.app.border,),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: context.colors.primary, width: 2),
                  ),
                  hintText: "Routine title",
                  hintStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: context.app.textSecondary,
                  ),
                  
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 22, 
                  ),
                ),
                onChanged: (value) {
                  setState(() => routineTitle = value);
                  _markChanged();
                },
                validator: Validators.validateNotEmpty,
              ),

            SizedBox(height: 30.h),

            if (selectedWorkouts.isEmpty) ...[
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/dumbbell_icon.png",
                      width: 48,
                      color:  context.app.textSecondary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "No exercises added yet",
                      style: context.text.bodyMedium?.copyWith(
                          color: context.app.textSecondary,
                        ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: selectedWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = selectedWorkouts[index];
                    return ExerciseCard(
                      exercise: workout,
                      onExpand: () {},
                      trailing: ExercisePopupMenu(

                          onRemove: () => _removeExercise(index),

                          onReplace: () async {
                            final result = await Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => ExercisePage(
                                  isReplaceMode: true,
                                  excludeExerciseId: workout.exerciseId,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );

                            if (result != null && result is ExerciseEntity) {
                              setState(() {
                                selectedWorkouts[index] = RoutineExerciseEntity(
                                  exerciseId: result.exerciseId,
                                  exerciseName: result.exerciseName,
                                  exerciseImageUrl: result.exerciseImageUrl,
                                  exerciseType: result.exerciseType,
                                  exerciseNote: workout.exerciseNote,
                                  setValueList: workout.setValueList,
                                );
                              });
                              _markChanged();
                            }
                          },
                          onReorder: () async {
                            final result = await Navigator.push<List<RoutineExerciseEntity>>(
                              context,
                              MaterialPageRoute(builder: (_) => ReorderExercisesPage(exercises: selectedWorkouts)),
                            );

                            if (result != null) {
                              setState(() => selectedWorkouts = result);
                               _markChanged();
                            }
                          },
                          onAddToSuperset: () {
                            // TODO: superset grouping
                          },
                        ),
                      child: EditableExerciseBody(
                        exercise: workout,
                        onNotesChanged: (value) {
                          workout.exerciseNote = value;
                          _markChanged();
                        },

                        onRestTimerChanged: (enabled, seconds) {
                          setState(() {
                            workout.restTimerEnabled = enabled;
                            workout.exerciseRestTime = seconds;
                          });
                          _markChanged();
                        },

                        onAddSet: () {
                        setState(() {
                          workout.setValueList.add(RoutineSetEntity(
                            setCount: workout.setValueList.length + 1,
                            setWeight: 0,
                            setRepsCount: 0,
                            ));
                          });
                          _markChanged();
                        },
                        /* onDeleteSet: (setIndex) {
                        setState(() {
                          workout.setValueList.removeAt(setIndex);
                            for (int i = 0; i < workout.setValueList.length; i++) {
                              workout.setValueList[i].setCount = i + 1;
                            }
                          });
                          _markChanged();
                        }, */

                      ),
                      );
                  },
                ),
              ),
            ],

          SizedBox(height: 20.h),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const ExercisePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                      )
                  );

                  if (result != null && result is List<ExerciseEntity>) {
                    setState(() {
                      selectedWorkouts.addAll(
                        result.map((ex) => RoutineExerciseEntity(
                          exerciseId: ex.exerciseId, 
                          exerciseName: ex.exerciseName, 
                          exerciseImageUrl: ex.exerciseImageUrl,
                          exerciseType: ex.exerciseType,
                          setValueList: [RoutineSetEntity(setCount: 1, setWeight: 0, setRepsCount: 0)],
                          )),
                      );
                    });
                    _markChanged();
                  }
                },
                icon: Icon(Icons.add, color: context.colors.onPrimary,),
                label: Text("Add Exercise"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          )

          ],
        ),
        )
        )
    ),
  );
  }
}

