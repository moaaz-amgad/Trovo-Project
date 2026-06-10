import 'package:trovo_app/generated/l10n.dart';

class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  static final RegExp _phoneRegex = RegExp(r'^[0-9]{10,15}$');

  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? S.current.fieldRequired(fieldName)
          : S.current.thisFieldRequired;
    }
    return null;
  }

  static String? username(String? value) {
    final requiredError = required(value, fieldName: S.current.username);
    if (requiredError != null) return requiredError;

    if (!_usernameRegex.hasMatch(value!)) {
      return S.current.invalidUsername;
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value, fieldName: S.current.email);
    if (requiredError != null) return requiredError;

    if (!_emailRegex.hasMatch(value!)) {
      return S.current.invalidEmail;
    }
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    final requiredError = required(value, fieldName: S.current.password);
    if (requiredError != null) return requiredError;

    if (value!.length < minLength) {
      return S.current.passwordTooShort(minLength);
    }
    return null;
  }

  static String? confirmPassword(String? value, String originalPassword) {
    final requiredError = required(value, fieldName: S.current.confirmPassword);
    if (requiredError != null) return requiredError;

    if (value != originalPassword) {
      return S.current.passwordsDoNotMatch;
    }
    return null;
  }

  static String? phone(String? value) {
    final requiredError = required(value, fieldName: S.current.phoneNumber);
    if (requiredError != null) return requiredError;

    if (!_phoneRegex.hasMatch(value!)) {
      return S.current.invalidPhoneNumber;
    }
    return null;
  }

  static String? otp(String? value, {int length = 6}) {
    final requiredError = required(value, fieldName: S.current.otpCode);
    if (requiredError != null) return requiredError;

    if (value!.length != length || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return S.current.invalidOtp(length);
    }
    return null;
  }

  static String? minLength(String? value, int min, {String? fieldName}) {
    final requiredError = required(value, fieldName: fieldName);
    if (requiredError != null) return requiredError;

    if (value!.length < min) {
      return S.current.minLengthError(min);
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value != null && value.length > max) {
      return S.current.maxLengthError(max);
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );

    if (!urlRegex.hasMatch(value)) {
      return S.current.invalidUrl;
    }
    return null;
  }

  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }
}
