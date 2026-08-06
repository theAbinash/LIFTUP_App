import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:liftup/feature/workout/presentation/bloc/workout_session/workout_session_state.dart';

class WorkoutSessionBloc
    extends Bloc<WorkoutSessionEvent, WorkoutSessionState> {

  Timer? _timer;

  WorkoutSessionBloc({
    Duration initialDuration = Duration.zero,
  }) : super(
    WorkoutSessionState.initial(
      initialDuration: initialDuration,
    )
    ) {
    on<WorkoutStarted>(_onStarted);
    on<WorkoutTicked>(_onTicked);
    on<WorkoutPaused>(_onPaused);
    on<WorkoutResumed>(_onResumed);
  }

  void _onStarted(
    WorkoutStarted event,
    Emitter<WorkoutSessionState> emit,
  ) {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        add(const WorkoutTicked());
      },
    );
  }

  void _onTicked(
    WorkoutTicked event,
    Emitter<WorkoutSessionState> emit,
  ) {
    if (!state.isRunning) return;

    emit(
      state.copyWith(
        elapsedDuration:
            state.elapsedDuration + const Duration(seconds: 1),
      ),
    );
  }

  void _onPaused(
    WorkoutPaused event,
    Emitter<WorkoutSessionState> emit,
  ) {
    emit(
      state.copyWith(
        isRunning: false,
      ),
    );
  }

  void _onResumed(
    WorkoutResumed event,
    Emitter<WorkoutSessionState> emit,
  ) {
    emit(
      state.copyWith(
        isRunning: true,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}