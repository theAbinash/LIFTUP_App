import 'muscle_group.dart';

class MuscleMapper {
  static const Map<String, MuscleGroup> regions = {
    "chest": MuscleGroup.chest,
    "upper_chest": MuscleGroup.upperChest,

    "front_deltoid": MuscleGroup.frontDeltoid,
    "side_deltoid": MuscleGroup.lateralDeltoid,
    "rear_deltoid": MuscleGroup.rearDeltoid,

    "biceps": MuscleGroup.biceps,
    "triceps": MuscleGroup.triceps,
    "forearms": MuscleGroup.forearms,

    "abs": MuscleGroup.abs,
    "obliques": MuscleGroup.obliques,

    "traps": MuscleGroup.traps,
    "lats": MuscleGroup.lats,
    "rhomboids": MuscleGroup.rhomboids,
    "lower_back": MuscleGroup.lowerBack,

    "glutes": MuscleGroup.glutes,
    "quadriceps": MuscleGroup.quadriceps,
    "hamstrings": MuscleGroup.hamstrings,
    "calves": MuscleGroup.calves,
  };
}