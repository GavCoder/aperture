import 'package:aperture/utils/colors.dart';
import 'package:flutter/material.dart';

class AppButton1 extends StatelessWidget {
  final String btnText;
  final VoidCallback
      onPressed; // Callback function for button press (Changed from type Function to VoidCallback for better type safety, because VoidCallback is a typedef for a function that takes no arguments and returns void, which is more specific than Function)

  const AppButton1({
    super.key,
    required this.btnText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: AppColors.loginButtonBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: AppColors.loginButtonBorderColor(),
            ),
          ),
        ),
        child: Text(
          btnText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}


// Previous app button code for reference:
// child: ElevatedButton(
      //   onPressed: onPressed,
      //   style: ElevatedButton.styleFrom(
      //     elevation: 8,
      //     backgroundColor: btnColor ?? AppColors.buttonBackgroundColor,
      //     padding: const EdgeInsets.symmetric(vertical: 16),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(30),
      //       side: BorderSide(
      //         color: AppColors.inputBorderColor,
      //       ),
      //     ),
      //   ),
      //   child: btnText,
      // ),