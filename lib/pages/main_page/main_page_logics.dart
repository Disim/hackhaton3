import 'dart:convert';
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

Future<int> sendFile(
  String attachment,
) async {
  MultipartFile multipartAttachment = await MultipartFile.fromFile(attachment);
  final FormData formData = FormData.fromMap({
    'file': multipartAttachment,
  });

  final response = await ApiProvider.request(ApiPaths.FILE_UPLOAD,
      data: formData, method: 'POST');

  final data = response.data;
//TODO: ЕСЛИ ВСЁ ПЛОХО return 1;

  return 0;
}

Future<String> sendMessage(
  String message,
) async {
  final response = await ApiProvider.request(ApiPaths.GET_REPORT,
      data: jsonEncode({
        'product': message,
      }),
      method: 'POST');

  final data = response.data;
  if (data.containsKey('Report')) {
    final report = data['Report'];
    return report;
  }

  return "Сервер не отвечает";
}
