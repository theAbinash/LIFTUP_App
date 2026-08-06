enum ExerciseColumnType {
  set,
  previous,
  weight,
  reps,
  distance,
  duration,
  completed,
}

class ExerciseColumnConfig {
  final ExerciseColumnType type;
  //final int flex;
  final double width;

  const ExerciseColumnConfig({
    required this.type,
    //required this.flex,
    required this.width
  });
}

class ExerciseTableLayout {
  final List<ExerciseColumnConfig> columns;

  const ExerciseTableLayout({
    required this.columns,
  });

  static const double _setW = 40;
  static const double _valueW = 90;
  static const double _previousW = 90;
  static const double _iconW = 40;

  //ROUTINE MODE

  static const routineReps = ExerciseTableLayout( // type 1
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.reps, width: _valueW),
    ],
  );

  static const routineWeightReps = ExerciseTableLayout( // type 2
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.weight, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.reps, width: _valueW),
    ],
  );

  static const routineWeightDuration = ExerciseTableLayout( // type 3
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.weight, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.duration, width: _valueW),
    ],
  );

  static const routineDuration = ExerciseTableLayout( // type 4
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.duration, width: _valueW),
    ],
  );

  static const routineDistance = ExerciseTableLayout( // type 5
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.distance, width: _valueW),
    ],
  );

  static const routineDistanceWeight = ExerciseTableLayout( // type 6
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.weight, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.distance, width: _valueW),
    ],
  );

  //SESSION MODE

  static const sessionReps = ExerciseTableLayout( // type 1
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.previous, width: _previousW),
      ExerciseColumnConfig(type: ExerciseColumnType.reps, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.completed, width: _iconW),
    ],
  );

  static const sessionWeightReps = ExerciseTableLayout( // type 2
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.previous, width: _previousW),
      ExerciseColumnConfig(type: ExerciseColumnType.weight, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.reps, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.completed, width: _iconW),
    ],
  );

  static const sessionWeightDuration = ExerciseTableLayout( // type 3
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.previous, width: _previousW),
      ExerciseColumnConfig(type: ExerciseColumnType.weight, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.duration, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.completed, width: _iconW),
    ],
  );

  static const sessionDuration = ExerciseTableLayout( // type 4
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.previous, width: _previousW),
      ExerciseColumnConfig(type: ExerciseColumnType.duration, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.completed, width: _iconW),
    ],
  );

  static const sessionDistance = ExerciseTableLayout( // type 5
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.previous, width: _previousW),
      ExerciseColumnConfig(type: ExerciseColumnType.distance, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.completed, width: _iconW),
    ],
  );

  static const sessionDistanceWeight = ExerciseTableLayout( // type 6
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.previous, width: _previousW),
      ExerciseColumnConfig(type: ExerciseColumnType.weight, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.distance, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.completed, width: _iconW),
    ],
  );

  static const editableStrength = ExerciseTableLayout(
    columns: [
      ExerciseColumnConfig(type: ExerciseColumnType.set, width: _setW),
      ExerciseColumnConfig(type: ExerciseColumnType.weight, width: _valueW),
      ExerciseColumnConfig(type: ExerciseColumnType.reps, width: _valueW),
    ],
  );

  //Single resolver used by both screens

  static ExerciseTableLayout forExerciseType(int exerciseType, {required bool session}) {
    switch (exerciseType) {
      case 1: 
        return session ? sessionReps : routineReps;
      case 2: 
        return session ? sessionWeightReps : routineWeightReps;
      case 3: 
        return session ? sessionWeightDuration : routineWeightDuration;
      case 4: 
        return session ? sessionDuration : routineDuration;
      case 5: 
        return session ? sessionDistance : routineDistance;
      case 6: 
        return session ? sessionDistanceWeight : routineDistanceWeight;
      default:
        return session ? sessionWeightReps : routineWeightReps;
    }
  }

}