// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsResponse _$EventsResponseFromJson(Map<String, dynamic> json) =>
    EventsResponse(
      events: (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventsResponseToJson(EventsResponse instance) =>
    <String, dynamic>{
      'events': instance.events,
      'meta': instance.meta,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as int,
      performers: (json['performers'] as List<dynamic>)
          .map((e) => Performer.fromJson(e as Map<String, dynamic>))
          .toList(),
      datetimeLocal: DateTime.parse(json['datetime_local'] as String),
      title: json['title'] as String,
      venue: Venue.fromJson(json['venue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'performers': instance.performers,
      'datetime_local': instance.datetimeLocal.toIso8601String(),
      'title': instance.title,
      'venue': instance.venue,
    };

Performer _$PerformerFromJson(Map<String, dynamic> json) => Performer(
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PerformerToJson(Performer instance) => <String, dynamic>{
      'image': instance.image,
    };

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
      city: json['city'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
    };

MetaData _$MetaDataFromJson(Map<String, dynamic> json) => MetaData(
      total: json['total'] as int,
      page: json['page'] as int,
      perPage: json['per_page'] as int,
    );

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'per_page': instance.perPage,
    };
