import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header1.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header2.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header3.dart';
import 'package:kapil_sahu_cred/components/molecules/banners/main_event_banner.dart';
import 'package:kapil_sahu_cred/components/molecules/search_input_box/custom_search_input_box.dart';
import 'package:kapil_sahu_cred/components/organisms/list_views/search_result_list_view.dart';
import 'package:kapil_sahu_cred/components/organisms/stack_view/stack_view_manager.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/home/bloc/search_bloc.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/home/widgets/home_initial_view.dart';
import 'package:kapil_sahu_cred/utils/helpers.dart';

class SearchPage {
  final _seachBloc = Modular.get<SearchBloc>();
  late final TextEditingController _searchInputController;
  int _currentStackIndex = 0;
  Map<int, StackViewModel> stackView = {};
  Event? _selectedEvent;

  SearchPage() {
    _searchInputController = TextEditingController();
  }

  void showSearchView({
    required BuildContext context,
    required VoidCallback onStackDismissed,
    required int totalStackCount,
    Event? selectedEvent,
  }) {
    _seachBloc.setInititalState(selectedEvent);

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      useRootNavigator: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return BlocConsumer<SearchBloc, SearchState>(
          bloc: _seachBloc,
          listener: (context, state) {
            if (state is SearchInitial) {
            } else if (state is SearchLoading) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: const CircularProgressIndicator(),
                secondaryChild: const Text('Child 2 loading'),
                buttonTitle: 'Loading...',
                onButtonTap: () => () {},
              );
            } else if (state is SearchResultLoaded) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchResultLoaded(state),
                secondaryChild: const Text('Child 2 loaded'),
                buttonTitle: _selectedEvent?.title ?? 'Detail View',
                onButtonTap: () {
                  _currentStackIndex += 1;
                  _seachBloc.showEventDetail(_selectedEvent!);
                },
              );
            } else if (state is SearchResultEmpty) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchResultEmpty(),
                secondaryChild: const Text('Child 2 Empty state'),
                buttonTitle: 'Back',
                onButtonTap: () {
                  _currentStackIndex -= 1;
                  _seachBloc.onEmptyViewSubmit();
                },
              );
            } else if (state is SearchResultFailed) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: const HomeInitialView(),
                secondaryChild: const Text('Child 2 failed state'),
                buttonTitle: 'Retry',
                onButtonTap: () =>
                    _seachBloc.searchEvents(_searchInputController.text),
              );
            } else if (state is SearchEventDetail) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchEventDetail(state),
                secondaryChild: const Text('Child event detail'),
                buttonTitle: 'Buy Event Ticket',
                onButtonTap: () {
                  _currentStackIndex += 1;
                  _seachBloc.onEventDetailSubmit();
                },
              );
            } else if (state is SearchBuyEventTicket) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchBuyTicketView(),
                secondaryChild: const SizedBox.shrink(),
                buttonTitle: 'Buy Event Ticket',
                onButtonTap: () {
                  //TODO(kaxp): Check what to do after ticket buy
                  _seachBloc.onTicketBuy();
                },
              );
            } else {}
          },
          builder: (context, state) {
            if (state is SearchInitial) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchInitialWidget,
                secondaryChild: const Text('Child 1'),
                buttonTitle: 'Search',
                onButtonTap: () {
                  _currentStackIndex += 1;
                  _seachBloc.searchEvents(_searchInputController.text);
                },
              );
            } else if (state is SearchEventDetail) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchEventDetail(state),
                secondaryChild: const Text('Child event detail'),
                buttonTitle: 'Buy Event Ticket',
                onButtonTap: () {
                  _currentStackIndex += 1;
                  _seachBloc.onEventDetailSubmit();
                },
              );
            }

            return FractionallySizedBox(
              heightFactor: 0.9,
              child: PopScope(
                canPop: false,
                child: StackViewManager(
                  totalStackCount: totalStackCount,
                  currentStackIndex: _currentStackIndex,
                  onStackDismissed: () {
                    Navigator.pop(context);
                    onStackDismissed();
                  },
                  stackItems: stackView,
                  onStackChange: (stackIndex) {
                    _currentStackIndex = stackIndex;
                    _seachBloc.onStackChange(stackIndex);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget get _searchInitialWidget => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImages.icDataSearch(height: 320),
          CustomSearchInputBox(
            hintText: AppStrings.searchEvents,
            onSubmitted: (query) {
              _currentStackIndex += 1;
              _seachBloc.searchEvents(query);
            },
            controller: _searchInputController,
            showSuffixIcon: true,
          ),
        ],
      );

  Widget _searchResultLoaded(SearchState state) => Column(
        children: [
          AppImages.icBlog(),
          state is SearchResultLoaded
              ? Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SearchResultListView(
                        events: state.totalEvents!,
                        onTap: (event) {
                          _selectedEvent = event;
                        },
                      ),
                    ],
                  ),
                )
              : const HomeInitialView()
        ],
      );

  Widget _searchEventDetail(SearchEventDetail state) {
    if (state.selectedEvent == null) {
      return const SizedBox.shrink();
    }

    final event = state.selectedEvent!;

    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: kSpacingMedium,
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
                fontSize: 24,
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

  Widget _searchResultEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImages.icDataNotFound(),
          Header2(
            textAlign: TextAlign.center,
            title: AppStrings.noResultFound,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _searchBuyTicketView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header2(
          textAlign: TextAlign.center,
          title: 'Buy Now?',
          color: AppColors.redColor,
        ),
        const SizedBox(
          height: kSpacingXSmall,
        ),
        const Header3(
          textAlign: TextAlign.center,
          title: 'Select the payment gateway to purchase the ticket',
          color: AppColors.white,
        ),
        const SizedBox(
          height: kSpacingMedium,
        ),
        AppImages.icRocket()
      ],
    );
  }
}

class StackViewModel {
  StackViewModel({
    required this.primaryChild,
    required this.secondaryChild,
    required this.buttonTitle,
    required this.onButtonTap,
  });

  final Widget primaryChild;
  final Widget secondaryChild;
  final String buttonTitle;
  final VoidCallback onButtonTap;
}
