import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';

EventsResponse buildEventsResponseFromTemplate({
  List<Event>? events,
  MetaData? meta,
}) {
  return EventsResponse(
    events: events!,
    meta: meta!,
  );
}
