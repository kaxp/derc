import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/molecules/list_items/event_list_cell.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/utils/helpers.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({
    super.key,
    required this.events,
    required this.onTap,
  });

  final List<Event> events;
  final Function(Event) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final bannerImage = events[index].performers[0].image;
        final city = events[index].venue.city;
        final state = events[index].venue.state;
        final title = events[index].title;
        final dateTime = events[index].datetimeLocal;

        return GestureDetector(
          onTap: () {
            onTap(events[index]);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kSpacingXSmall,
              vertical: kSpacingXSmall,
            ),
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(kSpacingXSmall),
                child: EventListCell(
                  imageUrl: bannerImage,
                  city: '$city, $state',
                  title: title,
                  dateAndTime:
                      DateFormatter.formattedFullDateAndTimeWithComma(dateTime),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: AppColors.disabledColor,
        );
      },
    );
  }
}
