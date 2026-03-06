import 'dart:ui';

import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/screens/feed_screen.dart';
import 'package:aperture/services/validations.dart';
import 'package:aperture/widgets/build_background.dart';
import 'package:aperture/widgets/build_forgot_button.dart';
import 'package:aperture/widgets/build_input_field.dart';
import 'package:aperture/widgets/build_logo_section.dart';
import 'package:aperture/widgets/build_tab_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  bool obscurePassword = true;

  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    // Add listeners for real-time validation
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  /// Validates email in real-time
  void _validateEmail() {
    setState(() {
      emailError = ValidationService.validateEmail(emailController.text);
    });
  }

  /// Validates password in real-time
  void _validatePassword() {
    setState(() {
      passwordError =
          ValidationService.validatePassword(passwordController.text);
    });
  }

  /// Validates all fields and returns true if all are valid
  bool validateAllFields() {
    final String emailErrorMsg =
        ValidationService.validateEmail(emailController.text) ?? '';
    final String passwordErrorMsg =
        ValidationService.validatePassword(passwordController.text) ?? '';

    setState(() {
      emailError = emailErrorMsg.isNotEmpty ? emailErrorMsg : null;
      passwordError = passwordErrorMsg.isNotEmpty ? passwordErrorMsg : null;
    });

    return emailErrorMsg.isEmpty && passwordErrorMsg.isEmpty;
  }

  

 

 

 



 

  /// Builds a social sign-in button (Google or Facebook)
  Widget _buildSocialSignInButton({
    required String label,
    required String assetPath,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textWhite,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 25,
              width: 25,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  label.contains('Google')
                      ? Icons.g_mobiledata
                      : Icons.facebook,
                  color: AppColors.textDarkGrey,
                  size: 20,
                );
              },
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDarkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildGradientBackground(
        Stack(
          children: [
            Positioned(
            top: 200,
            left: -180,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
              ),
              child: SvgPicture.asset(
                'assets/blobs/blob3.svg',
                width: 700,
              ),
            ),
          ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Section
                      buildLogoSection(),
                      const SizedBox(height: 160),

                      // Tab Buttons
                      buildTabButtons(context),
                      const SizedBox(height: 30),

                      // Email Input Field
                      buildInputField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        hintText: 'Email',
                        prefixIcon: Icons.email,
                        errorText: emailError,
                      ),
                      const SizedBox(height: 16),

                      // Password Input Field
                      buildInputField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                        obscureText: obscurePassword,
                        errorText: passwordError,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                      ),

                      // Forgot Password Button
                      buildForgotPasswordButton(),
                      const SizedBox(height: 16),

                      // Login Button
                      _buildLoginButton(),
                      const SizedBox(height: 30),

                      // Google Sign In Button
                      _buildSocialSignInButton(
                        label: 'Sign in with Google',
                        assetPath: 'assets/images/google_logo.png',
                        onPressed: () {
                          // TODO: Implement Google sign in
                        },
                      ),
                      const SizedBox(height: 12),

                      // Facebook Sign In Button
                      _buildSocialSignInButton(
                        label: 'Sign in with Facebook',
                        assetPath: 'assets/images/facebook_logo.png',
                        onPressed: () {
                          // TODO: Implement Facebook sign in
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
