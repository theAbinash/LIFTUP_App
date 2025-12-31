class RoutineSetEntity {
  int? setId;
  int? setRoutineDetailId;
  int setCount;
  double? setWeight;
  double? prevSetWeight;
  int? setRepsCount;
  int? prevRepsCount;
  int? setDistance;
  int? prevSetDistance;
  int? setDuration;
  int? prevSetDuration;
  bool isCompleted;

  RoutineSetEntity({
    this.setId, this.setRoutineDetailId,
    required this.setCount, this.setWeight,
    this.setRepsCount, this.setDistance, this.setDuration,
    this.prevRepsCount,this.prevSetDistance, this.prevSetDuration,
    this.prevSetWeight ,this.isCompleted = false,
  });

}