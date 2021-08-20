
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idejualan/model/log_login.dart';
import 'package:idejualan/repository/local_repository.dart';
import 'package:idejualan/service/register/register_event.dart';
import 'package:idejualan/service/register/register_state.dart';
import 'package:intl/intl.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  late LocalRepository localRepository;

  RegisterBloc() : super(InitialRegisterState()) {
    localRepository = LocalRepository();
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    if (event is RegisterFetchFromLocal) {
      yield RegisterLoading();
      try {
        await localRepository.userDao.insert(event.userBody);

        yield RegisterLoaded();
      } catch(e) {
        yield RegisterNotLoaded(e.toString());
      }
    }

    if (event is LoginUserFetchFromLocal) {
      yield LoginLoading();
      try {
        final data = await localRepository.userDao.getUser(event.userBody);

        final df = DateFormat("dd-MM-yyyy hh:mm a");
        await localRepository.loginDao.insert(LogLogin(
          email: event.userBody.email,
          createdAt: df.format(DateTime.now())
        ));
        print(data);
        yield LoginLoaded(userBody: data);
      } catch(e) {
        yield LoginNotLoaded(e.toString());
      }
    }
  }

}