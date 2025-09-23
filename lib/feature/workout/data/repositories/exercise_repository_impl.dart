import 'package:gym_log/feature/workout/data/datasources/exercise_local_data_source.dart';
import 'package:gym_log/feature/workout/data/datasources/exercise_remote_data_source.dart';
import 'package:gym_log/feature/workout/domain/entities/exercise_entity.dart';
import 'package:gym_log/feature/workout/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {

  final ExerciseLocalDataSource localDataSource;
  final ExerciseRemoteDataSource remoteDataSource;

  ExerciseRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<ExerciseEntity>> getExerciseList({bool forceRefresh = false}) async {

    if(forceRefresh){ //fetch data from remote
      final remoteData = await remoteDataSource.getExerciseList();
      await localDataSource.clearExercises();
      await localDataSource.saveExerciseList(remoteData);
      return remoteData;
    }

    // try local first
    final localData = await localDataSource.getExerciseList(); 
    if(localData.isNotEmpty){
      return localData;
    }

    // fallback to fetch remote if local empty
    final remoteData = await remoteDataSource.getExerciseList();
    await localDataSource.saveExerciseList(remoteData);
    return remoteData;
    
  }

}