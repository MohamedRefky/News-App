import 'package:hive_ce_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  UserModel({
    required this.name,
    this.email,
    this.password,
    this.photoUrl,
    this.countryName,
    this.countryCode,
    this.flagEmoji,
    this.accessToken,
    this.refreshToken,
  });
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? photoUrl;
  @HiveField(3)
  String? password;
  @HiveField(4)
  String? countryName;
  @HiveField(5)
  String? countryCode;
  @HiveField(6)
  String? flagEmoji;

  String? accessToken;
  String? refreshToken;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String?,
      email: map['email'] as String?,
      photoUrl: map['photoUrl'] as String?,
      password: map['password'] as String?,
      countryName: map['countryName'] as String?,
      countryCode: map['countryCode'] as String?,
      flagEmoji: map['flagEmoji'] as String?,
    );
  }
  factory UserModel.fromAuthResponse(Map<String, dynamic> json, String username) {
    return UserModel(
      name: username,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? password,
    String? countryName,
    String? countryCode,
    String? flagEmoji,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      password: password ?? password,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      flagEmoji: flagEmoji ?? this.flagEmoji,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, photoUrl: $photoUrl, password: $password, countryName: $countryName, countryCode: $countryCode, flagEmoji: $flagEmoji, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
