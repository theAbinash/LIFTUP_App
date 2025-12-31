import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liftup/feature/home/presentation/widgets/home_widget.dart' show HomeWidget;
import 'package:liftup/feature/profile/presentation/pages/profile_page.dart';
import 'package:liftup/feature/workout/presentation/pages/workout_page.dart' show WorkoutWidget;
import 'package:liftup/core/debug/dev_tools_page.dart';

class HomeLayoutPage extends StatefulWidget {
  const HomeLayoutPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _HomeLayoutPage();
}

class _HomeLayoutPage extends State<HomeLayoutPage> {

  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeWidget(),
    WorkoutWidget(),
    ProfilePage(),
  ];

  /* Future<User?> getLoggedInUser() async {
    int? userId = await SessionManager.getUserId();
    if (userId != null) {
      return user = await UserDao().getUserById(userId);
    }
    return null;
  } */

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _pages[_currentIndex],
      // debug button
      floatingActionButton: kDebugMode
        ? FloatingActionButton(
            heroTag: 'debugBtn',
            backgroundColor: Colors.amber,
            child: const Icon(Icons.bug_report),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DevToolsPage()),
              );
            },
          )
        : null,

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ), 
        child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
        backgroundColor: const Color.fromARGB(255, 40, 37, 37),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/dumbbell_icon.png",
              width: 24,
              color: Colors.grey,
            ),
            label: "Workout",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ]
      ),
        )
      
    );
  }
  
}