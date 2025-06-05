class FormValidators {
  /// Validates if the value is not null or empty
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Validates if the value is a valid number within specified range
  static String? numericRange(
    String? value, {
    double? min,
    double? max,
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    if (min != null && number < min) {
      return '${fieldName ?? 'Value'} must be at least $min';
    }

    if (max != null && number > max) {
      return '${fieldName ?? 'Value'} must not exceed $max';
    }

    return null;
  }

  /// Validates measurements (in cm) with realistic ranges
  static String? measurement(String? value, String fieldName) {
    return numericRange(
      value,
      min: 1,
      max: 300,
      fieldName: fieldName,
    );
  }

  /// Validates weight in kilograms
  static String? weight(String? value) {
    return numericRange(
      value,
      min: 20,
      max: 300,
      fieldName: 'Weight',
    );
  }

  /// Validates height in centimeters
  static String? height(String? value) {
    return numericRange(
      value,
      min: 50,
      max: 250,
      fieldName: 'Height',
    );
  }

  /// Validates age in years
  static String? age(String? value) {
    return numericRange(
      value,
      min: 0,
      max: 120,
      fieldName: 'Age',
    );
  }

  /// Validates email format
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates phone number format
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegExp = RegExp(r'^\+?[\d\s-]{10,}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validates password strength
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Validates if two passwords match
  static String? passwordMatch(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
