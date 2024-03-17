import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/networking/retrofit/home_api_client.dart';

class HomeRepo {
  final HomeApiClient _homeApiClient = HomeApiClient.withDefaultDio();

  Future<EventsResponse> fetchEventsData({
    required String searchString,
    required int page,
  }) async {
    return _homeApiClient.getEventsData(
      search: searchString,
      page: page,
    );
  }
}
