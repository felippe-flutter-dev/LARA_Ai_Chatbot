import 'package:flutter/widgets.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_error_type.dart';

extension AuthErrorUiExt on AuthErrorType {
  String localized(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      AuthErrorType.userNotFound => l10n.authErrorUserNotFound,
      AuthErrorType.wrongPassword => l10n.authErrorWrongPassword,
      AuthErrorType.emailInUse => l10n.authErrorEmailInUse,
      AuthErrorType.invalidEmail => l10n.authErrorInvalidEmail,
      AuthErrorType.weakPassword => l10n.authErrorWeakPassword,
      AuthErrorType.network => l10n.authErrorNetwork,
      AuthErrorType.tooManyRequests => l10n.authErrorTooManyRequests,
      AuthErrorType.userDisabled => l10n.authErrorUserDisabled,
      AuthErrorType.operationNotAllowed => l10n.authErrorOperationNotAllowed,
      AuthErrorType.unknown => l10n.authErrorUnknown,
    };
  }
}
