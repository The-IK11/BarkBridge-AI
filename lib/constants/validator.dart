String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter Password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

String? passwordValidatorSpecial(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }

  final hasNumber = RegExp(r'\d');
  if (!hasNumber.hasMatch(value)) {
    return 'Password must contain at least one number';
  }

  final hasSpecialChar = RegExp(r'[!@#\$&*~%^()\-_=+{}[\]|;:<>,.?]');
  if (!hasSpecialChar.hasMatch(value)) {
    return 'Password must contain at least one special character';
  }

  return null; // Valid password
}

// Confirm Password Validator
String? confirmPasswordValidator(String? value, String? originalPassword) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != originalPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  // Regular expression for validating international phone numbers
  // String pattern = r'^\+?([0-9]{1,3})?[-.●\s]?([0-9]{1,4})[-.●\s]?([0-9]{1,4})[-.●\s]?([0-9]{1,9})$';
  // RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }
  // else if (!regExp.hasMatch(value)) {
  //   return 'Please enter a valid phone number';
  // }
  return null;
}

String? validate4DigitPinCode(String? value) {
  // Regular expression for validating international phone numbers
  // String pattern = r'^\+?([0-9]{1,3})?[-.●\s]?([0-9]{1,4})[-.●\s]?([0-9]{1,4})[-.●\s]?([0-9]{1,9})$';
  // RegExp regExp = RegExp(pattern);
  // int pinCode = value as int;

  if (value == null || value.isEmpty) {
    return 'Enter 4 Digit Code';
  }
  if (value.length < 4) {
    return 'Enter 4 Digit Code';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }

  return null;
}

String? emptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please fill the field';
  }

  return null;
}

String? userNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your username';
  }

  return null;
}
