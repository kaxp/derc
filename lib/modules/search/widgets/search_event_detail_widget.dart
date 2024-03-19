import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header1.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header3.dart';
import 'package:kapil_sahu_cred/components/molecules/banners/main_event_banner.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';
import 'package:kapil_sahu_cred/utils/helpers.dart';

class SearchShowEventDetailWidget extends StatelessWidget {
  const SearchShowEventDetailWidget({super.key, required this.state});

  final SearchShowEventDetail state;

  @override
  Widget build(BuildContext context) {
    if (state.selectedEvent == null) {
      return const SizedBox.shrink();
    }

    final event = state.selectedEvent!;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(kSpacingXSmall),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Center(
                child: MainEventBanner(
                  imageUrl: event.performers[0].image ?? '',
                ),
              ),
              const SizedBox(
                height: kSpacingMedium,
              ),
              Header1(
                title: event.title,
                color: AppColors.redColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Header3(
                title: '${event.venue.city}, ${event.venue.state}',
                color: AppColors.lightGreyColor,
              ),
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Header3(
                title: DateFormatter.formattedFullDateAndTimeWithComma(
                  event.datetimeLocal,
                ),
                color: AppColors.lightGreyColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
