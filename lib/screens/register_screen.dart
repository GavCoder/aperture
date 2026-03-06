import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/providers/register_form_provider.dart';
import 'package:aperture/widgets/build_background.dart';
import 'package:aperture/widgets/build_logo_section.dart';
import 'package:aperture/widgets/build_tab_buttons.dart';
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
    context.read<RegisterFormProvider>().validatePassword(
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
    return context.read<RegisterFormProvider>().validateAllFields(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData prefixIcon,
    required String? errorText,
    bool obscureText = false,
    Widget? suffixIcon,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          maxLength: maxLength,
          style: const TextStyle(color: AppColors.textWhite),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.hintTextColor,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.hintTextColor,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: errorText != null
                ? Colors.red.withValues(alpha: 0.1)
                : AppColors.inputFillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red.withValues(alpha: 0.5)
                    : BorderSide.none.color,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
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
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: AppColors.inputBorderColor,
            ),
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator(RegisterFormProvider registerProvider) {
    Color strengthColor;
    if (registerProvider.passwordStrength <= 0.33) {
      strengthColor = Colors.red;
    } else if (registerProvider.passwordStrength <= 0.66) {
      strengthColor = Colors.orange;
    } else {
      strengthColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: registerProvider.passwordStrength,
              minHeight: 8,
              backgroundColor: AppColors.whiteWithOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            registerProvider.passwordSuggestion,
            style: TextStyle(
              color: AppColors.whiteWithOpacity(0.9),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: registerProvider.passwordRequirements.entries.map((entry) {
              final met = entry.value;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: met
                      ? AppColors.whiteWithOpacity(0.12)
                      : Colors.red.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      met ? Icons.check_circle : Icons.radio_button_unchecked,
                      size: 14,
                      color: met ? Colors.greenAccent : Colors.redAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      entry.key,
                      style: TextStyle(
                        color: AppColors.whiteWithOpacity(0.9),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<RegisterFormProvider>();

    return Scaffold(
      body: buildGradientBackground(
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLogoSection(),
                  const SizedBox(height: 40),
                  buildTabButtons(context),
                  const SizedBox(height: 30),
                  _buildInputField(
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                    hintText: 'Username',
                    prefixIcon: Icons.person,
                    errorText: registerProvider.usernameError,
                    maxLength: 30,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    errorText: registerProvider.emailError,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: registerProvider.obscurePassword,
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
                  _buildPasswordStrengthIndicator(registerProvider),
                  const SizedBox(height: 8),
                  _buildInputField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    obscureText: registerProvider.obscureConfirmPassword,
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
                  _buildRegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
