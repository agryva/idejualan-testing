

import 'package:idejualan/model/user_body.dart';

class RegisterEvent {
}

class RegisterFetchFromRemote extends RegisterEvent {

}

class RegisterFetchFromLocal extends RegisterEvent {
  final UserBody userBody;

  RegisterFetchFromLocal({required this.userBody});
}

class LoginUserFetchFromLocal extends RegisterEvent {
  final UserBody userBody;

  LoginUserFetchFromLocal({required this.userBody});
}