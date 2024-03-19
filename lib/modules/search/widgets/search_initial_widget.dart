import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header5.dart';
import 'package:kapil_sahu_cred/components/molecules/search_input_box/custom_search_input_box.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';

class SearchInitialWidget extends StatelessWidget {
  const SearchInitialWidget({
    super.key,
    required this.textEditingController,
    required this.onSearch,
  });

  final TextEditingController textEditingController;
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpacingXSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AppImages.icDataSearch(height: 220),
          ),
          Header5(
            title: AppStrings.discoverPopularEvents,
            color: AppColors.white,
            fontSize: 16,
          ),
          const SizedBox(
            height: kSpacingMedium,
          ),
          CustomSearchInputBox(
            hintText: AppStrings.searchEvents,
            onSubmitted: onSearch,
            controller: textEditingController,
            showSuffixIcon: true,
          ),
        ],
      ),
    );
  }
}
