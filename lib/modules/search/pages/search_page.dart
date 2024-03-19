import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header3.dart';
import 'package:kapil_sahu_cred/components/organisms/stack_view/stack_view_manager.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';
import 'package:kapil_sahu_cred/modules/search/listener/search_listener.dart';
import 'package:kapil_sahu_cred/modules/search/models/stack_view_model.dart';
import 'package:kapil_sahu_cred/modules/search/widgets/search_event_detail_widget.dart';
import 'package:kapil_sahu_cred/modules/search/widgets/search_initial_widget.dart';

class SearchPage {
  final _searchBloc = Modular.get<SearchBloc>();
  final TextEditingController _searchInputController = TextEditingController();

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
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return BlocConsumer<SearchBloc, SearchState>(
          bloc: _searchBloc,
          listener: (context, state) => SearchListener().listen(
            context: context,
            state: state,
            onStackDismissed: onStackDismissed,
            bloc: _searchBloc,
            searchQuery: _searchInputController.text,
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
                  stackItems: _searchBloc.stackView,
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

  void _populateStackView(BuildContext context, SearchState state) {
    if (state is SearchInitial) {
      _searchBloc.stackView[_searchBloc.currentStackIndex] = StackViewModel(
        primaryChild: SearchInitialWidget(
          textEditingController: _searchInputController,
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
          if (_searchInputController.text.trim().isNotEmpty) {
            _searchBloc.currentStackIndex += 1;
            _searchBloc.searchEvents(_searchInputController.text);
          }
        },
      );
    } else if (state is SearchEventDetail) {
      _searchBloc.stackView[_searchBloc.currentStackIndex] = StackViewModel(
        primaryChild: SearchEventDetailWidget(state: state),
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
