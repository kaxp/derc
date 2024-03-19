import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header1.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header2.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header3.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header5.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header6.dart';
import 'package:kapil_sahu_cred/components/molecules/banners/main_event_banner.dart';
import 'package:kapil_sahu_cred/components/molecules/search_input_box/custom_search_input_box.dart';
import 'package:kapil_sahu_cred/components/molecules/snackbar/custom_snackbar.dart';
import 'package:kapil_sahu_cred/components/organisms/list_views/search_result_list_view.dart';
import 'package:kapil_sahu_cred/components/organisms/stack_view/stack_view_manager.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/home/widgets/home_initial_view.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';
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
            if (state is SearchLoading) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: const CircularProgressIndicator(),
                secondaryChild: Text(
                  AppStrings.awaitingJoy,
                  style: const TextStyle(color: AppColors.lightGreyColor),
                ),
                buttonTitle: AppStrings.awaitingJoy,
                onButtonTap: () => () {},
              );
            } else if (state is SearchResultLoaded) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchResultLoaded(state),
                secondaryChild: Text(AppStrings.selectFromThrillingEvents,
                    style: const TextStyle(color: AppColors.lightGreyColor)),
                buttonTitle: AppStrings.detailView,
                onButtonTap: () {
                  if (_selectedEvent != null) {
                    _currentStackIndex += 1;
                    _seachBloc.showEventDetail(_selectedEvent!);
                  }
                },
              );
            } else if (state is SearchResultEmpty) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchResultEmpty(),
                secondaryChild: Text(AppStrings.couldNotLocateEvent,
                    style: const TextStyle(color: AppColors.lightGreyColor)),
                buttonTitle: AppStrings.back,
                onButtonTap: () {
                  _currentStackIndex -= 1;
                  _seachBloc.onEmptyViewSubmit();
                },
              );
            } else if (state is SearchResultFailed) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: const HomeInitialView(),
                secondaryChild: Text(AppStrings.noResultFound,
                    style: const TextStyle(color: AppColors.lightGreyColor)),
                buttonTitle: AppStrings.retry,
                onButtonTap: () =>
                    _seachBloc.searchEvents(_searchInputController.text),
              );
            } else if (state is SearchBuyEventTicket) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchBuyTicketView(),
                secondaryChild: const SizedBox.shrink(),
                buttonTitle: AppStrings.buyTicket,
                onButtonTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackbar(
                      message: AppStrings.ticketUnlocked,
                      duration: const Duration(seconds: 5),
                    ),
                  );
                  Modular.to.pop();
                  onStackDismissed();
                },
              );
            }
          },
          builder: (context, state) {
            if (state is SearchInitial) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchInitialWidget,
                secondaryChild: Text(AppStrings.unlockTheMagic,
                    style: const TextStyle(color: AppColors.lightGreyColor)),
                buttonTitle: AppStrings.search,
                onButtonTap: () {
                  if (_searchInputController.text.trim().isNotEmpty) {
                    _currentStackIndex += 1;
                    _seachBloc.searchEvents(_searchInputController.text);
                  }
                },
              );
            } else if (state is SearchEventDetail) {
              stackView[_currentStackIndex] = StackViewModel(
                primaryChild: _searchEventDetail(state),
                secondaryChild: Text(AppStrings.uncloverDetails,
                    style: const TextStyle(color: AppColors.lightGreyColor)),
                buttonTitle: AppStrings.buyTicket,
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
                    Modular.to.pop();
                    onStackDismissed();
                  },
                  stackItems: stackView,
                  onStackChange: (stackIndex) {
                    _currentStackIndex = stackIndex;
                    _seachBloc.onStackChange(stackIndex, totalStackCount);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget get _searchInitialWidget => Padding(
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
              onSubmitted: (query) {
                if (query.trim().isNotEmpty) {
                  _currentStackIndex += 1;
                  _seachBloc.searchEvents(query);
                }
              },
              controller: _searchInputController,
              showSuffixIcon: true,
            ),
          ],
        ),
      );

  Widget _searchResultLoaded(SearchState state) => Column(
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
                        onTap: (event) {
                          _selectedEvent = event;
                          _currentStackIndex += 1;
                          _seachBloc.showEventDetail(_selectedEvent!);
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

  Widget _searchResultEmpty() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSpacingSmall),
      child: Column(
        children: [
          AppImages.icDataNotFound(),
          const SizedBox(
            height: kSpacingSmall,
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: AppImages.icSuccess()),
          Header6(
            title: AppStrings.timeToMakeItYours,
            color: AppColors.redColor,
            fontSize: 20,
          ),
          Header5(
            title: AppStrings.youAreStanding,
            color: AppColors.white,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

class StackViewModel {
  StackViewModel({
    this.secondaryChild,
    required this.primaryChild,
    required this.buttonTitle,
    required this.onButtonTap,
  });

  final Widget? secondaryChild;
  final Widget primaryChild;
  final String buttonTitle;
  final VoidCallback onButtonTap;
}
