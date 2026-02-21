import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/auth/presentation/pages/email_login/email_view_model.dart';
import 'package:lara_ai/features/auth/presentation/pages/email_login/widgets/email_field.dart';
import 'package:lara_ai/features/auth/presentation/widgets/filled_buttom_custom.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final _vm = Modular.get<EmailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                context.localization!.email_instructionTitle,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontSize: FontSizes.bodyMedium,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: EmailField(controller: _vm.controller),
              ),
              Text(
                context.localization!.email_spamWarning,
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: FontSizes.bodySmall,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              FilledButtonCustom(text: context.localization!.email_buttonSend),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
