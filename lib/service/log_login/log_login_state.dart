import 'package:idejualan/model/log_login.dart';

class LogLoginState {
}

class InitialLogLoginState extends LogLoginState {
}

class LogLoginLoading extends LogLoginState {
}

class LogLoginLoaded extends LogLoginState{
    final List<LogLogin> data;

  LogLoginLoaded({required this.data});
}


class LogLoginNotLoaded extends LogLoginState{
    final String error;

    LogLoginNotLoaded(this.error);

}

