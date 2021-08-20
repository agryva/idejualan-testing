// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBody _$UserBodyFromJson(Map<String, dynamic> json) {
  return UserBody(
    email: json['email'] as String?,
    password: json['password'] as String?,
    gender: json['gender'] as String?,
  );
}

Map<String, dynamic> _$UserBodyToJson(UserBody instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
    };
