class AppValidator {
  // Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$', caseSensitive: false);
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    RegExp phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  // Validate name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Enter a valid name';
    }
    return null;
  }

  // Validate date (e.g., for birthdate)
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }
    RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegExp.hasMatch(value)) {
      return 'Enter a valid date in YYYY-MM-DD format';
    }
    return null;
  }

  // Validate URL
  static String? validateURL(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a URL';
    }
    RegExp urlRegExp = RegExp(
        r'^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-\.]*)*$',
        caseSensitive: false);
    if (!urlRegExp.hasMatch(value)) {
      return 'Enter a valid URL';
    }
    return null;
  }
}
