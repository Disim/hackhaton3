import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hackaton3/datas/api_provider.dart';
import 'package:hackaton3/elements/constants_elements.dart';
import 'package:hackaton3/main.dart';
import 'package:hackaton3/pages/main_page/main_page_logics.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddFileButton extends StatelessWidget {
  const AddFileButton(this.onTap, {super.key});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: margin),
      child: InkWell(
        borderRadius: mediumRad,
        onTap: () {
          onTap();
        },
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: mediumRad,
              border: Border.all(color: borderColor)),
          child: const Center(child: Icon(Icons.attach_file)),
        ),
      ),
    );
  }
}

class FileButton extends StatelessWidget {
  const FileButton(this.file,
      {this.canDownload = false, this.tapClose, this.margin = 10, super.key});
  final String file;
  final double margin;
  final Function? tapClose;
  final bool canDownload;

  @override
  Widget build(BuildContext context) {
    String fileName = file.split('/').last;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: borderColor), borderRadius: mediumRad),
        margin: EdgeInsets.only(right: margin),
        padding: EdgeInsets.all(margin),
        height: 150,
        width: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                      visible: canDownload,
                      child: IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () async {
                          if (canDownload) {
                            String? selectedDirectory =
                                await FilePicker.platform.getDirectoryPath();
                            if (selectedDirectory != null) {
                              await ApiProvider.dio.download(
                                file,
                                '$selectedDirectory/$fileName',
                              );
                            }
                          }
                        },
                      )),
                  Visibility(
                    visible: !canDownload,
                    child: const Icon(Icons.file_present_outlined),
                  ),
                  Text(fileName),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Visibility(
                visible: tapClose != null,
                child: IconButton(
                    onPressed: () {
                      tapClose!();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red.shade400,
                    )),
              ),
            ),
          ],
        ));
  }
}

pickAttachments({
  required String fileController,
  required TextEditingController messageFieldController,
  required BuildContext context,
}) {
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
                  Text(
                    'Файл',
                    style: headline3,
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (messageFieldController.text != '' ||
                              fileController.isNotEmpty) {
                            final sendingMessage = messageFieldController.text;
                            print(
                                '$sendingMessage ${messageFieldController.text}');
                            messageFieldController.clear();
                            await sendFile(
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
