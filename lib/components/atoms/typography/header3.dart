import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_fonts.dart';

class Header3 extends StatelessWidget {
  const Header3({
    required this.title,
    this.color,
    this.height,
    this.maxLines,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14,
    this.textAlign = TextAlign.start,
    this.textOverflow,
  });

  final String title;
  final Color? color;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: color ?? AppColors.blackColor,
            height: height,
            fontWeight: fontWeight,
            fontFamily: AppFonts.poppins,
            fontSize: fontSize,
          ),
    );
  }
}
