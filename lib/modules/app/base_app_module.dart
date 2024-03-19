import 'package:kapil_sahu_cred/modules/home/home_module.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';
import 'package:kapil_sahu_cred/networking/constants/network_constants.dart';
import 'package:kapil_sahu_cred/networking/http_client.dart';
import 'package:kapil_sahu_cred/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// [BaseAppModule] is the primary module that will hold all the common
/// dependencies
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

        // SearchBloc should not be singleton, as we require
        // new instance when user start the search every time
        Bind<SearchBloc>(
          (_) => SearchBloc(),
          isSingleton: false,
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
}
