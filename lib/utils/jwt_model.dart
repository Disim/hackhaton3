class JwtModel {
  JwtModel({required this.refresh, this.access});
  String refresh;
  String? access;

  JwtModel.fromJson(Map<String, dynamic> json)
      : access = json['token'],
        refresh = json['refreshToken'];
}
