import 'package:flutter/material.dart';
import 'package:hackaton3/app/models/organization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hackaton3/main.dart';

late Box<dynamic> box;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool first = true;

  Future<void> checkLogin() async {
    await Hive.initFlutter();
    await organization.getProfile();

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentContext!, '/login_page', (route) => false));
    // navigatorKey.currentContext!, '/main_page', (route) => false));
  }

  @override
  void initState() {
    super.initState();
    if (first) {
      first = false;
      checkLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
