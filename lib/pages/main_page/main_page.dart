import 'package:flutter/material.dart';
import 'package:hackaton3/elements/constants_elements.dart';
import 'package:hackaton3/main.dart';
import 'package:hackaton3/pages/main_page/main_page_elements.dart';
import 'package:hackaton3/pages/main_page/main_page_logics.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String fileController = '';
  String questionTxt = '';
  String ansverTxt = '';
  TextEditingController messageFieldController = TextEditingController();

  final TextFormField inputField = TextFormField();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Вопрос',
                          style: headline2,
                        ),
                        Text(questionTxt)
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Ответ',
                          style: headline3,
                        ),
                        Text(ansverTxt)
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: margin),
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          pickAttachments(
                            fileController: fileController,
                            messageFieldController: messageFieldController,
                            context: navigatorKey.currentContext!,
                          ).whenComplete(() => setState(() {}));
                        },
                        icon: const Icon(Icons.file_present),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: messageFieldController,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'Введите сообщение...',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (messageFieldController.text != '') {
                            final sendingMessage = messageFieldController.text;
                            messageFieldController.clear();
                            ansverTxt = await sendMessage(
                              sendingMessage,
                            );
                            questionTxt = sendingMessage;
                            fileController = '';
                          }
                          setState(() {});
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
