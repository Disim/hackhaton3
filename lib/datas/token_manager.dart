import 'package:hackaton3/app/models/organization.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TokenManager {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  static Future<String> getAccessToken() async {
    // Получение access token из хранилища
    Box<dynamic> box = await Hive.openBox('login');
    if (box.containsKey(_accessTokenKey)) {
      final accessToken = await box.get(_accessTokenKey);
      return accessToken;
    }
    return '';
  }

  static Future<String> getRefreshToken() async {
    // Получение refresh token из хранилища
    Box<dynamic> box = await Hive.openBox('login');
    if (box.containsKey(_refreshTokenKey)) {
      final refreshToken = await box.get(_refreshTokenKey);
      return refreshToken;
    }
    return '';
  }

  static Future<Map<String, String>> getTokens() async {
    // Получение refresh token из хранилища
    Box<dynamic> box = await Hive.openBox('login');
    if (box.containsKey(_refreshTokenKey) && box.containsKey(_accessTokenKey)) {
      final refreshToken = await box.get(_refreshTokenKey);
      final accessToken = await box.get(_accessTokenKey);
      return {'refreshToken': refreshToken, 'accessToken': accessToken};
    }
    return {};
  }

  static Future<int> setTokens(String accessToken, String refreshToken) async {
    // Сохранение access token в хранилище
    Box<dynamic> box = await Hive.openBox('login');
    await box.put(_accessTokenKey, accessToken);
    await box.put(_refreshTokenKey, refreshToken);

    organization.accessToken = accessToken;
    organization.refreshToken = refreshToken;

    return 0;
  }
}
