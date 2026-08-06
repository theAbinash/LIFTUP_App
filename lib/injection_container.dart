import 'package:get_it/get_it.dart';
import 'package:liftup/core/database/db_helper.dart';
import 'package:liftup/core/errors/error_cubit.dart';
import 'package:liftup/core/utils/constants.dart';
import 'package:liftup/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:liftup/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:liftup/feature/auth/domain/repositories/auth_repository.dart';
import 'package:liftup/feature/auth/domain/usecases/login_usercase.dart';
import 'package:liftup/feature/auth/domain/usecases/register_usecase.dart';
import 'package:liftup/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:liftup/feature/workout/data/datasources/local/exercise_local_data_source.dart';
import 'package:liftup/feature/workout/data/datasources/local/routine_local_data_source.dart';
import 'package:liftup/feature/workout/data/datasources/remote/exercise_remote_data_source.dart';
import 'package:liftup/feature/workout/data/repositories/exercise_repository_impl.dart';
import 'package:liftup/feature/workout/data/repositories/routine_repository_impl.dart';
import 'package:liftup/feature/workout/domain/repositories/exercise_repository.dart';
import 'package:liftup/feature/workout/domain/repositories/routine_repository.dart';
import 'package:liftup/feature/workout/domain/usecases/filter_exercise_usecase.dart';
import 'package:liftup/feature/workout/domain/usecases/get_exercise_usecase.dart';
import 'package:liftup/feature/workout/domain/usecases/get_routine_detail_usecase.dart';
import 'package:liftup/feature/workout/domain/usecases/get_routine_usecase.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise/exercise_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_bloc.dart';
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
    () => ExerciseLocalDataSourceImpl(dbHelper: sl())
  );
  sl.registerLazySingleton<RoutineLocalDataSource>(
    () => RoutineLocalDataSourceImpl(dbHelper: sl())
  );

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
  sl.registerLazySingleton<RoutineRepository>(
    () => RoutineRepositoryImpl(
      localDataSource: sl(),
      )
  );

  //Cubits / Blocs
   sl.registerLazySingleton<ErrorCubit>(() => ErrorCubit());
   sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
   sl.registerFactory<ExerciseBloc>(() => ExerciseBloc(sl(), sl()));
   sl.registerFactory<RoutineBloc>(() => RoutineBloc(sl(), sl()));
   sl.registerFactory<RoutineDetailBloc>(() => RoutineDetailBloc(sl(),sl()));

   //usecases
   sl.registerLazySingleton(() => RegisterUseCase(sl()));
   sl.registerLazySingleton(() => LoginUsercase(sl()));
   sl.registerLazySingleton(() => GetExerciseUsecase(sl()));
   sl.registerLazySingleton(() => FilterExerciseUsecase());
   sl.registerLazySingleton(() => GetRoutineUsecase(sl()));
   sl.registerLazySingleton(() => GetRoutineDetailUsecase(sl()));

   // External
  sl.registerLazySingleton(() => http.Client());

}

