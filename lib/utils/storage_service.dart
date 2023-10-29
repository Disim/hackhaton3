import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  late final Box box;
  Future<StorageService> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox(BoxNames.login.name);
    return this;
  }

  Future<String?> getRefresh() async =>
      await box.get(BoxKeys.refreshToken.name);

  Future<int> setRefreshToken(String token, {String? uid}) async {
    if (uid != null) {
      await box.put(BoxKeys.uid.name, uid);
    }
    await box.put(BoxKeys.refreshToken.name, token);
    return 0;
  }

  Future<void> clearStorage() async => await box.clear();
}

enum BoxKeys {
  uid,
  refreshToken,
}

enum BoxNames {
  login,
}
