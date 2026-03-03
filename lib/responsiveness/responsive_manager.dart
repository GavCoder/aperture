import 'package:aperture/miscellaneous/screen_sizes.dart';
import 'package:aperture/screens/login_screen.dart';
import 'package:aperture/screens/register_screen.dart';
import 'package:flutter/material.dart';

/// Responsiveness manager that handles screen routing based on device type
class ResponsiveManager {
  // Private constructor to prevent instantiation
  ResponsiveManager._();

  /// Routes to appropriate screen based on device type and screen
  ///
  /// This widget automatically detects device type and renders the correct
  /// version of a screen (mobile, tablet, or desktop)
  static Widget routeScreen({
    required BuildContext context,
    required String screenName,
  }) {
    final deviceType = ScreenSizes.getDeviceTypeFromContext(context);

    switch (screenName) {
      case 'login':
        return _buildLoginScreen(context, deviceType);
      case 'register':
        return _buildRegisterScreen(context, deviceType);
      default:
        return Scaffold(
          body: Center(
            child: Text('Screen "$screenName" not found'),
          ),
        );
    }
  }

  /// Builds login screen with responsive layout
  static Widget _buildLoginScreen(BuildContext context, DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return const LoginScreen();
      case DeviceType.tablet:
        // TODO: Create tablet version of login screen
        return const LoginScreen(); // Fallback to mobile for now
      case DeviceType.desktop:
        // TODO: Create desktop version of login screen
        return const LoginScreen(); // Fallback to mobile for now
    }
  }

  /// Builds register screen with responsive layout
  static Widget _buildRegisterScreen(
      BuildContext context, DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
       return const RegisterScreen();
      case DeviceType.tablet:
        // TODO: Create tablet version of register screen
        return const Scaffold(
          body: Center(child: Text('Register Screen - Tablet')),
        );
      case DeviceType.desktop:
        // TODO: Create desktop version of register screen
        return const Scaffold(
          body: Center(child: Text('Register Screen - Desktop')),
        );
    }
  }

  /// Wraps a widget with responsive padding
  static Widget responsivePadding({
    required BuildContext context,
    required Widget child,
  }) {
    final padding = ScreenSizes.getPadding(context);
    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }

  /// Wraps a widget with responsive properties
  static Widget responsive({
    required BuildContext context,
    required Widget mobileWidget,
    required Widget tabletWidget,
    required Widget desktopWidget,
  }) {
    final deviceType = ScreenSizes.getDeviceTypeFromContext(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return mobileWidget;
      case DeviceType.tablet:
        return tabletWidget;
      case DeviceType.desktop:
        return desktopWidget;
    }
  }

  /// Build responsive container with size constraints
  static SizedBox responsiveContainer({
    required BuildContext context,
    required Widget child,
    required double mobileHeight,
    required double tabletHeight,
    required double desktopHeight,
  }) {
    final height = ScreenSizes.getResponsiveWidth(
      context,
      mobileWidth: mobileHeight,
      tabletWidth: tabletHeight,
      desktopWidth: desktopHeight,
    );

    return SizedBox(
      height: height,
      child: child,
    );
  }
}
