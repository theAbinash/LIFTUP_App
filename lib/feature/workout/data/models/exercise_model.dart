import 'dart:convert';

import 'package:liftup/core/utils/logger.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  final int exerciseId;
  final String exerciseName;
  final String exerciseImageUrl;
  final List<String> exerciseEquipments;
  final List<String> exerciseBodyParts;
  final int? exerciseMeasurementFlag;
  final int exerciseType;

  ExerciseModel({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseImageUrl,
    required this.exerciseEquipments,
    required this.exerciseBodyParts,
    required this.exerciseType,
    this.exerciseMeasurementFlag
  }) : super(
    exerciseId: exerciseId, 
    exerciseName: exerciseName, 
    exerciseImageUrl: exerciseImageUrl, 
    exerciseEquipments: exerciseEquipments, 
    exerciseBodyParts: exerciseBodyParts,
    exerciseType: exerciseType
    );

  Map<String, dynamic> toMap() {
    return {
      'exercise_id': exerciseId,
      'exercise_name': exerciseName,
      'exercise_image_url': exerciseImageUrl,
      'exercise_equipments': jsonEncode(exerciseEquipments),
      'exercise_primary_muscle': jsonEncode(exerciseBodyParts),
      'exercise_measurement_flag': exerciseMeasurementFlag,
      'exercise_etm_id': exerciseType
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    AppLogger.log("DB row: $map");
    return ExerciseModel(
      exerciseId: map['exercise_id'] ?? 0,
      exerciseName: map['exercise_name'] ?? '',
      exerciseImageUrl: map['exercise_image_url'] ?? '',
      exerciseEquipments: map['exercise_equipments'] != null
          ? List<String>.from(jsonDecode(map['exercise_equipments']))
          : [],
      exerciseBodyParts: map['exercise_primary_muscle'] != null
          ? List<String>.from(jsonDecode(map['exercise_primary_muscle']))
          : [],
      exerciseMeasurementFlag: map['exercise_measurement_flag'] ?? 0,
      exerciseType: map['exercise_etm_id'] ?? 0,
    );
  }

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      exerciseId: json['exercise_id'] ?? 0,
      exerciseName: json['exercise_name'] ?? 'Unknown',
      exerciseImageUrl: json['exercise_image_url'] ?? '',
      exerciseEquipments: (json['exercise_equipments'] as List?)?.map((e) => e.toString()).toList() ?? [],
      exerciseBodyParts: (json['exercise_primary_muscle'] as List?)?.map((e) => e.toString()).toList() ?? [],
      exerciseMeasurementFlag: json['exercise_measurement_flag'] ?? 0,
      exerciseType: json['exercise_type_id'] ?? 0,
    );
  }
}
