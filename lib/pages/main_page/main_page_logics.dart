import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hackaton3/datas/api_paths.dart';
import 'package:hackaton3/datas/api_provider.dart';

Future<String> pickFile(String selectFile, Function setState) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path ?? '');
    setState(() {
      selectFile = file.path;
    });
    print('selectFile: $selectFile');
  }
  return selectFile;
}

Future<int> sendMessage(
  String message,
  String attachment,
) async {
  print(0);
  MultipartFile multipartAttachment = await MultipartFile.fromFile(attachment);

  print(0.5);
  final FormData formData = FormData.fromMap({
    'message': message,
    'file': multipartAttachment,
  });

  print(1);

  final response = await ApiProvider.request(ApiPaths.FILE_UPLOAD,
      data: formData, method: 'POST');

  print('response.redirects: ${response.data}');

  final data = response.data;

  print('data: $data');

//TODO: ЕСЛИ ВСЁ ПЛОХО return 1;

  return 0;
}
