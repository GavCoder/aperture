import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

/// Builds the gradient background container
  Widget buildGradientBackground(Widget child) {
    return Container(
      color: AppColors.scaffoldBackground,
      child: child,
    );
  }