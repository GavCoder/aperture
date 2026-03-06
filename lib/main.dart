import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/screens/feed_screen.dart';
import 'package:aperture/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //TODO: Add ThemeData to the app, and make it look nice
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // onGenerateRoute: AppRouter.generateRoute,
      home: ProfileScreen(),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Hello, Gavin'),
//       ),
//     );
//   }
// }
