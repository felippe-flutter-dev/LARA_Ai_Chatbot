import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/font_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_extension.dart';

class FilledButtonCustom extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final TextStyle? style;
  final bool expanded;

  const FilledButtonCustom({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.style,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? context.theme.colorScheme.primary,
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Text(
          text,
          style:
              style ??
              context.textTheme.bodyLarge!.copyWith(
                fontSize: FontSizes.bodyLarge,
                fontWeight: FontWeight.w700,
                color: AppColors.gray50,
              ),
        ),
      ),
    );

    if (expanded) {
      return Row(children: [Expanded(child: button)]);
    }

    return button;
  }
}
