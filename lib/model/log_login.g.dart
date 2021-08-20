// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogLogin _$LogLoginFromJson(Map<String, dynamic> json) {
  return LogLogin(
    email: json['email'] as String?,
    createdAt: json['createdAt'] as String?,
  );
}

Map<String, dynamic> _$LogLoginToJson(LogLogin instance) => <String, dynamic>{
      'email': instance.email,
      'createdAt': instance.createdAt,
    };
