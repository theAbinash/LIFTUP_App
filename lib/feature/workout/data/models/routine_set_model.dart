import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';

class RoutineSetModel extends RoutineSetEntity {
  int? setId;
  int? setRoutineDetailId;
  int setCount;
  double? setWeight;
  int? setRepsCount;
  int? setDistance;
  int? setDuration;

  RoutineSetModel({
    this.setId,
    this.setRoutineDetailId,
    required this.setCount,
    this.setWeight,
    this.setRepsCount,
    this.setDistance, this.setDuration
  }) : super (
    setId: setId, setRoutineDetailId: setRoutineDetailId,
    setCount: setCount, setWeight: setWeight, setRepsCount: setRepsCount,
    setDistance: setDistance, setDuration: setDuration
    );

  Map<String, dynamic> toMap() {
    final map = {
      'rs_id': setId,
      'rs_rd_id': setRoutineDetailId,
      'rs_set': setCount,
      'rs_weight': setWeight,
      'rs_reps': setRepsCount,
      'rs_distance': setDistance,
      'rs_duration': setDuration,
    };

    if(setId != 0){
      map['rs_id'] = setId;
    }

    return map;
  }

  factory RoutineSetModel.fromMap(Map<String, dynamic> map) {
    return RoutineSetModel(
      setId: map['rs_id'] ?? 0,
      setRoutineDetailId: map['rs_rd_id'] ?? 0,
      setCount: map['rs_set'] ?? 0,
      setWeight: map['rs_weight'] ?? 0,
      setRepsCount: map['rs_reps'] ?? 0, 
      setDistance: map['rs_distance'] ?? 0, 
      setDuration: map['rs_duration'] ?? 0, 
      );
  }
}