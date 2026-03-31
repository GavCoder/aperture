import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/utils/colors.dart';
import 'package:flutter/material.dart';

/// Builds the forgot password text button
class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, AppRouter.forgotPasswordRoute), //TODO: implement forgot password funtionality
        child: const Text(
          'Forgot password',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}