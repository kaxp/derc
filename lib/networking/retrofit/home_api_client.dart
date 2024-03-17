import 'package:dio/dio.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/networking/constants/network_constants.dart';
import 'package:kapil_sahu_cred/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';

@RestApi()
abstract class HomeApiClient {
  factory HomeApiClient.withDefaultDio({String? baseUrl}) {
    return HomeApiClient(
      Modular.get<AppDio>().noAuthDio,
      baseUrl: NetworkConstants.baseUrl,
    );
  }

  factory HomeApiClient(Dio dio, {String? baseUrl}) {
    return _HomeApiClient(
      dio,
      baseUrl: NetworkConstants.baseUrl,
    );
  }

  @GET('/events')
  Future<EventsResponse> getEventsData({
    @Query('q') required String search,
    @Query('page') required int page,
  });
}
