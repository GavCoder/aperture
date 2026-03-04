import 'package:aperture/screens/feed_screen.dart';
import 'package:aperture/screens/login_screen.dart';
import 'package:aperture/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AppRouter { // Class to manage app routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const FeedScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
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
