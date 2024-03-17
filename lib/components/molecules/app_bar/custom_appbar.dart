import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.titleWidget,
    this.isCenter,
    this.actionWidgets,
    this.leadingWidget,
    this.elevation = 5,
    this.backgroundColor = AppColors.primaryColor,
  }) : super(key: key);

  final Widget? titleWidget;
  final bool? isCenter;
  final List<Widget>? actionWidgets;
  final Widget? leadingWidget;
  final double? elevation;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      leading: leadingWidget,
      elevation: elevation,
      backgroundColor: backgroundColor,
      centerTitle: isCenter,
      title: titleWidget,
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
