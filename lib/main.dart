import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/errors/error_cubit.dart';
import 'package:liftup/core/session/session_manager.dart';
import 'package:liftup/core/theme/app_theme.dart';
import 'package:liftup/core/utils/constants.dart';
import 'package:liftup/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:liftup/feature/home/presentation/pages/home_layout_page.dart';
import 'package:liftup/feature/auth/presentation/pages/landing_page.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise/exercise_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_bloc.dart';
import 'package:liftup/feature/workout/presentation/bloc/routine_detail_bloc.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'injection_container.dart' as di;

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  if(Constants.restDB){
    await deleteDatabase(join(await getDatabasesPath(), "liftup_app.db"));
    await SessionManager.logout();
  }
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ErrorCubit>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<ExerciseBloc>()),
        BlocProvider(create: (_) => di.sl<RoutineBloc>()),
        BlocProvider(create: (_) => di.sl<RoutineDetailBloc>(),)
      ], 
      child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (cpntext, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          //supportedLocales: AppLocalizations.supportedLocales,
          //localizationsDelegates: AppLocalizations.localizationsDelegates,
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const SplashScreen(),
        );
      },
    )
      );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    //await Future.delayed(const Duration(seconds: 1));
    int? userId = await SessionManager.getUserId();
    if (!mounted) return;

    if(userId != null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeLayoutPage()),
      );
    }else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LandingPage()),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, color: Theme.of(context).colorScheme.onSurface, size: 80),
            SizedBox(height: 20.h),
            Text(
              "LFTUP",
              style: Theme.of(context).textTheme.headlineMedium
            ),
            SizedBox(height: 30.h),
              CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,),
          ],
        ),
      ),
    );
  }
  
}

