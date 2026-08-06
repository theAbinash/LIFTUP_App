import 'package:equatable/equatable.dart';

class WorkoutSessionState extends Equatable {
  final Duration elapsedDuration;

  final bool isRunning;

  const WorkoutSessionState({
    required this.elapsedDuration,
    required this.isRunning,
  });

  factory WorkoutSessionState.initial({
    Duration initialDuration = Duration.zero,
  }) {
    return WorkoutSessionState(
      elapsedDuration: initialDuration,
      isRunning: true,
    );
  }

  WorkoutSessionState copyWith({
    Duration? elapsedDuration,
    bool? isRunning,
  }) {
    return WorkoutSessionState(
      elapsedDuration: elapsedDuration ?? this.elapsedDuration,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = elapsedDuration.inHours;
    final minutes = twoDigits(elapsedDuration.inMinutes.remainder(60));
    final seconds = twoDigits(elapsedDuration.inSeconds.remainder(60));

    if (hours > 0) {
      return "$hours hr $minutes min";
    }

    if (elapsedDuration.inMinutes > 0) {
      return "$minutes min $seconds s";
    }

    return "$seconds s";
  }


  @override
  List<Object?> get props => [
        elapsedDuration,
        isRunning,
      ];
}