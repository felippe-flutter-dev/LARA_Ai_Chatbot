import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../theme/app_colors.dart';
import '../theme/theme_extension.dart';

class FingerprintIcon extends StatelessWidget {
  final double size;
  const FingerprintIcon({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.h,
      width: size.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.isDarkMode
            ? AppColors.darkElevated
            : AppColors.secondaryMain,
      ),
      child: Center(
        child: Icon(
          LucideIcons.fingerprint,
          color: context.primaryColorScheme,
          size: size * 0.50, // proporcional
        ),
      ),
    );
  }
}
