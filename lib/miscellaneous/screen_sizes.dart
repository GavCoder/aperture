import 'package:flutter/material.dart';

/// Enum defining different device types
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Screen size breakpoints and utility class
class ScreenSizes {
  // Private constructor to prevent instantiation
  ScreenSizes._();

  // ============== MOBILE SCREEN SIZES ==============
  /// Mobile small devices (phones up to 480px)
  static const double mobileSmallWidth = 320;
  static const double mobileSmallHeight = 568;

  /// Mobile standard devices (phones 481-599px)
  static const double mobileWidth = 375;
  static const double mobileHeight = 667;

  /// Mobile large devices (phones 600-799px)
  static const double mobileLargeWidth = 414;
  static const double mobileLargeHeight = 896;

  // ============== TABLET SCREEN SIZES ==============
  /// Tablet portrait (800-1199px width)
  static const double tabletPortraitWidth = 800;
  static const double tabletPortraitHeight = 1024;

  /// Tablet landscape (1200px+ width)
  static const double tabletLandscapeWidth = 1200;
  static const double tabletLandscapeHeight = 800;

  // ============== DESKTOP SCREEN SIZES ==============
  /// Desktop small (1200-1439px)
  static const double desktopSmallWidth = 1200;
  static const double desktopSmallHeight = 800;

  /// Desktop standard (1440-1919px)
  static const double desktopWidth = 1440;
  static const double desktopHeight = 900;

  /// Desktop large (1920px+)
  static const double desktopLargeWidth = 1920;
  static const double desktopLargeHeight = 1080;

  // ============== BREAKPOINTS ==============
  /// Mobile breakpoint (max width for mobile devices)
  static const double mobileBreakpoint = 599;

  /// Tablet breakpoint (max width for tablet devices)
  static const double tabletBreakpoint = 1199;

  /// Desktop breakpoint (min width for desktop devices)
  static const double desktopBreakpoint = 1200;

  // ============== PADDING & MARGINS ==============
  /// Mobile default padding
  static const double mobilePadding = 16;

  /// Tablet default padding
  static const double tabletPadding = 24;

  /// Desktop default padding
  static const double desktopPadding = 32;

  /// Determines device type based on screen width
  static DeviceType getDeviceType(double width) {
    if (width <= mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width <= tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Determines device type from BuildContext using mediaQuery
  static DeviceType getDeviceTypeFromContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getDeviceType(width);
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= mobileBreakpoint;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > mobileBreakpoint && width <= tabletBreakpoint;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > tabletBreakpoint;
  }

  /// Check if device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get screen width from BuildContext
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height from BuildContext
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get appropriate padding based on device type
  static double getPadding(BuildContext context) {
    final deviceType = getDeviceTypeFromContext(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return mobilePadding;
      case DeviceType.tablet:
        return tabletPadding;
      case DeviceType.desktop:
        return desktopPadding;
    }
  }

  /// Get responsive width based on device type
  static double getResponsiveWidth(
    BuildContext context, {
    required double mobileWidth,
    required double tabletWidth,
    required double desktopWidth,
  }) {
    final deviceType = getDeviceTypeFromContext(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return mobileWidth;
      case DeviceType.tablet:
        return tabletWidth;
      case DeviceType.desktop:
        return desktopWidth;
    }
  }

  /// Get responsive font size based on device type
  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobileSize,
    required double tabletSize,
    required double desktopSize,
  }) {
    final deviceType = getDeviceTypeFromContext(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return mobileSize;
      case DeviceType.tablet:
        return tabletSize;
      case DeviceType.desktop:
        return desktopSize;
    }
  }
}
