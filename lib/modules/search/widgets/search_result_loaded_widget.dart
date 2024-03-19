import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header5.dart';
import 'package:kapil_sahu_cred/components/molecules/states/empty_state_view.dart';
import 'package:kapil_sahu_cred/components/organisms/list_views/search_result_list_view.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';

class SearchResultLoadedWidget extends StatelessWidget {
  const SearchResultLoadedWidget(
      {super.key, required this.onTap, required this.state});

  final Function(Event) onTap;
  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kSpacingSmall,
        ),
        Center(child: AppImages.icBlog(height: 160)),
        const SizedBox(
          height: kSpacingMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacingXSmall),
          child: Header5(
            title: AppStrings.peekBehind,
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: kSpacingXSmall,
        ),
        state is SearchResultLoaded
            ? Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SearchResultListView(
                      events: state.totalEvents!,
                      onTap: onTap,
                    ),
                  ],
                ),
              )
            : const EmptyStateView()
      ],
    );
  }
}
