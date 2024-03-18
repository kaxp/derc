import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header2.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';

class HomeInitialView extends StatelessWidget {
  const HomeInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImages.icDataNotFound(),
          Header2(
            textAlign: TextAlign.center,
            title: AppStrings.noDataFound,
          ),
        ],
      ),
    );
  }
}
