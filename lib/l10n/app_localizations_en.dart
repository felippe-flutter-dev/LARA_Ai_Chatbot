// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get common_appName => 'LARA';

  @override
  String get common_appSlogan => 'Your AI sidekick with a sense of humor.';

  @override
  String get common_onlineStatus => 'Online';

  @override
  String get common_buttonBack => 'Back';

  @override
  String get common_loading => 'Loading...';

  @override
  String get common_errorGeneric => 'An error occurred. Please try again.';

  @override
  String get common_deleteSuccessMessage => 'Deleted successfully!';

  @override
  String get login_welcomeTitle => 'Welcome to LARA';

  @override
  String get login_welcomeSubtitle =>
      'Your AI sidekick with a sense of humor 😉';

  @override
  String get login_buttonGoogle => 'Sign in with Google';

  @override
  String get login_buttonEmail => 'Sign in with Email';

  @override
  String get login_footerPrefix => 'By continuing, you agree to LARA\'s ';

  @override
  String get login_footerTerms => 'Terms of Service';

  @override
  String get login_footerAnd => ' and ';

  @override
  String get login_footerPrivacy => 'Privacy Policy';

  @override
  String get auth_loginEmailTitle => 'Email Login';

  @override
  String get auth_registerTitle => 'Create your account';

  @override
  String get auth_emailLabel => 'Email';

  @override
  String get auth_passwordLabel => 'Password';

  @override
  String get auth_confirmPasswordLabel => 'Confirm Password';

  @override
  String get auth_buttonLogin => 'Login';

  @override
  String get auth_buttonRegister => 'Register';

  @override
  String get auth_noAccount => 'Don\'t have an account? ';

  @override
  String get auth_registerLink => 'Sign up';

  @override
  String get auth_registerSuccess => 'Registration successful! Please login.';

  @override
  String get bio_welcomeBack => 'Welcome Back!';

  @override
  String get bio_authRequired =>
      'Authentication required. Use your biometrics to unlock LARA and continue your conversations.';

  @override
  String get bio_buttonUnlock => 'Unlock with Biometrics';

  @override
  String get bio_notYou => 'Not you? ';

  @override
  String get bio_switchAccount => 'Sign in with a different account';

  @override
  String get bio_dialogEnableTitle => 'Enable Biometrics?';

  @override
  String get bio_dialogEnableMessage =>
      'Want to log in faster next time? Enable FaceID or Fingerprint to secure your chats with LARA without needing a new email link.';

  @override
  String get bio_buttonEnableNow => 'Enable Now';

  @override
  String get bio_buttonMaybeLater => 'Maybe Later';

  @override
  String get bio_systemTitle => 'Authenticate to Chat';

  @override
  String get bio_systemSubtitle =>
      'LARA needs to make sure it\'s really you before continuing our talk.';

  @override
  String get bio_fingerprintHint => 'Touch the fingerprint sensor';

  @override
  String get bio_usePassword => 'Use Password';

  @override
  String get bio_errorAuth =>
      'Biometric authentication failed. Please try again.';

  @override
  String get drawer_title => 'Conversations';

  @override
  String get drawer_buttonNewChat => 'New Chat';

  @override
  String get drawer_emptyConversations => 'No conversations yet';

  @override
  String get drawer_chatSubtitleDefault => 'Can you suggest some healthy di...';

  @override
  String time_days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String time_hours(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String time_minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String get time_just_now => 'just now';

  @override
  String get drawer_footerVersion => 'LARA AI v1.0 • Built with ❤️';

  @override
  String get chat_inputHint => 'Type here...';

  @override
  String get chat_initialGreeting =>
      'Hey there! 👋 I\'m LARA, your AI sidekick with a sense of humor. What can I help you with today?';

  @override
  String get chat_settingsTitle => 'LARA Settings';

  @override
  String get chat_personalityLabel => 'Personality';

  @override
  String get chat_personalityNormal => 'Normal';

  @override
  String get chat_personalityConcise => 'Concise';

  @override
  String get chat_personalitySarcastic => 'Sarcastic';

  @override
  String get chat_temperatureLabel => 'Temperature';

  @override
  String get chat_maxTokensLabel => 'Max Characters';

  @override
  String get chat_buttonSaveSettings => 'Save Settings';

  @override
  String get chat_retryMessage => 'Response error. Try again?';

  @override
  String get made_with_love => 'Made with ❤️ by Felippe Pinheiro';
}
