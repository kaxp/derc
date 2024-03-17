import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/config/themes/app_theme.dart';
import 'package:kapil_sahu_cred/constants/widget_keys.dart';
import 'package:kapil_sahu_cred/modules/app/base_app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

/// Initialize BaseAppModule for unit and widget testing
Future<BaseAppModule> initTestAppModule({
  List<Bind>? replaceBinds,
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final module = BaseAppModule();
  WidgetsFlutterBinding.ensureInitialized();

  initModule(module, replaceBinds: [
    ...?replaceBinds,
  ]);

  Modular.init(module);
  return module;
}

/// TestApp for performing widget tests
///
/// Usage:
/// ```
///   testWidgets('description', (tester) async {
///    final appModule = await initTestAppModule();
///
///    await tester.pumpWidget(TestApp(child: SomePage()));
///
///    expect(find.text('Some text'), findsWidgets);
///  });
///
/// ```
class TestApp extends StatelessWidget {
  const TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DERC',
      theme: AppTheme.defaultTheme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: WidgetKeys.rootScaffoldMessengerKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
