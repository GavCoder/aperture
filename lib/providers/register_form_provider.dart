import 'package:aperture/services/validations.dart';
import 'package:flutter/foundation.dart';

class RegisterFormProvider extends ChangeNotifier {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  double _passwordStrength = 0.0;
  Map<String, bool> _passwordRequirements = const {};
  String _passwordSuggestion = '';

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  String? get usernameError => _usernameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;

  double get passwordStrength => _passwordStrength;
  Map<String, bool> get passwordRequirements =>
      Map<String, bool>.unmodifiable(_passwordRequirements);
  String get passwordSuggestion => _passwordSuggestion;

  void validateUsername(String username) {
    final nextUsernameError = ValidationService.validateUsername(username);
    if (_usernameError == nextUsernameError) {
      return;
    }

    _usernameError = nextUsernameError;
    notifyListeners();
  }

  void validateEmail(String email) {
    final nextEmailError = ValidationService.validateEmail(email);
    if (_emailError == nextEmailError) {
      return;
    }

    _emailError = nextEmailError;
    notifyListeners();
  }

  void validatePassword({
    required String password,
    required String confirmPassword,
  }) {
    final nextPasswordError = ValidationService.validatePassword(password);
    final nextConfirmPasswordError = ValidationService.validatePasswordMatch(
      password,
      confirmPassword,
    );

    final nextRequirements = ValidationService.getPasswordRequirements(password);
    final totalRequirements = nextRequirements.length;
    final metRequirements = nextRequirements.values.where((value) => value).length;
    final nextStrength =
        totalRequirements == 0 ? 0.0 : metRequirements / totalRequirements;
    final nextSuggestion = _buildPasswordSuggestion(nextStrength);

    final hasChanged = _passwordError != nextPasswordError ||
        _confirmPasswordError != nextConfirmPasswordError ||
        !mapEquals(_passwordRequirements, nextRequirements) ||
        _passwordStrength != nextStrength ||
        _passwordSuggestion != nextSuggestion;

    _passwordError = nextPasswordError;
    _confirmPasswordError = nextConfirmPasswordError;
    _passwordRequirements = nextRequirements;
    _passwordStrength = nextStrength;
    _passwordSuggestion = nextSuggestion;

    if (hasChanged) {
      notifyListeners();
    }
  }

  void validateConfirmPassword({
    required String password,
    required String confirmPassword,
  }) {
    final nextConfirmPasswordError = ValidationService.validatePasswordMatch(
      password,
      confirmPassword,
    );
    if (_confirmPasswordError == nextConfirmPasswordError) {
      return;
    }

    _confirmPasswordError = nextConfirmPasswordError;
    notifyListeners();
  }

  bool validateAllFields({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    final nextUsernameError = ValidationService.validateUsername(username);
    final nextEmailError = ValidationService.validateEmail(email);
    final nextPasswordError = ValidationService.validatePassword(password);
    final nextConfirmPasswordError = ValidationService.validatePasswordMatch(
      password,
      confirmPassword,
    );

    final nextRequirements = ValidationService.getPasswordRequirements(password);
    final totalRequirements = nextRequirements.length;
    final metRequirements = nextRequirements.values.where((value) => value).length;
    final nextStrength =
        totalRequirements == 0 ? 0.0 : metRequirements / totalRequirements;
    final nextSuggestion = _buildPasswordSuggestion(nextStrength);

    final hasChanged = _usernameError != nextUsernameError ||
        _emailError != nextEmailError ||
        _passwordError != nextPasswordError ||
        _confirmPasswordError != nextConfirmPasswordError ||
        !mapEquals(_passwordRequirements, nextRequirements) ||
        _passwordStrength != nextStrength ||
        _passwordSuggestion != nextSuggestion;

    _usernameError = nextUsernameError;
    _emailError = nextEmailError;
    _passwordError = nextPasswordError;
    _confirmPasswordError = nextConfirmPasswordError;
    _passwordRequirements = nextRequirements;
    _passwordStrength = nextStrength;
    _passwordSuggestion = nextSuggestion;

    if (hasChanged) {
      notifyListeners();
    }

    return nextUsernameError == null &&
        nextEmailError == null &&
        nextPasswordError == null &&
        nextConfirmPasswordError == null;
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  String _buildPasswordSuggestion(double strength) {
    if (strength >= 1.0) {
      return 'Excellent - strong password';
    }

    if (strength >= 0.66) {
      return 'Good - add one more requirement to be stronger';
    }

    if (strength >= 0.33) {
      return 'Weak - try uppercase, lowercase, or a special character';
    }

    return 'Very weak - use at least 12 chars and include !@#\$% and mixed case';
  }
}
