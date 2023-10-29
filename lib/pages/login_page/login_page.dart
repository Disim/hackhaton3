import 'package:flutter/material.dart';
import 'package:hackaton3/elements/constants_elements.dart';
import 'package:hackaton3/elements/buttons.dart';
import 'package:hackaton3/main.dart';
import 'package:hackaton3/pages/login_page/login_logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(margin),
            child: Center(
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Авторизация',
                      style: headline1,
                    ),
                    Icon(
                      Icons.face,
                    ),
                    Container(
                      padding: EdgeInsets.all(margin),
                      decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: highRad),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: 'Электронная почта'),
                            validator: (String? value) {
                              if (emailController.text.isNotEmpty) {
                                return null;
                              }
                              return 'Введите почту';
                            },
                          ),
                          SizedBox(
                            height: margin,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration:
                                const InputDecoration(hintText: 'Пароль'),
                            validator: (String? value) {
                              if (passwordController.text.isNotEmpty) {
                                return null;
                              }
                              return 'Введите пароль';
                            },
                          ),
                          SizedBox(
                            height: margin,
                          ),
                          ClassicButton(
                            'Войти',
                            () {
                              if (formKey.currentState!.validate()) {
                                loginButton(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: margin,
                          ),
                          TextButton(
                              onPressed: () {
                                navigatorKey.currentState!
                                    .pushNamed('/register_page');
                              },
                              child: Text('Создать аккаунт'))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
