# DERC

## Getting Started

This application is developed on Flutter v3.16.3 in the Stable channel.

# Project tree

```bash
|-- lib/
  |-- components
  |   ├── atoms/
  |   ├── molecules/
  |   └── organisms/
  |-- config
  |   ├── themes/
  |   └── flavor_config.dart
  |-- constants/
  |-- modules
  |   ├── app
  |   |   └── base_app_module.dart
  |   ├── home
  |   |   ├── bloc/
  |   |   ├── models/
  |   |   ├── pages/
  |   |   ├── repositories/
  |   |   ├── widgets/
  |   |   └── home_module.dart
  |   ├── search
  |   |   ├── bloc/
  |   |   ├── listener/
  |   |   ├── models/
  |   |   ├── pages/
  |   |   ├── widgets/
  |   |   └── search_module.dart
  |-- networking
  |   ├── constants/
  |   ├── interceptors/
  |   ├── models/
  |   ├── retrofit/
  |   └── http_client.dart
  |-- utils/
  |-- main_base.dart
  |-- main_mock.dart
  |-- main_staging.dart
  └── main.dart
|-- test/
  |-- mocks/
  |   |-- bloc/
  |   |    |-- mock_blocs.dart
  |   |    └── mock_blocs.mocks.dart
  |   |-- models/
  |   |    └── test_models_builder.dart
  |   |-- repositories/
  |   |    |-- mock_repositories.dart
  |   |    └── mock_repositories.mocks.dart
  |   └── services/
  |   |    |-- mock_services.dart
  |   |    └── mock_services.mocks.dart
  |-- modules
  |   ├── home
  |   |   ├── bloc/
  |   |   └── pages/
  |   ├── search
  |   |   ├── bloc/
  |   |   └── manager/
  |-- networking
  |   |   └── http_client_test.dart
  |-- test_utils
  |   |   └── mock_dio_error.dart
  └── utils
      └── dio_error_extension_test.dart
```

# Project Setup:

- State-management- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- Navigation - [flutter_modular](https://pub.dev/packages/flutter_modular)
- Dependency Injection - [flutter_modular](https://pub.dev/packages/flutter_modular)
- Localization - [easy_localization](https://pub.dev/packages/easy_localization)
- Model classes - [json_serializable](https://pub.dev/packages/json_serializable) and [equatable](https://pub.dev/packages/equatable)
- Unit And Widget testing - flutter_test, [modular_test](https://pub.dev/packages/modular_test)
- Testing Mocks- [mockito](https://pub.dev/packages/mockito)
- Http client - [dio](https://pub.dev/packages/dio) with [retrofit](https://pub.dev/packages/retrofit) as dio client generator

### Steps for running the application-

1. Open the project folder `derc` in choice of code editor
2. run `flutter pub get`
3. run `flutter pub run build_runner build`
4. run the application on android device
   - `flutter run --release`

### Other Informations

1. Some Intended behaviours in the app
   - The system back navigation on StackManager is disabled.
   - No auto search (debounce)
   - In StackManager while searching the events, we are only fetching Page 1 data now.
   - Once a expanded stack is collapsed, the state will be lost i.e If we move from 3rd stack to 1st then the state of 2nd and 3rd stack will be lost.
   - Screenshots and video recording of the app can be found in project/screenshots directory

### Thank you :)
