import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/providers/login_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TogglePasswordVisibility extends StatelessWidget {
  const TogglePasswordVisibility({
    super.key,
    required this.loginProvider,
  });

  final LoginFormProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<LoginFormProvider>()
            .togglePasswordVisibility();
      },
      child: Icon(
        loginProvider.obscurePassword
            ? Icons.visibility_off
            : Icons.visibility,
        color: AppColors.hintTextColor,
      ),
    );
  }
}