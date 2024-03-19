import 'package:kapil_sahu_cred/modules/app/base_app_module.dart';
import 'package:kapil_sahu_cred/modules/home/bloc/home_bloc.dart';
import 'package:kapil_sahu_cred/modules/home/pages/home_page.dart';
import 'package:kapil_sahu_cred/modules/home/repositories/home_repo.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends BaseAppModule {
  @override
  List<Bind> get binds => [
        Bind<HomeRepo>((_) => HomeRepo()),
        Bind<HomeBloc>((_) => HomeBloc()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const HomePage(),
        ),
      ];
}

class HomeRoute {
  static const String moduleRoute = '/';
}
