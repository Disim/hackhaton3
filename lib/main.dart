import 'package:flutter/material.dart';
import 'package:hackaton3/pages/login_page/login_page.dart';
import 'package:hackaton3/pages/main_page/main_page.dart';
import 'package:hackaton3/pages/register_page/register_page.dart';
import 'package:hackaton3/pages/splash_page.dart';
import 'package:hackaton3/theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Hackaton',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        initialRoute: '/login_page',
        routes: {
          '/': (_) => const SplashPage(),
          '/login_page': (_) => const LoginPage(),
          '/register_page': (_) => const RegisterPage(),
          '/main_page': (_) => const MainPage(),
        },
      ),
    );
  }
}
