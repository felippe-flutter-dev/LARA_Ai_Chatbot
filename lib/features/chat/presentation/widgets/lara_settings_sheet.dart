import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/data/services/gemini_services.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/l10n/extension_localizations.dart';
import '../cubit/lara_settings/lara_settings_cubit.dart';
import 'lara_personality_options.dart';

class LaraSettingsSheet extends StatelessWidget {
  final LaraSettingsCubit cubit;

  const LaraSettingsSheet({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaraSettingsCubit, LaraSettingsState>(
      bloc: cubit,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.gray200,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                context.localization!.lara_settings_title,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                context.localization!.lara_settings_personality,
                style: context.textTheme.bodyLarge,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  PersonalityOption(
                    label: context.localization!.lara_settings_mode_normal,
                    isSelected: state.personality == LaraPersonality.normal,
                    onTap: () =>
                        cubit.updatePersonality(LaraPersonality.normal),
                  ),
                  SizedBox(width: 8.w),
                  PersonalityOption(
                    label: context.localization!.lara_settings_mode_concise,
                    isSelected: state.personality == LaraPersonality.concise,
                    onTap: () =>
                        cubit.updatePersonality(LaraPersonality.concise),
                  ),
                  SizedBox(width: 8.w),
                  PersonalityOption(
                    label: context.localization!.lara_settings_mode_sarcastic,
                    isSelected: state.personality == LaraPersonality.sarcastic,
                    onTap: () =>
                        cubit.updatePersonality(LaraPersonality.sarcastic),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localization!.lara_settings_temperature,
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    state.temperature.toStringAsFixed(2),
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
              Slider(
                value: state.temperature,
                min: 0.0,
                max: 1.0,
                activeColor: context.primaryColorScheme,
                onChanged: cubit.updateTemperature,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localization!.lara_settings_max_characters,
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    "${state.maxTokens}",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
              Slider(
                value: state.maxTokens.toDouble(),
                min: 100,
                max: 4096,
                divisions: 40,
                activeColor: context.primaryColorScheme,
                onChanged: (val) => cubit.updateMaxTokens(val.toInt()),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    cubit.saveSettings();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(context.localization!.lara_settings_save),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }
}
