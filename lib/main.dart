import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/providers/login_form_provider.dart';
import 'package:aperture/providers/register_form_provider.dart';
import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/providers/user_level_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //TODO: Add ThemeData to the app, and make it look nice
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserLevelProvider>(
          create: (_) => UserLevelProvider(),
        ),
        ChangeNotifierProvider<LoginFormProvider>(
          create: (_) => LoginFormProvider(),
        ),
        ChangeNotifierProvider<RegisterFormProvider>(
          create: (_) => RegisterFormProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          fontFamily: 'Poppins',
        ),
        initialRoute: '/login',
        onGenerateRoute: AppRouter.generateRoute,
      ),
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
