import 'package:flutter/foundation.dart';
import 'package:kapil_sahu_cred/config/flavor_config.dart';
import 'package:kapil_sahu_cred/networking/constants/network_constants.dart';
import 'main_base.dart';

void main() async {
  // disable debug print on production release mode
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.production,
      values: FlavorValues(
        baseUrl: NetworkConstants.prodBaseUrl,
        clientId: NetworkConstants.prodClientId,
      ),
    ),
    dumpErrorToConsole: false,
  );
}
