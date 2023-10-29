import 'package:flutter/material.dart';
import 'package:hackaton3/elements/constants_elements.dart';
import 'package:hackaton3/elements/buttons.dart';
import 'package:hackaton3/pages/register_page/register_logic.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(margin),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Регистрация',
                        style: headline1,
                      ),
                    ),
                    const Icon(Icons.create_outlined),
                    Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: 'Название организации'),
                          validator: (String? value) {
                            if (passwordController.text.isNotEmpty) {
                              return null;
                            }
                            return 'Введите название';
                          },
                        ),
                        const SizedBox(
                          height: margin,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: 'Электронная почта'),
                          validator: (String? value) {
                            if (emailController.text.isNotEmpty) {
                              return null;
                            }
                            return 'Введите почту';
                          },
                        ),
                        const SizedBox(
                          height: margin,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(hintText: 'Пароль'),
                          validator: (String? value) {
                            if (passwordController.text.isNotEmpty) {
                              return null;
                            }
                            return 'Введите пароль';
                          },
                        ),
                        const SizedBox(
                          height: margin,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: repeatPasswordController,
                          decoration: const InputDecoration(
                              hintText: 'Подтвердите пароль'),
                          validator: (String? value) {
                            //TODO: Проверять на совпадение
                            if (passwordController.text.isNotEmpty) {
                              if (passwordController.text == value) {
                                return null;
                              }
                              return 'Пароли должны совпадать';
                            }
                            return 'Введите пароль ещё раз';
                          },
                        ),
                        const SizedBox(
                          height: margin,
                        ),
                        const Text(
                            'После нажатия кнопки "Регистрация" проверьте электронную почту для подтверждения аккаунта'),
                        const SizedBox(
                          height: margin,
                        ),
                        ClassicButton('Регистрация', () {
                          if (formKey.currentState!.validate()) {
                            print('object');
                            registerButton(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        }),
                      ],
                    ),
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
