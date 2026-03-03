/// Service class for validating user input across the application
class ValidationService {
  
  // Private constructor to prevent instantiation
  ValidationService._();

  // Regular expression patterns
  static const String _emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  // Username allows letters, numbers, dot, underscore and hyphen; length 3-30
  static const String _usernamePattern = r'^[a-zA-Z0-9._-]{3,30}$';

    // Password pattern: minimum 12 chars, at least 1 uppercase, 1 lowercase, 1 special char (!@#$%)
    // Ensures the entire string is validated using .{12,}$ so the regex matches the full password
    static const String _passwordPattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%]).{12,}$';

  static final RegExp _emailRegex = RegExp(_emailPattern);
  static final RegExp _usernameRegex = RegExp(_usernamePattern);
  static final RegExp _passwordRegex = RegExp(_passwordPattern);

  /// Validates email format
  ///
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    if (email.trim().isEmpty) {
      return 'Email cannot be empty';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates username format
  ///
  /// Username must be 3-20 characters long and contain only:
  /// - Letters (a-z, A-Z)
  /// - Numbers (0-9)
  /// - Underscores (_)
  /// - Hyphens (-)
  ///
  /// Returns null if valid, error message if invalid
  /// 
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }

    if (username.trim().isEmpty) {
      return 'Username cannot be empty';
    }

    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (username.length > 30) {
      return 'Username must be at most 30 characters';
    }

    if (!_usernameRegex.hasMatch(username)) {
      return 'Username can only contain letters, numbers, dots, underscores, and hyphens';
    }

    return null;
  }

  /// Validates password strength
  ///
  /// Password requirements:
  /// - Minimum 12 characters
  /// - At least 1 uppercase letter (A-Z)
  /// - At least 1 lowercase letter (a-z)
  /// - At least 1 special character (!@#$%)
  ///
  /// Returns null if valid, error message if invalid
  
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 12) {
      return 'Password must be at least 12 characters long';
    }

    // Check for uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least 1 uppercase letter';
    }

    // Check for lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least 1 lowercase letter';
    }

    // Check for special character (!@#$%)
    if (!password.contains(RegExp(r'[!@#$%]'))) {
      return 'Password must contain at least 1 special character (!@#\$%)';
    }

    if (!_passwordRegex.hasMatch(password)) {
      return 'Password does not meet all requirements';
    }

    return null;
  }

  /// Validates that two passwords match
  ///
  /// Returns null if passwords match, error message if they don't
  static String? validatePasswordMatch(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Gets all password validation requirements messages
  ///
  /// Returns a map of requirement keys and whether they are met
  static Map<String, bool> getPasswordRequirements(String password) {
    return {
      'At least 12 characters': password.length >= 12,
      'At least 1 uppercase letter': password.contains(RegExp(r'[A-Z]')),
      'At least 1 lowercase letter': password.contains(RegExp(r'[a-z]')),
      'At least 1 special character (!@#\$%)':
          password.contains(RegExp(r'[!@#$%]')),
    };
  }

  /// Checks if all password requirements are met
  static bool isPasswordValid(String password) {
    final requirements = getPasswordRequirements(password);
    return requirements.values.every((requirement) => requirement);
  }
}
