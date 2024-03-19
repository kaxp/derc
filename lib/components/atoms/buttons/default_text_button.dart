import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_fonts.dart';

class DefaultTextButton extends StatelessWidget implements PreferredSizeWidget {
  const DefaultTextButton({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.transparentColor,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontFamily: AppFonts.poppins,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
