import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_entity.dart';
import 'package:liftup/feature/workout/domain/usecases/filter_exercise_usecase.dart';
import 'package:liftup/feature/workout/domain/usecases/get_exercise_usecase.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise/exercise_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise/exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {

  final GetExerciseUsecase getExercises;
  final FilterExerciseUsecase filterExercises;

  List<ExerciseEntity> _allExercises = [];

  ExerciseBloc(this.getExercises, this.filterExercises) : super(ExerciseInitial()) {
    on<LoadExercises>(_onLoadExercises);
    on<RefreshExercise>(_onRefreshExercise);
    on<FilterExercises>(_onFilterExercises);
    on<ToggleSelection>(_onToggleSelection);
  }

  Future<void> _onLoadExercises(
    LoadExercises event, Emitter<ExerciseState> emit) async {
      emit(ExerciseLoading());
      try {
        _allExercises = await getExercises();
        emit(ExerciseLoaded(exercises: _allExercises, selectedIds: {}));
      } catch (e) {
        emit(ExerciseError("Exercise fetch failed: ${e.toString()}"));
      }
    }

  Future<void> _onRefreshExercise(
    RefreshExercise event, Emitter<ExerciseState> emit) async {
      emit(ExerciseLoading());
      try {
        _allExercises = await getExercises(forceRefresh: true);
        emit(ExerciseLoaded(exercises: _allExercises, selectedIds: {}));
      } catch (e) {
        emit(ExerciseError("Exercise Refresh failed: ${e.toString()}"));
      }
    }

  void _onFilterExercises(
    FilterExercises event, Emitter<ExerciseState> emit) async {
      emit(ExerciseLoading());
      try {
        final filtered = filterExercises(
          _allExercises, 
          searchQuery: event.searchQuery,
          equipments: event.equipments,
          muscles: event.muscles,
          );
        emit(ExerciseLoaded(exercises: filtered, selectedIds: state.selectedIds,));
      } catch (e) {
        emit(ExerciseError(e.toString()));
      }
    }

  void _onToggleSelection(
    ToggleSelection event, Emitter<ExerciseState> emit) {
      final current = Set<int>.from(state.selectedIds);
      if (current.contains(event.exerciseId)) {
        current.remove(event.exerciseId);
      } else {
        current.add(event.exerciseId);
      }

      emit(ExerciseLoaded(
        exercises: state.exercises,
        selectedIds: current,
      ));
    }

}