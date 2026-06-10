// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `LYVRA`
  String get appTitle {
    return Intl.message('LYVRA', name: 'appTitle', desc: '', args: []);
  }

  /// `Create New Account`
  String get createNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Profile Image`
  String get profileImage {
    return Intl.message(
      'Profile Image',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `Allowed files: JPEG, PNG`
  String get allowedFiles {
    return Intl.message(
      'Allowed files: JPEG, PNG',
      name: 'allowedFiles',
      desc: '',
      args: [],
    );
  }

  /// `Max size: 5MB`
  String get maxSize {
    return Intl.message('Max size: 5MB', name: 'maxSize', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `user22`
  String get usernamePlaceholder {
    return Intl.message(
      'user22',
      name: 'usernamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `user@gmail.com`
  String get emailPlaceholder {
    return Intl.message(
      'user@gmail.com',
      name: 'emailPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Have an account? `
  String get haveAccount {
    return Intl.message(
      'Have an account? ',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Registration Successful`
  String get registrationSuccessful {
    return Intl.message(
      'Registration Successful',
      name: 'registrationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Registration Failed`
  String get registrationFailed {
    return Intl.message(
      'Registration Failed',
      name: 'registrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message('Remember me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create new account`
  String get createAccount {
    return Intl.message(
      'Create new account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login Successful`
  String get loginSuccessful {
    return Intl.message(
      'Login Successful',
      name: 'loginSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get loginFailed {
    return Intl.message(
      'Login Failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Verification Code`
  String get otpVerification {
    return Intl.message(
      'Verification Code',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `To complete opening your account, enter the verification code sent via email`
  String get otpDescription {
    return Intl.message(
      'To complete opening your account, enter the verification code sent via email',
      name: 'otpDescription',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive code? `
  String get didntReceiveCode {
    return Intl.message(
      'Didn\'t receive code? ',
      name: 'didntReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resendCode {
    return Intl.message('Resend', name: 'resendCode', desc: '', args: []);
  }

  /// `Continue`
  String get continueButton {
    return Intl.message('Continue', name: 'continueButton', desc: '', args: []);
  }

  /// `Verification Successful`
  String get otpSuccessful {
    return Intl.message(
      'Verification Successful',
      name: 'otpSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Verification Failed`
  String get otpFailed {
    return Intl.message(
      'Verification Failed',
      name: 'otpFailed',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `My Account`
  String get myAccount {
    return Intl.message('My Account', name: 'myAccount', desc: '', args: []);
  }

  /// `Welcome to LYVRA!`
  String get welcomeMessage {
    return Intl.message(
      'Welcome to LYVRA!',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your network settings.`
  String get networkError {
    return Intl.message(
      'No internet connection. Please check your network settings.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout. Please try again.`
  String get timeoutError {
    return Intl.message(
      'Connection timeout. Please try again.',
      name: 'timeoutError',
      desc: '',
      args: [],
    );
  }

  /// `Request cancelled.`
  String get cancelledError {
    return Intl.message(
      'Request cancelled.',
      name: 'cancelledError',
      desc: '',
      args: [],
    );
  }

  /// `Server error occurred. Please try again later.`
  String get serverError {
    return Intl.message(
      'Server error occurred. Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Requested resource not found.`
  String get notFoundError {
    return Intl.message(
      'Requested resource not found.',
      name: 'notFoundError',
      desc: '',
      args: [],
    );
  }

  /// `Session expired. Please login again.`
  String get unauthorizedError {
    return Intl.message(
      'Session expired. Please login again.',
      name: 'unauthorizedError',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to access this resource.`
  String get forbiddenError {
    return Intl.message(
      'You don\'t have permission to access this resource.',
      name: 'forbiddenError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid request. Please check your input data.`
  String get badRequestError {
    return Intl.message(
      'Invalid request. Please check your input data.',
      name: 'badRequestError',
      desc: '',
      args: [],
    );
  }

  /// `Validation failed. Please review the fields.`
  String get validationError {
    return Intl.message(
      'Validation failed. Please review the fields.',
      name: 'validationError',
      desc: '',
      args: [],
    );
  }

  /// `Local storage error occurred.`
  String get cacheError {
    return Intl.message(
      'Local storage error occurred.',
      name: 'cacheError',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again later.`
  String get unknownError {
    return Intl.message(
      'An unexpected error occurred. Please try again later.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Select Image Source`
  String get selectImageSource {
    return Intl.message(
      'Select Image Source',
      name: 'selectImageSource',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Take a new photo`
  String get takeNewPhoto {
    return Intl.message(
      'Take a new photo',
      name: 'takeNewPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Choose from existing photos`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from existing photos',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `This field is required`
  String get thisFieldRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `{fieldName} is required`
  String fieldRequired(String fieldName) {
    return Intl.message(
      '$fieldName is required',
      name: 'fieldRequired',
      desc: '',
      args: [fieldName],
    );
  }

  /// `Username must be 3-20 characters (letters, numbers, underscore)`
  String get invalidUsername {
    return Intl.message(
      'Username must be 3-20 characters (letters, numbers, underscore)',
      name: 'invalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least {minLength} characters`
  String passwordTooShort(int minLength) {
    return Intl.message(
      'Password must be at least $minLength characters',
      name: 'passwordTooShort',
      desc: '',
      args: [minLength],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get invalidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code`
  String get otpCode {
    return Intl.message('OTP Code', name: 'otpCode', desc: '', args: []);
  }

  /// `Please enter a valid {length}-digit code`
  String invalidOtp(int length) {
    return Intl.message(
      'Please enter a valid $length-digit code',
      name: 'invalidOtp',
      desc: '',
      args: [length],
    );
  }

  /// `Must be at least {min} characters`
  String minLengthError(int min) {
    return Intl.message(
      'Must be at least $min characters',
      name: 'minLengthError',
      desc: '',
      args: [min],
    );
  }

  /// `Must not exceed {max} characters`
  String maxLengthError(int max) {
    return Intl.message(
      'Must not exceed $max characters',
      name: 'maxLengthError',
      desc: '',
      args: [max],
    );
  }

  /// `Please enter a valid URL`
  String get invalidUrl {
    return Intl.message(
      'Please enter a valid URL',
      name: 'invalidUrl',
      desc: '',
      args: [],
    );
  }

  /// `Image size exceeds {maxSize}MB. Please choose a smaller image.`
  String imageTooLarge(double maxSize) {
    return Intl.message(
      'Image size exceeds ${maxSize}MB. Please choose a smaller image.',
      name: 'imageTooLarge',
      desc: '',
      args: [maxSize],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Old password is required to change password`
  String get oldPasswordRequired {
    return Intl.message(
      'Old password is required to change password',
      name: 'oldPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdateSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No changes to save`
  String get noChangesToSave {
    return Intl.message(
      'No changes to save',
      name: 'noChangesToSave',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
