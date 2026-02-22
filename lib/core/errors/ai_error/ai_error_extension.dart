import 'package:flutter/cupertino.dart';

import '../../../l10n/app_localizations.dart';
import 'ai_error_type.dart';

extension AiErrorUiExt on AiErrorType {
  String localized(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      AiErrorType.safety => l10n.errorSafety,
      AiErrorType.quota => l10n.errorQuota,
      AiErrorType.network => l10n.errorNetwork,
      AiErrorType.config => l10n.errorConfig,
      AiErrorType.invalid => l10n.errorInvalid,
      AiErrorType.server => l10n.errorServer,
      AiErrorType.unknown => l10n.errorUnknown,
    };
  }
}
