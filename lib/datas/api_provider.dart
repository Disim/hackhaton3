import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hackaton3/app/models/organization.dart';
import 'package:hackaton3/datas/api_paths.dart';
import 'package:hackaton3/datas/token_manager.dart';
import 'package:hackaton3/main.dart';

class ApiProvider {
  static const _baseUrl = 'http://90.150.183.80:10000/';

  static Dio dio =
      Dio(BaseOptions(baseUrl: _baseUrl, contentType: 'multipart/form-data'));

  static Future<Organization> login(Organization organization) async {
    try {
      final request = await ApiProvider.request(
        ApiPaths.AUTH,
        data: organization.toJson(),
        method: 'POST',
      );

      print('Req ${request.data}');

      // TokenManager.setTokens(accessToken, refreshToken)
      organization = Organization.fromJson(request.data);
    } catch (e) {
      print(e);
    }
    return organization;
  }

  static Future<Organization> register(Organization organization) async {
    try {
      final request = await ApiProvider.request(
        ApiPaths.REGISTER,
        data: organization.toJson(),
        method: 'POST',
      );
      print(request.data);
      organization = Organization.fromJson(request.data);
    } catch (e) {
      print(e);
    }
    return organization;
  }

  static Future<Response> request(
    String path, {
    String method = 'GET',
    dynamic data,
  }) async {
    String token = organization.accessToken;

    // TODO: if (data.runtimeType == FormData) {
    //   token = await _refreshTokens();
    //   if (token == '') {
    //     organization.clear();
    //     navigatorKey.currentState!
    //         .pushNamedAndRemoveUntil('/main_page', (route) => false);
    //     return Response(requestOptions: RequestOptions());
    //   }
    // }

    final Options option = Options(method: method, headers: {
      'token': token,
    });

    try {
      if (kDebugMode) print('Запрос $path');

      return await dio.request(path, data: data, options: option);
    } on DioException catch (error) {
      if (kDebugMode) print('CODE: ${error.response?.statusCode}');

      try {
        // if (error.response?.statusCode == 401) {
        //   // Если получена ошибка авторизации (статус 401), запрашиваем новый
        //   final newAccessToken = await _refreshTokens();
        //   if (newAccessToken == '') {
        //     organization.clear();
        //     navigatorKey.currentState!
        //         .pushNamedAndRemoveUntil('/main_page', (route) => false);
        //     return Response(requestOptions: RequestOptions());
        //   }
        //   // Повторно выполняем запрос с обновленными токенами
        //   option.headers = {
        //     'Accept-App': acceptApp,
        //     'token': newAccessToken,
        //   };
        //   if (kDebugMode) print('Повторный запрос $path $data');

        //   return await dio.request('$_baseUrl$path',
        //       data: data, options: option);
        // }
        rethrow;
      } catch (e) {
        if (kDebugMode) print(e);
        return Response(requestOptions: RequestOptions());
      }
    }
  }

  static Future<String> _refreshTokens() async {
    // Отправляем запрос на обновление токенов
    if (kDebugMode) print('Обновляем токен');

    try {
      final response = await dio.post(
        ApiPaths.REFRESTH_TOKEN,
        data: jsonEncode({'token': organization.refreshToken}),
      );

      // Обрабатываем ответ и сохраняем новые токены
      final String accessToken = response.data['accessToken'];
      final String newRefreshToken = response.data['refreshToken'];

      await TokenManager.setTokens(accessToken, newRefreshToken);
      return accessToken;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      organization.clear();
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/main_page', (route) => false);
      return '';
    }
  }
}
