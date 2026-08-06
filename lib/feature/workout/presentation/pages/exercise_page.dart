
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/theme/theme_extensions.dart';
import 'package:liftup/core/widgets/app_scaffold.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise/exercise_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise/exercise_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise/exercise_state.dart';

class ExercisePage extends StatefulWidget {
  final bool isReplaceMode;
  final int? excludeExerciseId;

  const ExercisePage({
    super.key,
    this.isReplaceMode = false,
    this.excludeExerciseId,
    });

  @override
  State<ExercisePage> createState() => _ExercisePage();
}

class _ExercisePage extends State<ExercisePage> {

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<String> selectedEquipments = [];
  List<String> selectedMuscles = [];

  final List<String> allEquipments = ["Dumbbell", "Barbell", "Kettlebell", "Body Weight", "Resistance Band"];
  final List<String> allMuscles = ["Chest", "Back", "Legs", "Shoulders", "Arms", "Core", "Waist"];

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _searchFocusNode.requestFocus();
        }
      });
    }); 
    context.read<ExerciseBloc>().add(LoadExercises());
  }

  void _showFiltersheet({required int type}){
    //List<String> items = type == 1 ? allEquipments : allMuscles;
    //List<String> selectedList = type == 1 ? selectedEquipments : selectedMuscles;

     showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: context.app.textSecondary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 15.h,),
              Text(
                type == 1 ? "Equipment" : "Muscles Group", 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 13.h,),

              Divider(
                color: context.app.border,
              ),
              
              
            ],
          ),
        );
      }
      );
  }

  void _finishSelection(Set<int> selectedIds, List<ExerciseEntity> exercise) {
    final selectedNames = exercise
        .where((ex) => selectedIds.contains(ex.exerciseId))
        .toList();

    Navigator.pop(context, selectedNames);
  }
  
  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.isReplaceMode ? "Replace Exercise" : "Add Exercise"),
      ),

      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if(state is ExerciseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExerciseLoaded) {

             if(state.exercises.isEmpty){
              return RefreshIndicator( 
                onRefresh: () async {
                  context.read<ExerciseBloc>().add(RefreshExercise());
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
            } 

            final exercises = state.exercises;
            final selectedIds = state.selectedIds;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ExerciseBloc>().add(RefreshExercise());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    autofocus: true,  
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, size: 20, color: context.app.textSecondary,),
                      hintStyle: TextStyle(color: context.app.textSecondary,),
                      hintText: "Search exercise...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.r),
                        borderSide: BorderSide(color: context.app.textSecondary,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.r),
                        borderSide: BorderSide(color: context.app.textSecondary,),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    ),
                    onChanged: (value) {
                      context.read<ExerciseBloc>().add(
                        FilterExercises(
                          searchQuery: value,
                          equipments: selectedEquipments,
                          muscles: selectedMuscles
                        )
                      );
                    }, 
                  ),
                  ), 

                SizedBox(height: 5.h,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 155.w,
                        child: ElevatedButton(
                          onPressed: () => _showFiltersheet(type: 1), 
                          child: Text(
                            "All Equipment"
                          )),
                      ),
                      SizedBox(
                        width: 155.w,
                        child: ElevatedButton(
                          onPressed: () => _showFiltersheet(type: 2), 
                          child: Text(
                            "All Muscles"
                          )),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 10.h,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    "All Exercises",
                    style: TextStyle(
                      color: context.app.textSecondary
                    ),
                  ),
                ),
              
              SizedBox(height: 10.h,),

              Expanded(
                child: ListView.separated(
                  itemCount: exercises.length,
                  separatorBuilder: (context, index) => Divider(color: context.app.border,),

                  itemBuilder: (context, index) {
                    final ex = exercises[index];
                    final isSelected = selectedIds.contains(ex.exerciseId);

                    return GestureDetector(
                      onTap: () {
                        if (widget.isReplaceMode) {
                          Navigator.pop(context, ex);
                          return;
                        }
                        setState(() {
                          if(isSelected) {
                            selectedIds.remove(ex.exerciseId);
                          }else {
                            selectedIds.add(ex.exerciseId);
                          }
                        });
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? context.colors.primary : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),

                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(ex.exerciseImageUrl),
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            onBackgroundImageError: (_, __) {},
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ex.exerciseName,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                (ex.exerciseBodyParts).join(", "),
                                style: TextStyle(
                                  color: context.app.textSecondary,
                                  fontSize: 11.sp
                                ),
                              ),
                            ],
                          ) 
                    ),
                  ),
                );
              }, 
            )
            ),
          ],
        ),
        );

          } else if (state is ExerciseError) {
            return Center(child: Text(state.message),);
          }

          return SizedBox();

        }
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.isReplaceMode 
          ? null
          : BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state){
          return AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              offset: state.selectedIds.isNotEmpty ? Offset.zero : const Offset(0, 2),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: state.selectedIds.isNotEmpty ? 1 : 0,
                child: (state is ExerciseLoaded && state.selectedIds.isNotEmpty) 
                    ? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              _finishSelection(state.selectedIds, state.exercises);
                            }, 
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              minimumSize: const Size(double.infinity, 40),
                            ),
                            child: Text(
                                "Add ${state.selectedIds.length} Exercise(s)",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                        ),
                        )
                      ) : const SizedBox.shrink()
              )
            );
        },
      )
    );
  }
  
}