import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/home/repositories/home_repo.dart';
import 'package:kapil_sahu_cred/modules/search/models/stack_view_model.dart';

part 'search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchInitial());

  final HomeRepo _homeRepo = Modular.get<HomeRepo>();

  int currentStackIndex = 0;
  Event? selectedEvent;
  final Map<int, StackViewModel> stackView = {};

  /// Search for events based on query.
  void searchEvents(String query) async {
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
      emit(SearchResultFailed(exception: error, message: error.toString()));
    }
  }

  /// Show details of the selected event.
  void showEventDetail(Event event) {
    emit(SearchEventDetail(selectedEvent: event, events: state.totalEvents));
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
        emit(SearchEventDetail(
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
        emit(SearchEventDetail(
            events: state.totalEvents, selectedEvent: state.selectedEvent!));
        break;
      case 3:
        emit(SearchBuyEventTicket(
            events: state.totalEvents, selectedEvent: state.selectedEvent!));
        break;
      default:
      // Close bottomSheet
    }
  }

  /// Set initial state, optionally with selected event.
  void setInititalState(Event? selectedEvent) {
    if (selectedEvent != null) {
      emit(SearchEventDetail(
        selectedEvent: selectedEvent,
        events: state.totalEvents,
      ));
    } else {
      emit(SearchInitial());
    }
  }
}