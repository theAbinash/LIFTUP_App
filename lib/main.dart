import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/errors/error_cubit.dart';
import 'package:liftup/core/session/session_manager.dart';
import 'package:liftup/core/theme/app_theme.dart';
import 'package:liftup/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:liftup/feature/home/presentation/pages/home_layout_page.dart';
import 'package:liftup/feature/auth/presentation/pages/landing_page.dart';
import 'package:liftup/feature/workout/presentation/bloc/exercise_bloc.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'injection_container.dart' as di;

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await deleteDatabase(join(await getDatabasesPath(), "app_database.db"));
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
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const SplashScreen(),
          /* theme: ThemeData(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              foregroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white
              ),
              backgroundColor: Color.fromARGB(255, 40, 37, 37),
            ),
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.blue,
          ), */
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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fitness_center, color: Colors.white, size: 80),
            SizedBox(height: 20.h),
            Text(
              "LFTUP",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
  
}

