import 'package:kapil_sahu_cred/modules/home/home_module.dart';
import 'package:kapil_sahu_cred/networking/constants/network_constants.dart';
import 'package:kapil_sahu_cred/networking/http_client.dart';
import 'package:kapil_sahu_cred/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaseAppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<AppDio>(
          (i) => AppDio(
            noAuthDio: httpClient(
              clientId: NetworkConstants.clientId,
            ),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          BaseAppModuleRoutes.homePage,
          module: HomeModule(),
        ),
      ];
}

class BaseAppModuleRoutes {
  static const String homePage = '/';
  static const String detailPage = '/detail/';
}
