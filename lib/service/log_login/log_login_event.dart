class LogLoginEvent {
}

class LogLoginFetchFromRemote extends LogLoginEvent {
}

class LogLoginFetchFromLocal extends LogLoginEvent {
  final String email;

  LogLoginFetchFromLocal(this.email);

}