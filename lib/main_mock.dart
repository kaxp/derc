import 'package:kapil_sahu_cred/config/flavor_config.dart';
import 'package:kapil_sahu_cred/main_base.dart';
import 'package:kapil_sahu_cred/networking/constants/network_constants.dart';

void main() async {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.mock,
      values: FlavorValues(
        baseUrl: NetworkConstants.mockServerUrl,
        clientId: NetworkConstants.mockServerClientId,
      ),
    ),
    dumpErrorToConsole: true,
  );
}
