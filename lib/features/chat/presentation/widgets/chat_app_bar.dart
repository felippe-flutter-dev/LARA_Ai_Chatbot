import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/core/theme/app_colors.dart';
import 'package:lara_ai/core/theme/theme_extension.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_states.dart';
import 'package:lara_ai/features/chat/presentation/widgets/lara_appbar_icon.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key});

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  final LoginCubit _loginCubit = Modular.get<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: _loginCubit,
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Modular.to.pushReplacementNamed(RouteNames.loginPage);
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: AppBar(
            elevation: 4,
            shadowColor: Colors.black,
            toolbarHeight: 64.h,
            title: LaraAppbarIcon(),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => _loginCubit.logout(),
                icon: Icon(
                  LucideIcons.logOut,
                  color: context.isDarkMode
                      ? AppColors.textOnDark
                      : AppColors.gray900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
