import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/modules/search/pages/search_page.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  IModularNavigator,
], customMocks: [
  MockSpec<SearchPage>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {}
