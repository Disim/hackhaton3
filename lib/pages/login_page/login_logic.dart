import 'package:hackaton3/app/models/organization.dart';
import 'package:hackaton3/datas/api_provider.dart';
import 'package:hackaton3/main.dart';

loginButton(String email, String password) async {
  Organization organization =
      Organization(name: '', email: email, password: password);
  final result = await ApiProvider.login(organization);
  print(result.name);

  if (result.name != '') {
    print(result.email);
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/main_page', (route) => false);
  }
}
