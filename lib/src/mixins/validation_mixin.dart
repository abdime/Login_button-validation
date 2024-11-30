mixin ValidationMixin {
  // Method to validate an email input
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty'; // Error message when email is empty
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email'; // Error message if the email doesn't contain '@'
    }
    return null; // Validation successful
  }

  // Method to validate a password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters'; // Error message for password validation
    }
    return null; // Validation successful
  }
}
