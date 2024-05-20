# DERC
This application is developed on Flutter v3.16.3 in the Stable channel.

### Objective
To develop an abstraction layer for a stack framework supporting the expand & collapse state of view, Using that abstraction layer you can create one sample stack view implementation shown in the below video.

https://github.com/kaxp/derc/assets/25891817/8fb65546-83f3-497c-954b-606a9077e2a3


### Things to make sure:
1. All stack views should have two states(Expanded and collapsed).
2. Clicking on any collapsed view toggles its state i.e. it expands and the other expanded view collapses.
    > For example, If 4 stacks are expanded and the user taps stack number 2 then stack 2 comes into view and stacks 3 and 4 gets collapsed.
4. Framework can have a maximum of 4 stacks and a minimum of 2 stacks.
5. Any assumptions made should be called out explicitly.


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

### Main project implementation files:
  Stack View Framework - [stack_view_manager.dart](https://github.com/kaxp/derc/blob/master/lib/components/organisms/stack_view_manager/stack_view_manager.dart)
  
  Stack View Framework test - [stack_view_manager_test.dart](https://github.com/kaxp/derc/blob/master/test/modules/search/manager/stack_view_manager_test.dart)
  

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

1. Clone the project using the command `git clone https://github.com/kaxp/derc.git`
2. run `flutter pub get`
3. run `flutter pub run build_runner build`
4. run the application on Android device
   - `flutter run --release`

### Assumptions

1. Some Intended behaviours in the app
   - The system back navigation on StackManager is disabled.
   - No auto search (debounce)
   - In StackManager while searching the events, we are only fetching Page 1 data now.
   - Once an expanded stack is collapsed, its state will be lost i.e. If we move from the 3rd stack to the 1st then the state of the 2nd and 3rd stack will be lost.


### Screenshots

<img height = "350" src = "https://github.com/kaxp/derc/assets/25891817/12c5be3b-3910-40a3-8904-c61fa9c06455"> <img height = "350" src = "https://github.com/kaxp/derc/assets/25891817/25bd7b0c-5d03-409b-950d-5543fd33a529"> <img height = "350" src = "https://github.com/kaxp/derc/assets/25891817/3c6968e0-1e6c-46fe-aea2-8d020e61520e"> <img height = "350" src = "https://github.com/kaxp/derc/assets/25891817/085e1770-7cc0-4d2c-9957-dabcd1b9c10b"> <img height = "350" src = "https://github.com/kaxp/derc/assets/25891817/99914894-bdbf-4561-b117-506a6011768f">

### Screen Recording
https://github.com/kaxp/derc/assets/25891817/9aa8914c-168b-4530-8992-635b4ec4d4fe

