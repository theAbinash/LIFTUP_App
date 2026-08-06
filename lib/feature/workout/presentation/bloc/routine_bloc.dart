import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/repositories/routine_repository.dart';
import 'package:liftup/feature/workout/domain/usecases/get_routine_detail_usecase.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {

  final RoutineRepository repository;
  final GetRoutineDetailUsecase routineDetail;
  List<RoutineEntity> _routineList = [];
  
  RoutineBloc(this.repository, this.routineDetail): super(RoutineInitial()){
    on<LoadRoutine>(_onLoadRoutine);
    on<RefreshRoutine>(_onRefreshRoutine);
    on<SaveRoutine>(_onSaveRoutine);
    on<LoadRoutineDetail>(_onLoadRoutineDetail);
    on<SaveWorkoutData>(_onSaveWorkoutData);
    on<UpdateRoutine>(_onUpdateRoutine);
  }

  void _onLoadRoutine(LoadRoutine event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());

    try{
      _routineList = await repository.getRoutineList();
      emit(RoutineLoaded(routineList: _routineList));
    }catch (e){
      emit(RoutineError("Routine Fetch Failed ${e.toString()}"));
    }
  }

  void _onRefreshRoutine(RefreshRoutine event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());

    try{
      _routineList = await repository.getRoutineList(forceRefresh: true);
    emit(RoutineLoaded(routineList: _routineList));
    }catch (e){
      emit(RoutineError("Routine Refresh Failed ${e.toString()}"));
    }
  }

  void _onSaveRoutine(SaveRoutine event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());

    try{
      //save DB
      await repository.saveRoutine(event.routine);

      //reload routines
      _routineList = await repository.getRoutineList();
      emit(RoutineLoaded(routineList: _routineList));

    }catch (e){
      emit(RoutineError("Routine Save Failed ${e.toString()}"));
    }

  }

  void _onLoadRoutineDetail(LoadRoutineDetail event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());

    try {
      //final routine = await repository.getRoutineDetail(event.routineId);
      final routine = await routineDetail(event.routineId);
      emit(RoutineDetailLoaded(routine));
       
    } catch (e) {
      emit(RoutineError("Routine Detail Load Failed ${e.toString()}"));
    }
  }

  void _onSaveWorkoutData(SaveWorkoutData event, Emitter<RoutineState> emit) async {
    emit(RoutineLoading());

    try {
      await repository.saveWorkout(event.session);
      emit(SaveWorkoutSuccess(event.session));
    } catch (e) {
      emit(RoutineError("Routine user data save Failed ${e.toString()}"));
    }
  }

  void _onUpdateRoutine(UpdateRoutine event, Emitter<RoutineState> emit) async {
  emit(RoutineLoading());

  try {
    await repository.updateRoutine(event.routine);

    _routineList = await repository.getRoutineList();
    emit(RoutineLoaded(routineList: _routineList));
  } catch (e) {
    emit(RoutineError("Routine Update Failed ${e.toString()}"));
  }
}

}