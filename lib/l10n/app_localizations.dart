import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @common_appName.
  ///
  /// In en, this message translates to:
  /// **'LARA'**
  String get common_appName;

  /// No description provided for @common_appSlogan.
  ///
  /// In en, this message translates to:
  /// **'Your AI sidekick with a sense of humor.'**
  String get common_appSlogan;

  /// No description provided for @common_onlineStatus.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get common_onlineStatus;

  /// No description provided for @common_offlineStatus.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get common_offlineStatus;

  /// No description provided for @common_buttonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get common_buttonBack;

  /// No description provided for @common_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get common_loading;

  /// No description provided for @common_errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get common_errorGeneric;

  /// No description provided for @common_deleteSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully!'**
  String get common_deleteSuccessMessage;

  /// No description provided for @errorSafety.
  ///
  /// In en, this message translates to:
  /// **'Oops! This topic is a bit sensitive for me and I can\'t answer it. Shall we talk about something else?'**
  String get errorSafety;

  /// No description provided for @errorQuota.
  ///
  /// In en, this message translates to:
  /// **'I\'m a bit overwhelmed with requests right now. Could you try again in a minute?'**
  String get errorQuota;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Looks like I lost my signal for a moment. Please check your connection and try asking me again!'**
  String get errorNetwork;

  /// No description provided for @errorConfig.
  ///
  /// In en, this message translates to:
  /// **'I\'m having a technical issue with my settings (API key). Please let support know!'**
  String get errorConfig;

  /// No description provided for @errorInvalid.
  ///
  /// In en, this message translates to:
  /// **'I had a small glitch processing your message. Could you try rewriting it a different way?'**
  String get errorInvalid;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'My servers are undergoing quick maintenance. Please try again soon!'**
  String get errorServer;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'I had an internal hiccup and couldn\'t answer you just now. Can you try again?'**
  String get errorUnknown;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found. Please check your email.'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password. Please try again.'**
  String get authErrorWrongPassword;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use by another account.'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email format is invalid.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak. Use at least 6 characters.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your internet.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get authErrorTooManyRequests;

  /// No description provided for @authErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authErrorUserDisabled;

  /// No description provided for @authErrorOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Email and password login is not enabled.'**
  String get authErrorOperationNotAllowed;

  /// No description provided for @authErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get authErrorUnknown;

  /// No description provided for @login_welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to LARA'**
  String get login_welcomeTitle;

  /// No description provided for @login_welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your AI sidekick with a sense of humor 😉'**
  String get login_welcomeSubtitle;

  /// No description provided for @login_buttonGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get login_buttonGoogle;

  /// No description provided for @login_buttonEmail.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Email'**
  String get login_buttonEmail;

  /// No description provided for @login_footerPrefix.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to LARA\'s '**
  String get login_footerPrefix;

  /// No description provided for @login_footerTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get login_footerTerms;

  /// No description provided for @login_footerAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get login_footerAnd;

  /// No description provided for @login_footerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get login_footerPrivacy;

  /// No description provided for @auth_loginEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Login'**
  String get auth_loginEmailTitle;

  /// No description provided for @auth_registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get auth_registerTitle;

  /// No description provided for @auth_emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get auth_emailLabel;

  /// No description provided for @auth_passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_passwordLabel;

  /// No description provided for @auth_confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get auth_confirmPasswordLabel;

  /// No description provided for @auth_buttonLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get auth_buttonLogin;

  /// No description provided for @auth_buttonRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get auth_buttonRegister;

  /// No description provided for @auth_noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get auth_noAccount;

  /// No description provided for @auth_registerLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get auth_registerLink;

  /// No description provided for @auth_registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Please login.'**
  String get auth_registerSuccess;

  /// No description provided for @bio_welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get bio_welcomeBack;

  /// No description provided for @bio_authRequired.
  ///
  /// In en, this message translates to:
  /// **'Authentication required. Use your biometrics to unlock LARA and continue your conversations.'**
  String get bio_authRequired;

  /// No description provided for @bio_buttonUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Biometrics'**
  String get bio_buttonUnlock;

  /// No description provided for @bio_notYou.
  ///
  /// In en, this message translates to:
  /// **'Not you? '**
  String get bio_notYou;

  /// No description provided for @bio_switchAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in with a different account'**
  String get bio_switchAccount;

  /// No description provided for @bio_dialogEnableTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometrics?'**
  String get bio_dialogEnableTitle;

  /// No description provided for @bio_dialogEnableMessage.
  ///
  /// In en, this message translates to:
  /// **'Want to log in faster next time? Enable FaceID or Fingerprint to secure your chats with LARA without needing a new email link.'**
  String get bio_dialogEnableMessage;

  /// No description provided for @bio_buttonEnableNow.
  ///
  /// In en, this message translates to:
  /// **'Enable Now'**
  String get bio_buttonEnableNow;

  /// No description provided for @bio_buttonMaybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get bio_buttonMaybeLater;

  /// No description provided for @bio_systemTitle.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to Chat'**
  String get bio_systemTitle;

  /// No description provided for @bio_systemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'LARA needs to make sure it\'s really you before continuing our talk.'**
  String get bio_systemSubtitle;

  /// No description provided for @bio_fingerprintHint.
  ///
  /// In en, this message translates to:
  /// **'Touch the fingerprint sensor'**
  String get bio_fingerprintHint;

  /// No description provided for @bio_usePassword.
  ///
  /// In en, this message translates to:
  /// **'Use Password'**
  String get bio_usePassword;

  /// No description provided for @bio_errorAuth.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication failed. Please try again.'**
  String get bio_errorAuth;

  /// No description provided for @drawer_title.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get drawer_title;

  /// No description provided for @drawer_buttonNewChat.
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get drawer_buttonNewChat;

  /// No description provided for @drawer_emptyConversations.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get drawer_emptyConversations;

  /// No description provided for @drawer_chatSubtitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Can you suggest some healthy di...'**
  String get drawer_chatSubtitleDefault;

  /// No description provided for @time_days.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day ago} other{{count} days ago}}'**
  String time_days(num count);

  /// No description provided for @time_hours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour ago} other{{count} hours ago}}'**
  String time_hours(num count);

  /// No description provided for @time_minutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute ago} other{{count} minutes ago}}'**
  String time_minutes(num count);

  /// No description provided for @time_just_now.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get time_just_now;

  /// No description provided for @drawer_footerVersion.
  ///
  /// In en, this message translates to:
  /// **'LARA AI v1.0 • Built with ❤️'**
  String get drawer_footerVersion;

  /// No description provided for @chat_inputHint.
  ///
  /// In en, this message translates to:
  /// **'Type here...'**
  String get chat_inputHint;

  /// No description provided for @chat_initialGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hey there! 👋 I\'m LARA, your AI sidekick with a sense of humor. What can I help you with today?'**
  String get chat_initialGreeting;

  /// No description provided for @chat_settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'LARA Settings'**
  String get chat_settingsTitle;

  /// No description provided for @chat_personalityLabel.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get chat_personalityLabel;

  /// No description provided for @chat_personalityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get chat_personalityNormal;

  /// No description provided for @chat_personalityConcise.
  ///
  /// In en, this message translates to:
  /// **'Concise'**
  String get chat_personalityConcise;

  /// No description provided for @chat_personalitySarcastic.
  ///
  /// In en, this message translates to:
  /// **'Sarcastic'**
  String get chat_personalitySarcastic;

  /// No description provided for @chat_temperatureLabel.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get chat_temperatureLabel;

  /// No description provided for @chat_maxTokensLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Characters'**
  String get chat_maxTokensLabel;

  /// No description provided for @chat_buttonSaveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get chat_buttonSaveSettings;

  /// No description provided for @chat_retryMessage.
  ///
  /// In en, this message translates to:
  /// **'Response error. Try again?'**
  String get chat_retryMessage;

  /// No description provided for @lara_settings_title.
  ///
  /// In en, this message translates to:
  /// **'LARA Settings'**
  String get lara_settings_title;

  /// No description provided for @lara_settings_personality.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get lara_settings_personality;

  /// No description provided for @lara_settings_mode_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get lara_settings_mode_normal;

  /// No description provided for @lara_settings_mode_concise.
  ///
  /// In en, this message translates to:
  /// **'Concise'**
  String get lara_settings_mode_concise;

  /// No description provided for @lara_settings_mode_sarcastic.
  ///
  /// In en, this message translates to:
  /// **'Sarcastic'**
  String get lara_settings_mode_sarcastic;

  /// No description provided for @lara_settings_temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get lara_settings_temperature;

  /// No description provided for @lara_settings_max_characters.
  ///
  /// In en, this message translates to:
  /// **'Max Characters'**
  String get lara_settings_max_characters;

  /// No description provided for @lara_settings_save.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get lara_settings_save;

  /// No description provided for @made_with_love.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ by Felippe Pinheiro'**
  String get made_with_love;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
