class ExerciseEntity {

  final int exerciseId;
  final String exerciseName;
  final String exerciseImageUrl;
  final List<String> exerciseEquipments;
  final List<String> exerciseBodyParts;
  final int? exerciseMeasurementFlag; 

  const ExerciseEntity({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseImageUrl,
    required this.exerciseEquipments,
    required this.exerciseBodyParts,
    this.exerciseMeasurementFlag
  });
}