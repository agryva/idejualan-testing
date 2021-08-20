

import 'package:json_annotation/json_annotation.dart';
part 'log_login.g.dart';

@JsonSerializable()
class LogLogin {
  final String? email;
  final String? createdAt;

  LogLogin({this.email, this.createdAt});

  Map<String, dynamic> toJson() => _$LogLoginToJson(this);

  factory LogLogin.fromJson(Map<String, dynamic> json) =>
      _$LogLoginFromJson(json);
}