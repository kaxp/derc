import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header3.dart';
import 'package:kapil_sahu_cred/components/molecules/snackbar/custom_snackbar.dart';
import 'package:kapil_sahu_cred/components/molecules/states/empty_state_view.dart';
import 'package:kapil_sahu_cred/components/molecules/states/error_state_view.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';
import 'package:kapil_sahu_cred/modules/search/models/stack_view_model.dart';
import 'package:kapil_sahu_cred/modules/search/widgets/search_buy_ticket_widget.dart';
import 'package:kapil_sahu_cred/modules/search/widgets/search_result_loaded_widget.dart';

class SearchListener {
  void listen({
    required BuildContext context,
    required SearchState state,
    required VoidCallback onStackDismissed,
    required SearchBloc bloc,
    required String searchQuery,
  }) {
    if (state is SearchLoading) {
      bloc.stackView[bloc.currentStackIndex] = StackViewModel(
        primaryChild: const CircularProgressIndicator(),
        secondaryChild: Header3(
          title: AppStrings.awaitingJoy,
          color: AppColors.lightGreyColor,
        ),
        buttonTitle: AppStrings.awaitingJoy,
        onButtonTap: () => () {},
      );
    } else if (state is SearchResultLoaded) {
      bloc.stackView[bloc.currentStackIndex] = StackViewModel(
        primaryChild: SearchResultLoadedWidget(
          state: state,
          onTap: (event) {
            bloc.selectedEvent = event;
            bloc.currentStackIndex += 1;
            bloc.showEventDetail(bloc.selectedEvent!);
          },
        ),
        secondaryChild: Header3(
          title: AppStrings.selectFromThrillingEvents,
          color: AppColors.lightGreyColor,
        ),
        buttonTitle: AppStrings.detailView,
        onButtonTap: () {
          if (bloc.selectedEvent != null) {
            bloc.currentStackIndex += 1;
            bloc.showEventDetail(bloc.selectedEvent!);
          }
        },
      );
    } else if (state is SearchResultEmpty) {
      bloc.stackView[bloc.currentStackIndex] = StackViewModel(
        primaryChild: const EmptyStateView(),
        secondaryChild: Header3(
          title: AppStrings.couldNotLocateEvent,
          color: AppColors.lightGreyColor,
        ),
        buttonTitle: AppStrings.back,
        onButtonTap: () {
          bloc.currentStackIndex -= 1;
          bloc.onEmptyViewSubmit();
        },
      );
    } else if (state is SearchResultError) {
      bloc.stackView[bloc.currentStackIndex] = StackViewModel(
        primaryChild: const ErrorStateView(),
        secondaryChild: Header3(
          title: AppStrings.noResultFound,
          color: AppColors.lightGreyColor,
        ),
        buttonTitle: AppStrings.retry,
        onButtonTap: () {
          bloc.currentStackIndex -= 1;
          bloc.searchEvents(searchQuery);
        },
      );
    } else if (state is SearchBuyEventTicket) {
      bloc.stackView[bloc.currentStackIndex] = StackViewModel(
        primaryChild: const SearchBuyTicketWidget(),
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
  }
}
