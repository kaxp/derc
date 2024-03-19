part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState({
    this.totalEvents,
    this.selectedEvent,
  });

  final List<Event>? totalEvents;

  final Event? selectedEvent;

  @override
  List<Object?> get props => [
        totalEvents,
        selectedEvent,
      ];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResultLoaded extends SearchState {
  const SearchResultLoaded({
    required List<Event> events,
  }) : super(
          totalEvents: events,
        );
}

class SearchResultEmpty extends SearchState {
  const SearchResultEmpty({
    required List<Event> events,
  }) : super(
          totalEvents: events,
        );
}

class SearchResultError extends SearchState {
  const SearchResultError({
    required this.exception,
    required this.message,
  });

  final Object? exception;
  final String message;

  @override
  List<Object?> get props => [
        exception,
        message,
        ...super.props,
      ];
}

class SearchShowEventDetail extends SearchState {
  const SearchShowEventDetail({
    required Event selectedEvent,
    required List<Event>? events,
  }) : super(
          selectedEvent: selectedEvent,
          totalEvents: events,
        );
}

class SearchBuyEventTicket extends SearchState {
  const SearchBuyEventTicket({
    required Event selectedEvent,
    required List<Event>? events,
  }) : super(
          selectedEvent: selectedEvent,
          totalEvents: events,
        );
}
