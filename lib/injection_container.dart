import 'package:get_it/get_it.dart';
import 'package:liftup/core/database/db_helper.dart';
import 'package:liftup/core/errors/error_cubit.dart';
import 'package:liftup/core/utils/constants.dart';
import 'package:liftup/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:liftup/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:liftup/feature/auth/domain/repositories/auth_repository.dart';
import 'package:liftup/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:liftup/feature/workout/data/datasources/exercise_local_data_source.dart';
import 'package:liftup/feature/workout/data/datasources/exercise_remote_data_source.dart';
import 'package:liftup/feature/workout/data/repositories/exercise_repository_impl.dart';
import 'package:liftup/feature/workout/domain/repositories/exercise_repository.dart';
import 'package:liftup/feature/workout/domain/usecases/filter_exercise_usecase.dart';
import 'package:liftup/feature/workout/domain/usecases/get_exercise_usecase.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  // Core
  sl.registerLazySingleton<DBHelper>(() => DBHelper());

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  
  // Data sources - local
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(dbHelper: sl(), prefs: sl()),
  );
  sl.registerLazySingleton<ExerciseLocalDataSource>(
    () => ExerciseLocalDataSourceImpl(dbHelper: sl()));

  // Data source - remote
  sl.registerLazySingleton<ExerciseRemoteDataSource>(
    () => ExerciseRemoteDataSourceImpl(
      client: sl(), 
      baseUrl: Constants.baseUrl,
      ));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ExerciseRepository>(
    () => ExerciseRepositoryImpl(
      localDataSource: sl(), 
      remoteDataSource: sl())
  );

  //Cubits / Blocs
   sl.registerLazySingleton<ErrorCubit>(() => ErrorCubit());
   sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
   sl.registerFactory<ExerciseBloc>(() => ExerciseBloc(sl(), sl()));

   //usecases
   sl.registerLazySingleton(() => GetExerciseUsecase(sl()));
   sl.registerLazySingleton(() => FilterExerciseUsecase());

   // External
  sl.registerLazySingleton(() => http.Client());

}

