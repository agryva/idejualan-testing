import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idejualan/repository/local_repository.dart';
import 'package:idejualan/service/log_login/log_login_event.dart';
import 'package:idejualan/service/log_login/log_login_state.dart';

class LogLoginBloc extends  Bloc<LogLoginEvent, LogLoginState> {
  late LocalRepository localRepository;

  LogLoginBloc() : super(InitialLogLoginState()) {
    localRepository = LocalRepository();
  }

  @override
  Stream<LogLoginState> mapEventToState(LogLoginEvent event) async*{
    if (event is LogLoginFetchFromLocal) {
      yield LogLoginLoading();
      try {
        final data = await localRepository.loginDao.getUser(event.email);
        yield LogLoginLoaded(
          data: data
        );
      } catch(e) {
        yield LogLoginNotLoaded(e.toString());
      }
    }
  }

}