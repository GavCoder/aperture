import 'package:aperture/screens/add_post_screen.dart';
import 'package:aperture/screens/feed_screen.dart';
import 'package:aperture/screens/forgot_password_screen.dart';
import 'package:aperture/screens/login_screen.dart';
import 'package:aperture/screens/profile_screen.dart';
import 'package:aperture/screens/register_screen.dart';
import 'package:aperture/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  // Class to manage app routes

  static const String loginRoute = '/';
  static const String feedRoute = '/feed';
  static const String registerRoute = '/register';
  static const String profileRoute = '/profile';
  static const String addPost = '/addPost';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String resetPasswordRoute = '/resetPassword';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {    
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case feedRoute:
        return MaterialPageRoute(builder: (_) => const FeedScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case addPost: //change to add post route (for consistency)
        return MaterialPageRoute(builder: (_) => const AddPostScreen());
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }
  }
}
