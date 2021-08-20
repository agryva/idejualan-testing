import 'package:json_annotation/json_annotation.dart';
part 'user_body.g.dart';

@JsonSerializable()
class UserBody {
  final String? email;
  final String? password;
  final String? gender;

  UserBody({this.email, this.password, this.gender});


  Map<String, dynamic> toJson() => _$UserBodyToJson(this);

  factory UserBody.fromJson(Map<String, dynamic> json) =>
      _$UserBodyFromJson(json);
}