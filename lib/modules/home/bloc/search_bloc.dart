import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/home/repositories/home_repo.dart';

part 'search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchInitial());

  final _homeRepo = Modular.get<HomeRepo>();

  /// [searchEvents] method is used for fetching the event data
  /// on user search.
  void searchEvents(String query) async {
    try {
      emit(SearchLoading());

      final response = await _homeRepo.fetchEventsData(
        searchString: query,
        page: 1, // only fetching 1st page data.
      );

      if (response.events.isNotEmpty) {
        emit(
          SearchResultLoaded(
            events: response.events,
          ),
        );
      } else {
        emit(SearchResultEmpty(
          events: response.events,
        ));
      }
    } on DioException catch (error) {
      emit(SearchResultFailed(
        exception: error,
        message: error.toString(),
      ));
    }
  }

  void showEventDetail(Event event) {
    emit(SearchEventDetail(selectedEvent: event, events: state.totalEvents));
  }

  void onEmptyViewSubmit() {
    emit(SearchInitial());
  }

  void onEventDetailSubmit() {
    emit(SearchBuyEventTicket(
      events: state.totalEvents,
      selectedEvent: state.selectedEvent!,
    ));
  }

  void onStackChange(int stackIndex, int totalStackCount) {
    if (totalStackCount == 2) {
      switch (stackIndex) {
        case 0:
          emit(SearchEventDetail(
            events: state.totalEvents,
            selectedEvent: state.selectedEvent!,
          ));
          break;
        case 1:
          emit(SearchBuyEventTicket(
            events: state.totalEvents,
            selectedEvent: state.selectedEvent!,
          ));
          break;
        default:
        // close bottomSheet
      }
    } else {
      switch (stackIndex) {
        case 0:
          emit(SearchInitial());
          break;
        case 1:
          emit(SearchResultLoaded(
            events: state.totalEvents!,
          ));
          break;
        case 2:
          emit(SearchEventDetail(
            events: state.totalEvents,
            selectedEvent: state.selectedEvent!,
          ));
          break;
        case 3:
          emit(SearchBuyEventTicket(
            events: state.totalEvents,
            selectedEvent: state.selectedEvent!,
          ));
          break;
        default:
        // close bottomSheet
      }
    }
  }

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
