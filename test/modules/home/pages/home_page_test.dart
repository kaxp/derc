import 'package:flutter/material.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header2.dart';
import 'package:kapil_sahu_cred/components/molecules/app_bar/custom_appbar.dart';
import 'package:kapil_sahu_cred/components/molecules/search_input_box/custom_search_input_box.dart';
import 'package:kapil_sahu_cred/config/flavor_config.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/modules/home/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils/init_test_module_helper.dart';

void main() {
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
    await initTestAppModule();
  });

  testWidgets('''Given HomePage is first opened
    When state is HomeInitial
    Then HomePage is rendered as expected''', (tester) async {
    await tester.pumpWidget(
      const TestApp(
        child: HomePage(),
      ),
    );
    // await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.image(const AssetImage(AppImages.appLogo)), findsOneWidget);

    expect(find.byType(CustomSearchInputBox), findsOneWidget);
    // expect(find.byType(HomeInitialView), findsOneWidget);

    // expect(find.byType(Icon), findsOneWidget);
    // expect(
    //     find.byIcon(Icons.sentiment_very_satisfied_outlined), findsOneWidget);

    expect(find.byType(Header2), findsOneWidget);
    // expect(find.text(AppStrings.searchForEvents), findsOneWidget);

    //TODO(kaxp): Add more widget test for Home Page.
  });
}
