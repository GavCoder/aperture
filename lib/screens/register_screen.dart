import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/providers/register_form_provider.dart';
import 'package:aperture/widgets/app_button.dart';
import 'package:aperture/widgets/blobs.dart';
import 'package:aperture/widgets/logo_section.dart';
import 'package:aperture/widgets/tab_buttons.dart';
import 'package:aperture/widgets/input_field.dart';
import 'package:aperture/widgets/password_strength_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterFormProvider>(
      create: (_) => RegisterFormProvider(),
      child: const _RegisterScreenView(),
    );
  }
}

class _RegisterScreenView extends StatefulWidget {
  const _RegisterScreenView();

  @override
  State<_RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<_RegisterScreenView> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  late final FocusNode usernameFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    usernameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();

    usernameController.addListener(_validateUsername);
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
    confirmPasswordController.addListener(_validateConfirmPassword);
  }

  @override
  void dispose() {
    usernameController.removeListener(_validateUsername);
    emailController.removeListener(_validateEmail);
    passwordController.removeListener(_validatePassword);
    confirmPasswordController.removeListener(_validateConfirmPassword);

    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _validateUsername() {
    context
        .read<RegisterFormProvider>()
        .validateUsername(usernameController.text);
  }

  void _validateEmail() {
    context.read<RegisterFormProvider>().validateEmail(emailController.text);
  }

  void _validatePassword() {
    context.read<RegisterFormProvider>().validateRegisterPassword(
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );
  }

  void _validateConfirmPassword() {
    context.read<RegisterFormProvider>().validateConfirmPassword(
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );
  }

  bool _validateAllFields() {
    return context.read<RegisterFormProvider>().validateAllRegisterFields(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<RegisterFormProvider>();

    return Scaffold(
      body: Stack(
        children: [
          const Blobs(
            blobPath: 'assets/blobs/blob3.svg',
            topPosition: 200,
            leftPosition: -180,
            svgWidth: 700,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoSection(),
                      const SizedBox(height: 160),
                      const TabButtons(label: 'Register'),
                      const SizedBox(height: 30),
                      InputField(
                        controller: usernameController,
                        focusNode: usernameFocusNode,
                        hintText: 'Username',
                        prefixIcon: Icons.person,
                        errorText: registerProvider.usernameError,
                        maxLength: 30,
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        hintText: 'Email',
                        prefixIcon: Icons.email,
                        errorText: registerProvider.emailError,
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                        errorText: registerProvider.passwordError,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            context
                                .read<RegisterFormProvider>()
                                .togglePasswordVisibility();
                          },
                          child: Icon(
                            registerProvider.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      PasswordStrengthIndicator(
                        registerProvider: registerProvider,
                      ),
                      const SizedBox(height: 8),
                      InputField(
                        controller: confirmPasswordController,
                        focusNode: confirmPasswordFocusNode,
                        hintText: 'Confirm Password',
                        prefixIcon: Icons.lock,
                        errorText: registerProvider.confirmPasswordError,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            context
                                .read<RegisterFormProvider>()
                                .toggleConfirmPasswordVisibility();
                          },
                          child: Icon(
                            registerProvider.obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      AppButton(
                        btnText: const Text('Register'),
                        onPressed: () {
                          if (_validateAllFields()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration successful!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
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
