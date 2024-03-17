import 'package:kapil_sahu_cred/config/flavor_config.dart';

class NetworkConstants {
  static String prodBaseUrl = 'https://api.seatgeek.com/2';
  static String prodClientId = 'MzM2NDA4MTZ8MTY4Mzk0NzE4MS44OTEwNjYz';

  static String stagingBaseUrl = 'https://api.seatgeek.com/2';
  static String stagingClientId = 'MzM2NDA4MTZ8MTY4Mzk0NzE4MS44OTEwNjYz';

  static String mockServerUrl = 'https://api.seatgeek.com/2';
  static String mockServerClientId = 'sample_client_id_for_mock_server';

  static final String baseUrl = FlavorConfig.instance!.values.baseUrl;
  static final String clientId = FlavorConfig.instance!.values.clientId;
}
