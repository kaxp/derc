// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'events_response.g.dart';

@JsonSerializable()
class EventsResponse extends Equatable {
  const EventsResponse({
    required this.events,
    required this.meta,
  });

  final List<Event> events;
  final MetaData meta;

  factory EventsResponse.fromJson(Map<String, dynamic> json) =>
      _$EventsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventsResponseToJson(this);

  @override
  List<Object?> get props => [events, meta];
}

@JsonSerializable()
class Event extends Equatable {
  const Event({
    required this.id,
    required this.performers,
    required this.datetimeLocal,
    required this.title,
    required this.venue,
  });

  final int id;
  final List<Performer> performers;
  @JsonKey(name: 'datetime_local')
  final DateTime datetimeLocal;
  final String title;
  final Venue venue;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [id, performers, datetimeLocal, title, venue];
}

@JsonSerializable()
class Performer extends Equatable {
  const Performer({
    required this.image,
  });

  final String? image;

  factory Performer.fromJson(Map<String, dynamic> json) =>
      _$PerformerFromJson(json);

  Map<String, dynamic> toJson() => _$PerformerToJson(this);

  @override
  List<Object?> get props => [image];
}

@JsonSerializable()
class Venue extends Equatable {
  const Venue({
    required this.city,
    required this.state,
  });

  final String? city;
  final String? state;

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  Map<String, dynamic> toJson() => _$VenueToJson(this);

  @override
  List<Object?> get props => [city, state];
}

@JsonSerializable()
class MetaData extends Equatable {
  const MetaData({
    required this.total,
    required this.page,
    required this.perPage,
  });

  final int total;
  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);

  @override
  List<Object?> get props => [total, page, perPage];
}
