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

  /// No description provided for @email_instructionTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started.'**
  String get email_instructionTitle;

  /// No description provided for @email_instructionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email below to receive a secure, passwordless login link.'**
  String get email_instructionSubtitle;

  /// No description provided for @email_fieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email_fieldLabel;

  /// No description provided for @email_fieldHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., alex@company.com'**
  String get email_fieldHint;

  /// No description provided for @email_spamWarning.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox (and spam) after clicking. The link is valid for 10 minutes.'**
  String get email_spamWarning;

  /// No description provided for @email_buttonSend.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get email_buttonSend;

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

  /// No description provided for @drawer_chatTitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Recipe Ideas'**
  String get drawer_chatTitleDefault;

  /// No description provided for @drawer_chatSubtitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Can you suggest some healthy di...'**
  String get drawer_chatSubtitleDefault;

  /// No description provided for @drawer_timeAgo.
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String drawer_timeAgo(String time);

  /// No description provided for @drawer_footerVersion.
  ///
  /// In en, this message translates to:
  /// **'LARA AI v1.0 • Built with ❤️'**
  String get drawer_footerVersion;

  /// No description provided for @chat_inputHint.
  ///
  /// In en, this message translates to:
  /// **'Message LARA...'**
  String get chat_inputHint;

  /// No description provided for @chat_initialGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hey there! 👋 I\'m LARA, your AI sidekick with a sense of humor. What can I help you with today?'**
  String get chat_initialGreeting;
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
