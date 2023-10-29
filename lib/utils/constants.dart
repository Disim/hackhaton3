abstract class Constants {
  static const SUCCESS = 'success';
  static const BASE_URL = 'http://90.150.183.80:10000/api/';
}

abstract class HttpHeaders {
  static const AccessToken = 'x-access-token';
  static const RefreshToken = 'x-refresh-token';
}

enum HttpMethod {
  GET,
  POST,
  DELETE,
  PUT,
}
