import 'package:kapil_sahu_cred/config/flavor_config.dart';
import 'package:kapil_sahu_cred/modules/app/base_app_module.dart';
import 'package:kapil_sahu_cred/modules/home/home_module.dart';
// import 'package:kapil_sahu_cred/modules/home/bloc/home_bloc.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/home/repositories/home_repo.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kapil_sahu_cred/modules/search/bloc/search_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

import '../../../mocks/bloc/mock_blocs.mocks.dart';
import '../../../mocks/models/test_models_builder.dart';
import '../../../mocks/repositories/mock_repositories.mocks.dart';
import '../../../test_utils/mock_dio_exception.dart';

EventsResponse _defaultEventsResponse() {
  return buildEventsResponseFromTemplate(
    events: [
      Event(
          id: 1,
          performers: const [
            Performer(
              image: '',
            )
          ],
          datetimeLocal: DateTime.now(),
          title: 'Some title',
          venue: const Venue(city: 'City 1', state: 'State 1')),
      Event(
          id: 1,
          performers: const [
            Performer(
              image: '',
            )
          ],
          datetimeLocal: DateTime.now(),
          title: 'Some title',
          venue: const Venue(city: 'City 1', state: 'State 1')),
    ],
    meta: const MetaData(total: 30, page: 1, perPage: 10),
  );
}

EventsResponse _defaultEmptyEventsResponse() {
  return buildEventsResponseFromTemplate(
    events: [],
    meta: const MetaData(total: 30, page: 1, perPage: 10),
  );
}

void main() async {
  late MockSearchBloc _mockSearchBloc;
  late MockHomeRepo _mockHomeRepo;

  setUpAll(() {
    FlavorConfig(
      flavor: Flavor.mock,
      values: const FlavorValues(
        baseUrl: '',
        clientId: '',
      ),
    );
    _mockHomeRepo = MockHomeRepo();
    _mockSearchBloc = MockSearchBloc();
    when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
        .thenAnswer((_) => Future.value(_defaultEventsResponse()));
  });

  setUp(() async {
    initModule(BaseAppModule(), replaceBinds: [
      Bind<SearchBloc>((_) => _mockSearchBloc),
      Bind<HomeRepo>((_) => _mockHomeRepo),
    ]);
    initModule(HomeModule(), replaceBinds: [
      Bind<HomeRepo>((_) => _mockHomeRepo),
    ]);
  });

  group('fetch event data from searchEvents method', () {
    test('''Given searchEvents() is called and state is SearchInitial
        When value of searchString is empty 
        And searchEventsData method return the result
        Then state should change to HomeLoaded''', () async {
      final bloc = SearchBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: '', page: 1))
          .thenAnswer((_) => Future.value(_defaultEventsResponse()));

      await bloc.searchEvents('');
      expect(bloc.state, isA<SearchResultLoaded>());
    });

    test('''Given searchEvents() is called and state is SearchInitial
        When value of searchString is "Hello"
        And searchEventsData method return the result
        Then state should change to HomeLoaded''', () async {
      final bloc = SearchBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultEventsResponse()));

      await bloc.searchEvents('Hello');
      expect(bloc.state, isA<SearchResultLoaded>());
    });

    test('''Given searchEvents() is called and state is SearchInitial
        When value of searchString is "Hello"
        And searchEventsData method return empty event list
        Then state should change to HomeEmpty''', () async {
      final bloc = SearchBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultEmptyEventsResponse()));

      await bloc.searchEvents('Hello');
      expect(bloc.state, isA<SearchResultEmpty>());
    });

    test('''Given searchEvents() is called and state is SearchInitial
        When value of searchString is "Hello"
        And searchEventsData method throw DioException
        Then state should change to HomeError''', () async {
      final bloc = SearchBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer(
        (_) async => throw MockDioException(),
      );

      await bloc.searchEvents('Hello');
      expect(bloc.state, isA<SearchResultError>());
    });
  });
}
