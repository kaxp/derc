import 'package:kapil_sahu_cred/config/flavor_config.dart';
import 'package:kapil_sahu_cred/networking/constants/network_constants.dart';
import 'main_base.dart';

void main() async {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.staging,
      values: FlavorValues(
        baseUrl: NetworkConstants.stagingBaseUrl,
        clientId: NetworkConstants.stagingClientId,
      ),
    ),
    dumpErrorToConsole: true,
  );
}
