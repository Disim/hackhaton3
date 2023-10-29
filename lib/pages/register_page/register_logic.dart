import 'package:hackaton3/app/models/organization.dart';
import 'package:hackaton3/datas/api_provider.dart';
import 'package:hackaton3/main.dart';

registerButton(String name, String email, String password) async {
  Organization organization =
      Organization(name: name, email: email, password: password);
  final result = await ApiProvider.register(organization);
  print(result);

  if (result.email.isNotEmpty) {
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil('/login_page', (route) => false);
  }
}
