 import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

/// Builds the primary login button
  Widget buildLoginButton({required Function onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed(),
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: AppColors.buttonBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: AppColors.inputBorderColor,
            ),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }