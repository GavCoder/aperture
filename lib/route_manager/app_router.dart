import 'package:aperture/screens/feed_screen.dart';
import 'package:aperture/screens/login_screen.dart';
import 'package:aperture/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  // Class to manage app routes

  static const String feedRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case feedRoute:
        return MaterialPageRoute(builder: (_) => const FeedScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }
  }
}
