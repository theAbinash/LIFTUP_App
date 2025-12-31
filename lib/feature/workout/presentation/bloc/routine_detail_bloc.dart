import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liftup/feature/workout/domain/repositories/routine_repository.dart';
import 'package:liftup/feature/workout/domain/usecases/get_routine_detail_usecase.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_state.dart';

class RoutineDetailBloc extends Bloc<RoutineDetailEvent, RoutineDetailState> {
  final RoutineRepository repository;
  GetRoutineDetailUsecase _getRoutineDetailUsecase;

  RoutineDetailBloc(this.repository, this._getRoutineDetailUsecase) : super(RoutineDetailInitial()) {
    on<LoadRoutineDetail>(_onLoadRoutineDetail);
  }

  Future<void> _onLoadRoutineDetail(
      LoadRoutineDetail event, Emitter<RoutineDetailState> emit) async {
    emit(RoutineDetailLoading());
    try {
      final routine = await _getRoutineDetailUsecase(event.routineId);
      if (routine != null) {
        emit(RoutineDetailLoaded(routine: routine, isEditing: false));
      } else {
        emit(RoutineDetailError("Routine not found"));
      }
    } catch (e) {
      emit(RoutineDetailError("Failed to load routine: $e"));
    }
  }
  
}