import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kapil_sahu_cred/components/atoms/buttons/default_elevated_button.dart';
import 'package:kapil_sahu_cred/components/atoms/typography/header2.dart';
import 'package:kapil_sahu_cred/components/molecules/app_bar/custom_appbar.dart';
import 'package:kapil_sahu_cred/components/molecules/states/empty_state_view.dart';
import 'package:kapil_sahu_cred/config/flavor_config.dart';
import 'package:kapil_sahu_cred/constants/app_strings.dart';
import 'package:kapil_sahu_cred/modules/home/bloc/home_bloc.dart';
import 'package:kapil_sahu_cred/modules/home/home_module.dart';
import 'package:kapil_sahu_cred/modules/home/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../mocks/bloc/mock_blocs.mocks.dart';
import '../../../mocks/services/mock_services.mocks.dart';

void main() {
  late MockHomeBloc _mockHomeBloc;
  MockSearchPage _searchPage = MockSearchPage();

  setUpAll(() async {
    FlavorConfig(
      flavor: Flavor.mock,
      values: const FlavorValues(
        baseUrl: '',
        clientId: '',
      ),
    );
    _mockHomeBloc = MockHomeBloc();
    await initializeDateFormatting();
  });

  setUp(() async {
    initModule(HomeModule(), replaceBinds: [
      Bind<HomeBloc>((_) => _mockHomeBloc),
    ]);
  });

  testWidgets('''Given HomePage is first opened
    When state is HomeInitial
    Then HomePage is rendered as expected''', (tester) async {
    when(_mockHomeBloc.state).thenAnswer((_) => HomeInitial());

    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(HomeError), findsOneWidget);

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(
        find.widgetWithText(Header2, AppStrings.noDataFound), findsOneWidget);
  });

  testWidgets('''Given HomePage is first opened
    When state is HomeEmpty
    Then HomePage is rendered as expected''', (tester) async {
    when(_mockHomeBloc.state).thenAnswer((_) => HomeEmpty());

    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(EmptyStateView), findsOneWidget);

    expect(find.byType(SvgPicture), findsOneWidget);

    expect(
        find.widgetWithText(Header2, AppStrings.noResultFound), findsOneWidget);
  });

  testWidgets('''Given HomePage is first opened
    When state is HomeSearchEnabled
    Then searchEventsAroundYou button is enabled''', (tester) async {
    when(_mockHomeBloc.state).thenAnswer(
      (_) => const HomeSearchEnabled(
        events: [],
        hasReachedEnd: false,
        page: 1,
        totalPage: 10,
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that showModalBottomSheet is not opened initially
    verifyNever(_searchPage.showSearchView(
      context: anyNamed('context'),
      onStackDismissed: () {},
      totalStackCount: 4,
    ));
    expect(find.byType(BottomSheet), findsNothing);

    await tester.tap(
      find.widgetWithText(
        DefaultElevatedButton,
        AppStrings.searchEventsAroundYou,
      ),
    );
  });
}
