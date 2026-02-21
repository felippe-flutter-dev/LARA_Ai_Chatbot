import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/font_sizes.dart';
import 'package:lara_ai/core/constants/navigation_route_names.dart';
import 'package:lara_ai/core/theme/app_assets.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/data/services/auth_service.dart';

class GoogleLoginButton extends StatefulWidget {
  final Function()? onPressed;

  const GoogleLoginButton({super.key, this.onPressed});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  final AuthService _authService = AuthService();
  bool _loading = false;

  Future<void> _handlePress() async {
    setState(() => _loading = true);
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(const SnackBar(content: Text('Entrando...')));
    try {
      final user = await _authService.signInWithGoogle();
      if (!mounted) return;
      if (user == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Login cancelado')),
        );
      } else if (user.uid.isNotEmpty) {
        Modular.to.pushNamed(NavigationRouteNames.toChatPage);
      }
    } catch (e) {
      debugPrint("Erro ao entrar: $e");
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text('Erro ao entrar: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed ?? (_loading ? null : _handlePress),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          context.isDarkMode ? AppColors.darkBg200 : AppColors.gray50,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(24)),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: context.isDarkMode
                ? AppColors.surfaceOverlay
                : AppColors.gray100,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 26.h,
              width: 26.h,
              child: Image.asset(AppAssets.googleLogo),
            ),
            SizedBox(width: 16.w),
            _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    context.localization!.login_buttonGoogle,
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: FontSizes.bodyLarge,
                      fontWeight: FontWeight.w700,
                      color: context.brightness == Brightness.dark
                          ? AppColors.textOnDark
                          : AppColors.gray700,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
