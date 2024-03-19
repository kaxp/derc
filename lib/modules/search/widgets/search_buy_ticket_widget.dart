import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header5.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header6.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';

class SearchBuyTicketWidget extends StatelessWidget {
  const SearchBuyTicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: AppImages.icSuccess()),
          Header6(
            title: AppStrings.timeToMakeItYours,
            color: AppColors.redColor,
            textAlign: TextAlign.center,
            fontSize: 20,
          ),
          Header5(
            title: AppStrings.youAreStanding,
            color: AppColors.white,
            textAlign: TextAlign.center,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
