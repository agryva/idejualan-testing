

import 'package:idejualan/model/user_body.dart';

class RegisterState {
}

class InitialRegisterState extends RegisterState {
}

class RegisterLoading extends RegisterState {
}

class RegisterLoaded extends RegisterState{
}


class RegisterNotLoaded extends RegisterState{
    final String error;

    RegisterNotLoaded(this.error);

}



class LoginLoading extends RegisterState {
}

class LoginLoaded extends RegisterState{
    final UserBody? userBody;

  LoginLoaded({this.userBody});
}


class LoginNotLoaded extends RegisterState{
    final String error;

    LoginNotLoaded(this.error);

}

