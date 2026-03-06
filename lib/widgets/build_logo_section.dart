 import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

 /// Builds the aperture logo and branding section
  Widget buildLogoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Logo.png',
          height: 50,
          width: 50,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.camera_alt,
              color: AppColors.textWhite,
              size: 40,
            );
          },
        ),
        const SizedBox(width: 12),
        const Text(
          'Aperture',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
      ],
    );
  }