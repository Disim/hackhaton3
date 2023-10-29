import 'package:hackaton3/utils/constants.dart';

abstract class ApiEndpoints {
  static const refreshTokens = 'auth/changeAccess';
  static const signIn = '${Constants.BASE_URL}Auth/token';
  static const signUp = '${Constants.BASE_URL}Register/register';
}
