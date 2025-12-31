class RoutineSetEntity {
  int? setId;
  int? setRoutineDetailId;
  int setCount;
  double? setWeight;
  int? setRepsCount;
  int? setDistance;
  int? setDuration;
  bool isCompleted;

  RoutineSetEntity({
    this.setId, this.setRoutineDetailId,
    required this.setCount, this.setWeight,
    this.setRepsCount, this.setDistance, this.setDuration,
    this.isCompleted = false,
  });

}