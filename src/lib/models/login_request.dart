import 'dart:convert';

class LoginRequest {
  String? fcmToken;
  LoginRequest({
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'fcmToken': fcmToken,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      fcmToken: map['fcmToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));
}
