import 'package:flutter/material.dart';
import 'package:hackaton3/elements/constants_elements.dart';
import 'package:hackaton3/main.dart';
import 'package:hackaton3/pages/main_page/main_page_elements.dart';
import 'package:hackaton3/pages/main_page/main_page_logics.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String fileController = '';
  TextEditingController messageFieldController = TextEditingController();

  final TextFormField inputField = TextFormField();
  pickAttachments(BuildContext context) {
    return showBarModalBottomSheet(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return BottomSheet(
          enableDrag: false,
          onClosing: () {},
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(navigatorKey.currentContext!)
                        .viewInsets
                        .bottom,
                    left: margin,
                    right: margin,
                    top: margin),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ФАЙЛЫ'),
                    SizedBox(
                        height: 150,
                        child: fileController.isNotEmpty
                            ? FileButton(fileController, tapClose: () {
                                setState(() {
                                  fileController = '';
                                });
                              })
                            : AddFileButton(
                                () async {
                                  fileController =
                                      await pickFile(fileController, setState);
                                  setState(() {});
                                  print('fileController: $fileController');
                                },
                              )),
                    const SizedBox(height: margin),
                    Row(
                      children: [
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
                            if (messageFieldController.text != '' ||
                                fileController.isNotEmpty) {
                              final sendingMessage =
                                  messageFieldController.text;
                              print(
                                  '$sendingMessage ${messageFieldController.text}');
                              messageFieldController.clear();
                              await sendMessage(
                                sendingMessage,
                                fileController,
                              );
                              fileController = '';
                              Navigator.pop(navigatorKey.currentContext!);
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

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
                    Text(
                      'Впорос',
                      style: headline2,
                    ),
                    Text(
                      'Ответ',
                      style: headline3,
                    ),
                    SizedBox(),
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
                          pickAttachments(navigatorKey.currentContext!)
                              .whenComplete(() => setState(() {}));
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
                          // if (messageFieldController.text != '') {
                          //   final sendingMessage =
                          //       messageFieldController.text;
                          //   messageFieldController.clear();
                          //   appeal.messages.clear();
                          //   await sendMessage(
                          //     appeal.id,
                          //     sendingMessage,
                          //     [],
                          //     [],
                          //   );
                          //   await getMessages(appeal);
                          //   setState(() {});
                          // }
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
