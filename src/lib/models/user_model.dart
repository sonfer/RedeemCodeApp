import 'dart:convert';

class UserInfoModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  bool? isActive;
  String? authToken;
  UserInfoModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.isActive,
    this.authToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isActive': isActive,
      'authToken': authToken,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      id: map['id'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      isActive: map['isActive'],
      authToken: map['authToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoModel.fromJson(String source) =>
      UserInfoModel.fromMap(json.decode(source));
}
