import 'package:kapil_sahu_cred/config/flavor_config.dart';
import 'package:kapil_sahu_cred/modules/app/base_app_module.dart';
import 'package:kapil_sahu_cred/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  final expectedBaseParams = <String, dynamic>{
    'client_id': 'sample_client_id_for_mock',
  };

  setUpAll(() {
    FlavorConfig(
      flavor: Flavor.mock,
      values: const FlavorValues(
        baseUrl: '',
        clientId: '',
      ),
    );
  });

  setUp(() async {
    initModule(BaseAppModule());
  });

  test(
    '''Given the AppDio get bind into the BaseAppModule 
       When the appDio internal member noAuthDio get constructed 
       Then it should contains all the specific params
    ''',
    () async {
      final appDio = Modular.get<AppDio>();

      final paramKey = expectedBaseParams.keys;
      final paramValue = expectedBaseParams[paramKey];

      expect(appDio.noAuthDio.options.queryParameters[paramKey], paramValue);
    },
  );
}
