import 'dart:ui';

import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/providers/login_form_provider.dart';
import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/widgets/build_background.dart';
import 'package:aperture/widgets/build_forgot_button.dart';
import 'package:aperture/widgets/build_input_field.dart';
import 'package:aperture/widgets/build_login_button.dart';
import 'package:aperture/widgets/build_logo_section.dart';
import 'package:aperture/widgets/build_tab_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginFormProvider>(
      create: (_) => LoginFormProvider(),
      child: const _LoginScreenView(),
    );
  }
}

class _LoginScreenView extends StatefulWidget {
  const _LoginScreenView();

  @override
  State<_LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<_LoginScreenView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    emailController.removeListener(_validateEmail);
    passwordController.removeListener(_validatePassword);
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateEmail() {
    context.read<LoginFormProvider>().validateEmail(emailController.text);
  }

  void _validatePassword() {
    context.read<LoginFormProvider>().validatePassword(passwordController.text);
  }

  void _onLoginPressed() {
    final loginProvider = context.read<LoginFormProvider>();
    final isValid = loginProvider.validateAllFields(
      email: emailController.text,
      password: passwordController.text,
    );

    if (isValid) {
      Navigator.pushNamed(context, AppRouter.feedRoute);
    }
  }

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
    final loginProvider = context.watch<LoginFormProvider>();

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
                      buildLogoSection(),
                      const SizedBox(height: 160),
                      buildTabButtons(context),
                      const SizedBox(height: 30),
                      buildInputField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        hintText: 'Email',
                        prefixIcon: Icons.email,
                        errorText: loginProvider.emailError,
                      ),
                      const SizedBox(height: 16),
                      buildInputField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                        obscureText: loginProvider.obscurePassword,
                        errorText: loginProvider.passwordError,
                        suffixIcon: GestureDetector(
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
                        ),
                      ),
                      buildForgotPasswordButton(),
                      const SizedBox(height: 16),
                      buildLoginButton(
                        onPressed: _onLoginPressed,
                        btnText: 'Login',),
                      const SizedBox(height: 30),
                      _buildSocialSignInButton(
                        label: 'Sign in with Google',
                        assetPath: 'assets/images/google_logo.png',
                        onPressed: () {
                          // TODO: Implement Google sign in
                        },
                      ),
                      const SizedBox(height: 12),
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
