import 'package:aperture/utils/validations.dart';
import 'package:flutter/foundation.dart';

class LoginFormProvider extends ChangeNotifier {
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  bool get obscurePassword => _obscurePassword;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  void validateEmail(String email) {
    final nextEmailError = ValidationService.validateEmail(email);
    if (_emailError == nextEmailError) {
      return;
    }

    _emailError = nextEmailError;
    notifyListeners();
  }

  void validateLoginPassword(String password) {
    final nextPasswordError = ValidationService.validatePassword(password);
    if (_passwordError == nextPasswordError) {
      return;
    }

    _passwordError = nextPasswordError;
    notifyListeners();
  }

  bool validateAllLoginFields({
    required String email,
    required String password,
  }) {
    final nextEmailError = ValidationService.validateEmail(email);
    final nextPasswordError = ValidationService.validatePassword(password);
    final hasChanged =
        _emailError != nextEmailError || _passwordError != nextPasswordError;

    _emailError = nextEmailError;
    _passwordError = nextPasswordError;

    if (hasChanged) {
      notifyListeners();
    }

    return nextEmailError == null && nextPasswordError == null;
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }
}
