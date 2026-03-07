import 'package:aperture/miscellaneous/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String btnText;
  final Function onPressed;

  const AppButton({
    super.key,
    required this.btnText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }
}