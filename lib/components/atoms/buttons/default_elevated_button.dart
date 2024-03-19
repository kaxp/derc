import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/radius_constants.dart';

import '../../../components/atoms/typography/header2.dart';

class DefaultElevatedButton extends StatelessWidget
    implements PreferredSizeWidget {
  const DefaultElevatedButton({
    required this.title,
    required this.onPressed,
    this.primaryColor,
  });

  final String title;
  final void Function() onPressed;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMinInteractiveDimension,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor ?? AppColors.redColor,
          shape: const SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerRadius: kRadiusSmall,
                cornerSmoothing: 1,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Header2(
          title: title,
          color: AppColors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
