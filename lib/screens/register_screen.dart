import 'package:aperture/miscellaneous/colors.dart';
import 'package:aperture/services/validations.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late FocusNode usernameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  // Password strength state
  double passwordStrength = 0.0;
  Map<String, bool> passwordRequirements = {};
  String passwordSuggestion = '';

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

    // Add listeners for real-time validation
    usernameController.addListener(_validateUsername);
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
    confirmPasswordController.addListener(_validateConfirmPassword);
  }

  @override
  void dispose() {
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

  /// Validates username in real-time
  void _validateUsername() {
    setState(() {
      usernameError = ValidationService.validateUsername(usernameController.text);
    });
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
      passwordError = ValidationService.validatePassword(passwordController.text);
      // Update strength indicator and suggestions
      _updatePasswordStrength(passwordController.text);
      // Re-validate confirm password when password changes
      _validateConfirmPassword();
    });
  }

  /// Updates the password strength and suggestion text
  void _updatePasswordStrength(String password) {
    final reqs = ValidationService.getPasswordRequirements(password);
    final total = reqs.length;
    final met = reqs.values.where((v) => v).length;
    passwordRequirements = reqs;
    passwordStrength = total == 0 ? 0.0 : met / total;

    if (passwordStrength >= 1.0) {
      passwordSuggestion = 'Excellent — strong password';
    } else if (passwordStrength >= 0.66) {
      passwordSuggestion = 'Good — add one more requirement to be stronger';
    } else if (passwordStrength >= 0.33) {
      passwordSuggestion = 'Weak — try adding uppercase, lowercase, or a special character';
    } else {
      passwordSuggestion = 'Very weak — use at least 12 chars and include !@#\$% and mixed case';
    }
  }

  /// Validates confirm password in real-time
  void _validateConfirmPassword() {
    setState(() {
      confirmPasswordError = ValidationService.validatePasswordMatch(
        passwordController.text,
        confirmPasswordController.text,
      );
    });
  }

  /// Validates all fields and returns true if all are valid
  bool _validateAllFields() {
    final String usernameErrorMsg =
        ValidationService.validateUsername(usernameController.text) ?? '';
    final String emailErrorMsg =
        ValidationService.validateEmail(emailController.text) ?? '';
    final String passwordErrorMsg =
        ValidationService.validatePassword(passwordController.text) ?? '';
    final String confirmPasswordErrorMsg =
        ValidationService.validatePasswordMatch(
              passwordController.text,
              confirmPasswordController.text,
            ) ??
            '';

    setState(() {
      usernameError = usernameErrorMsg.isNotEmpty ? usernameErrorMsg : null;
      emailError = emailErrorMsg.isNotEmpty ? emailErrorMsg : null;
      passwordError = passwordErrorMsg.isNotEmpty ? passwordErrorMsg : null;
      confirmPasswordError =
          confirmPasswordErrorMsg.isNotEmpty ? confirmPasswordErrorMsg : null;
    });

    return usernameErrorMsg.isEmpty &&
        emailErrorMsg.isEmpty &&
        passwordErrorMsg.isEmpty &&
        confirmPasswordErrorMsg.isEmpty;
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
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Login',
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
          // Register Tab
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.tabBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
                ? Colors.red.withOpacity(0.1)
                : AppColors.inputFillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red.withOpacity(0.5)
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

  /// Builds the primary register button
  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_validateAllFields()) {
            // TODO: Implement register functionality
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

  /// Password strength indicator widget
  Widget _buildPasswordStrengthIndicator() {
    Color strengthColor;
    if (passwordStrength <= 0.33) {
      strengthColor = Colors.red;
    } else if (passwordStrength <= 0.66) {
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
              value: passwordStrength,
              minHeight: 8,
              backgroundColor: AppColors.whiteWithOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            passwordSuggestion,
            style: TextStyle(
              color: AppColors.whiteWithOpacity(0.9),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          // Show missing requirements as small bullets
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: passwordRequirements.entries.map((e) {
              final met = e.value;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: met
                      ? AppColors.whiteWithOpacity(0.12)
                      : Colors.red.withOpacity(0.12),
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
                      e.key,
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

                  // Username Input Field
                  _buildInputField(
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                    hintText: 'Username',
                    prefixIcon: Icons.person,
                    errorText: usernameError,
                    maxLength: 30,
                  ),
                  const SizedBox(height: 16),

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
                  const SizedBox(height: 8),
                  // Password strength indicator
                  _buildPasswordStrengthIndicator(),
                  const SizedBox(height: 8),

                  // Confirm Password Input Field
                  _buildInputField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    obscureText: obscureConfirmPassword,
                    errorText: confirmPasswordError,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                      child: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.hintTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Register Button
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
