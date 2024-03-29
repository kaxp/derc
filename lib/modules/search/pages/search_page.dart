import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header3.dart';
import 'package:kapil_sahu_cred/components/organisms/stack_view_manager/stack_view_manager.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';
import 'package:kapil_sahu_cred/modules/search/listener/search_listener.dart';
import 'package:kapil_sahu_cred/modules/search/models/stack_view_model.dart';
import 'package:kapil_sahu_cred/modules/search/widgets/search_event_detail_widget.dart';
import 'package:kapil_sahu_cred/modules/search/widgets/search_initial_widget.dart';

class SearchPage {
  final SearchBloc _searchBloc = Modular.get<SearchBloc>();

  void showSearchView({
    required BuildContext context,
    required VoidCallback onStackDismissed,
    required int totalStackCount,
    Event? selectedEvent,
  }) {
    _searchBloc.setInititalState(selectedEvent);

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      useRootNavigator: false,
      elevation: 0,
      backgroundColor: AppColors.transparentColor,
      context: context,
      builder: (ctx) {
        return BlocConsumer<SearchBloc, SearchState>(
          bloc: _searchBloc,
          listener: (context, state) => SearchListener.listen(
            context: context,
            state: state,
            onStackDismissed: onStackDismissed,
            bloc: _searchBloc,
          ),
          builder: (context, state) {
            _populateStackView(context, state);

            return FractionallySizedBox(
              heightFactor: 0.9,
              child: PopScope(
                canPop: false,
                child: StackViewManager(
                  totalStackCount: totalStackCount,
                  currentStackIndex: _searchBloc.currentStackIndex,
                  onStackDismissed: () {
                    Modular.to.pop();
                    onStackDismissed();
                  },
                  stackItems: _searchBloc.stackViewItems,
                  onStackChange: (stackIndex) {
                    _searchBloc.currentStackIndex = stackIndex;
                    _searchBloc.onStackChange(stackIndex, totalStackCount);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// [_populateStackView] is responsible for populating the data for
  /// stackView based on where the Search bottomSheet is opened from.
  ///
  /// When bottomSheet is open from Search Button on HomePage, the state
  /// of SearchPage will be [SearchInitial].
  ///
  /// When bottomSheet is open from clicking Event item on HomePage, the state
  /// of SearchPage will be [SearchShowEventDetail].
  void _populateStackView(BuildContext context, SearchState state) {
    if (state is SearchInitial) {
      // Init view with search bar
      _searchBloc.stackViewItems[_searchBloc.currentStackIndex] =
          StackViewModel(
        primaryChild: SearchInitialWidget(
          textEditingController: _searchBloc.searchInputController,
          focusNode: _searchBloc.focusNode,
          onSearch: (query) {
            if (query.trim().isNotEmpty) {
              _searchBloc.currentStackIndex += 1;
              _searchBloc.searchEvents(query);
            }
          },
        ),
        secondaryChild: Header3(
          title: AppStrings.unlockTheMagic,
          color: AppColors.lightGreyColor,
        ),
        buttonTitle: AppStrings.search,
        onButtonTap: () {
          if (_searchBloc.searchInputController.text.trim().isNotEmpty) {
            _searchBloc.currentStackIndex += 1;
            _searchBloc.searchEvents(_searchBloc.searchInputController.text);
          }
        },
      );
    } else if (state is SearchShowEventDetail) {
      _searchBloc.stackViewItems[_searchBloc.currentStackIndex] =
          StackViewModel(
        primaryChild: SearchShowEventDetailWidget(state: state),
        secondaryChild: Header3(
          title: AppStrings.uncloverDetails,
          color: AppColors.lightGreyColor,
        ),
        buttonTitle: AppStrings.buyTicket,
        onButtonTap: () {
          _searchBloc.currentStackIndex += 1;
          _searchBloc.onEventDetailSubmit();
        },
      );
    }
  }
}
