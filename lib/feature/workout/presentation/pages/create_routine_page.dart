
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/pages/exercise_page.dart';
import 'package:liftup/core/utils/constants.dart';
import 'package:liftup/core/utils/validators.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/data/models/routine_model.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_event.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_card.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateRoutinePage();
}

class _CreateRoutinePage extends State<CreateRoutinePage> {

  String routineTitle = "";
  final _routineTitleController = TextEditingController();
  List<RoutineExerciseEntity> selectedWorkouts = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      appBar: AppBar(
        title: const Text("Create Routine"),
        actions: [
          SizedBox(
            height: 40,
            width: 80,
            child: ElevatedButton.icon(
              onPressed: () async {
                if(_formKey.currentState!.validate()){

                  final routine = RoutineModel(
                    routineId: 0, 
                    routineName: routineTitle,
                    routineCreatedPersonId: 1,
                    routineScope: Constants.exerciseScopePublic,
                    routineCreatedDate: DateTime.now(),
                    workoutList: selectedWorkouts,
                  );

                  context.read<RoutineBloc>().add(SaveRoutine(routine));

                  Navigator.pop(context);
                }
              } , 
              label: const Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // default line color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // when focused
                  ),
                  hintText: "Routine title",
                  hintStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 22, 
                  ),
                ),
                onChanged: (value) {
                  setState(() => routineTitle = value);
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
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "No exercises added yet",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
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
                      isEditable: true,
                      onAddSet: () {
                        setState(() {
                          workout.setValueList.add(RoutineSetEntity(
                            setCount: workout.setValueList.length + 1,
                            setWeight: 0,
                            setRepsCount: 0,
                          ));
                        });
                      },

                      onDeleteSet: (setIndex) {
                        setState(() {
                          workout.setValueList.removeAt(setIndex);
                          for (int i = 0; i < workout.setValueList.length; i++) {
                            workout.setValueList[i].setCount = i + 1;
                          }
                        });
                      },
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
                          setValueList: [RoutineSetEntity(setCount: 1, setWeight: 0, setRepsCount: 0)],
                          )),
                      );
                    });
                  }
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Add Exercise"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
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
    );
  }
}

