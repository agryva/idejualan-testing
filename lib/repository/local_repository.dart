
import 'package:idejualan/model/log_login.dart';
import 'package:idejualan/repository/log_login_dao.dart';
import 'package:idejualan/repository/user_dao.dart';

class LocalRepository {
  late UserDao userDao;
  late LogLoginDao loginDao;

  LocalRepository() {
    initLocal();
  }

  void initLocal() async {
    userDao = UserDao();
    loginDao = LogLoginDao();
  }
}
