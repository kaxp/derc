import 'package:kapil_sahu_cred/modules/app/base_app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';

class SearchModule extends BaseAppModule {
  @override
  List<Bind> get binds => [
        // SearchBloc should not be singleton, as we require
        // new instance when user start the search every time
        Bind<SearchBloc>(
          (_) => SearchBloc(),
          isSingleton: false,
        ),
      ];
}
