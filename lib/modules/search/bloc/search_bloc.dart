import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/home/repositories/home_repo.dart';
import 'package:kapil_sahu_cred/modules/search/models/stack_view_model.dart';

part 'search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchInitial());

  final HomeRepo _homeRepo = Modular.get<HomeRepo>();
  final TextEditingController searchInputController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  int currentStackIndex = 0;

  /// [selectedEvent] will hold the value of single Event data
  /// selected by the user.
  Event? selectedEvent;

  /// [stackViewItems] will hold the UI elements of all
  /// stack views.
  ///
  /// Here key pair are the stack number and value pair
  /// are UI components
  final Map<int, StackViewModel> stackViewItems = {};

  /// Search for events based on query.
  ///
  /// Constraint: Here we are fetching data of 1st page only.
  Future<void> searchEvents(String query) async {
    try {
      emit(SearchLoading());

      final response = await _homeRepo.fetchEventsData(
        searchString: query,
        page: 1, // Fetching only the first page.
      );

      if (response.events.isNotEmpty) {
        emit(SearchResultLoaded(events: response.events));
      } else {
        emit(SearchResultEmpty(events: response.events));
      }
    } on DioException catch (error) {
      emit(SearchResultError(exception: error, message: error.toString()));
    }
  }

  /// Show details of the selected event.
  void showEventDetail(Event event) {
    emit(
        SearchShowEventDetail(selectedEvent: event, events: state.totalEvents));
  }

  /// Reset state to initial when submitting from empty view.
  void onEmptyViewSubmit() {
    emit(SearchInitial());
  }

  /// Proceed to buy event ticket from event detail view.
  void onEventDetailSubmit() {
    emit(SearchBuyEventTicket(
      events: state.totalEvents,
      selectedEvent: state.selectedEvent!,
    ));
  }

  /// Handle stack change based on stack index and total stack count.
  ///
  /// When user open the `Search StackView` by clicking Event item on homepage then the
  /// total totalStackCount will be 2 and we will use [_handleStackChangeForTwoStacks]
  /// method to update the states.
  ///
  /// When user open the Search StackView from Search Button on homepage then the total
  /// totalStackCount will be 4 and we will use [_handleStackChangeForMultipleStacks]
  /// method to update the states.
  ///
  /// We should refactor this methods based on the totalStackCount.
  void onStackChange(int stackIndex, int totalStackCount) {
    switch (totalStackCount) {
      case 2:
        _handleStackChangeForTwoStacks(stackIndex);
        break;
      default:
        _handleStackChangeForMultipleStacks(stackIndex);
    }
  }

  void _handleStackChangeForTwoStacks(int stackIndex) {
    switch (stackIndex) {
      case 0:
        emit(SearchShowEventDetail(
            events: state.totalEvents, selectedEvent: state.selectedEvent!));
        break;
      case 1:
        emit(SearchBuyEventTicket(
            events: state.totalEvents, selectedEvent: state.selectedEvent!));
        break;
    }
  }

  void _handleStackChangeForMultipleStacks(int stackIndex) {
    switch (stackIndex) {
      case 0:
        emit(SearchInitial());
        break;
      case 1:
        emit(SearchResultLoaded(events: state.totalEvents!));
        break;
      case 2:
        emit(SearchShowEventDetail(
            events: state.totalEvents, selectedEvent: state.selectedEvent!));
        break;
      case 3:
        emit(SearchBuyEventTicket(
            events: state.totalEvents, selectedEvent: state.selectedEvent!));
        break;
    }
  }

  /// Set initial state, optionally with selected event.
  ///
  /// When user open StackView by clicking on Event cell in homepage
  /// then the search page state will be [SearchShowEventDetail] or else
  /// it will be [SearchInitial]
  void setInititalState(Event? selectedEvent) {
    if (selectedEvent != null) {
      emit(SearchShowEventDetail(
        selectedEvent: selectedEvent,
        events: state.totalEvents,
      ));
    } else {
      emit(SearchInitial());
      focusNode.requestFocus();
    }
  }

  @override
  Future<void> close() {
    focusNode.dispose();
    searchInputController.dispose();
    return super.close();
  }
}
