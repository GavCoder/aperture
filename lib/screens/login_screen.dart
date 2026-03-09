import 'package:aperture/providers/login_form_provider.dart';
import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/widgets/app_button.dart';
import 'package:aperture/widgets/blobs.dart';
import 'package:aperture/widgets/forgot_password_button.dart';
import 'package:aperture/widgets/logo_section.dart';
import 'package:aperture/widgets/tab_buttons.dart';
import 'package:aperture/widgets/input_field.dart';
import 'package:aperture/widgets/social_login_button.dart';
import 'package:aperture/widgets/toggle_password_visibility.dart';
import 'package:flutter/material.dart';
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
    context.read<LoginFormProvider>().validateLoginPassword(passwordController.text);
  }

  void _onLoginPressed() {
    final loginProvider = context.read<LoginFormProvider>();
    final isValid = loginProvider.validateAllLoginFields(
      email: emailController.text,
      password: passwordController.text,
    );

    if (isValid) {
      Navigator.pushNamed(context, AppRouter.feedRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginFormProvider>();

    return Scaffold(
      body: Stack(
        children: [
          const Blobs(
            blobPath: 'assets/blobs/blob3.svg',
            topPosition: 250,
            leftPosition: -180,
            svgWidth: 700,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height, // Find best responsiveness practices for this
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoSection(),
                      const SizedBox(height: 160),
                      const TabButtons(label: 'Login'),
                      const SizedBox(height: 30),
                      InputField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        hintText: 'Email',
                        prefixIcon: Icons.email,
                        errorText: loginProvider.emailError,
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                        errorText: loginProvider.passwordError,
                        obscureText: loginProvider.obscurePassword,
                        suffixIcon: TogglePasswordVisibility(loginProvider: loginProvider),
                      ),
                      const ForgotPasswordButton(),
                      const SizedBox(height: 16),
                      AppButton(
                        btnText: 'Login',
                        onPressed: _onLoginPressed,
                      ),
                      const SizedBox(height: 30),
                      SocialLoginButton(
                        label: 'Sign in with Google',
                        assetPath: 'assets/images/google_logo.png',
                        onPressed: () {
                          // TODO: Implement Google sign in
                        },
                      ),
                      const SizedBox(height: 12),
                      SocialLoginButton(
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
          ),
        ],
      ),
    );
  }
}


