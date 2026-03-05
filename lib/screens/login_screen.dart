import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/screens/feed_screen.dart';
import 'package:aperture/services/validations.dart';
import 'package:flutter/material.dart';

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
  bool _validateAllFields() {
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

  /// Builds the gradient background container
  Widget _buildGradientBackground(Widget child) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.appGradient,
        ),
      ),
      child: child,
    );
  }

  /// Builds the aperture logo and branding section
  Widget _buildLogoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.logoPurple, AppColors.logoBlue],
            ),
          ),
          child: Icon(
            Icons.lens_blur,
            color: AppColors.whiteWithOpacity(0.8),
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'aperture',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
      ],
    );
  }

  /// Builds the login/register tab buttons
  Widget _buildTabButtons() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.tabBackgroundInactiveColor,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // Login Tab
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.tabBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          // Register Tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.registerRoute);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Color(0xFFB3B3B3),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an input field widget with error display
  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData prefixIcon,
    required String? errorText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
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

  /// Builds the forgot password text button
  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password functionality
        },
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

  /// Builds the primary login button
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_validateAllFields()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const FeedScreen(),
              ),
            ); // Navigate to feed screen on successful login

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login successful!'),
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
          'Login',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
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
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 20,
              width: 20,
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
      body: _buildGradientBackground(
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Section
                  _buildLogoSection(),
                  const SizedBox(height: 40),

                  // Tab Buttons
                  _buildTabButtons(),
                  const SizedBox(height: 30),

                  // Email Input Field
                  _buildInputField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    errorText: emailError,
                  ),
                  const SizedBox(height: 16),

                  // Password Input Field
                  _buildInputField(
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
                  const SizedBox(height: 12),

                  // Forgot Password Button
                  _buildForgotPasswordButton(),
                  const SizedBox(height: 16),

                  // Login Button
                  _buildLoginButton(),
                  const SizedBox(height: 24),

                  // Google Sign In Button
                  _buildSocialSignInButton(
                    label: 'Sign in with Google',
                    assetPath: 'assets/google_logo.png',
                    onPressed: () {
                      // TODO: Implement Google sign in
                    },
                  ),
                  const SizedBox(height: 12),

                  // Facebook Sign In Button
                  _buildSocialSignInButton(
                    label: 'Sign in with Facebook',
                    assetPath: 'assets/facebook_logo.png',
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
    );
  }
}
