import 'package:aperture/utils/colors.dart';
import 'package:flutter/material.dart';

class AppButton2 extends StatelessWidget {
  final Widget btnTitle;
  final VoidCallback
      onPressed; // Callback function for button press (Changed from type Function to VoidCallback for better type safety, because VoidCallback is a typedef for a function that takes no arguments and returns void, which is more specific than Function)

  const AppButton2({
    super.key,
    required this.btnTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.uploadButtonBackgroundColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            offset: const Offset(1, 4),
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.uploadButtonBorderColor(),
        ),
      ),
      child: btnTitle,
    );
  }
}