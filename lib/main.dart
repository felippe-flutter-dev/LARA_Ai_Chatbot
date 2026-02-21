import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lara_ai/core/modules/main_module.dart';
import 'core/theme/theme_dark.dart';
import 'core/theme/theme_light.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      minTextAdapt: true,
      enableScaleText: () => true,
      ensureScreenSize: true,
      fontSizeResolver: (size, util) => size * min(util.textScaleFactor, 1.4),
      builder: (context, child) => ModularApp(
        module: MainModule(),
        child: MaterialApp.router(
          title: 'LARA AI',
          theme: AppThemeLight.theme,
          darkTheme: AppThemeDark.theme,
          themeMode: ThemeMode.system,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        ),
      ),
      child: SizedBox.shrink(),
    );
  }
}
