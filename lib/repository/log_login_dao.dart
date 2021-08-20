
import 'package:idejualan/model/log_login.dart';
import 'package:idejualan/model/user_body.dart';
import 'package:idejualan/repository/appdatabase.dart';
import 'package:sembast/sembast.dart';

class LogLoginDao {
  static const String USER_STORE_NAME = 'log';

  final _userStore = intMapStoreFactory.store(USER_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(LogLogin user) async{
    print(user.toJson());
    try {
      final db = await _db;
      await _userStore.add(await db, user.toJson());
    } catch(e) {
      print("ini Error " + e.toString());
    }

  }

  Future delete(/*RegisterBodyModel user*/) async {
    //final finder = Finder(filter: Filter.byKey(user.nipp));
    await _userStore.delete(
      await _db,
    );
  }

  Future<List<LogLogin>> getUser(String email) async {
    List<LogLogin> registerBodyModel = [];
    // Finder object can also sort data.
//    final finder = Finder(sortOrders: [
//      SortOrder('nipp'),
//    ]);

    final finder = Finder(
        filter: Filter.and([
          Filter.equals("email", email),
        ])
    );

    try {
      final recordSnapshots = await _userStore.find(
        await _db,
        finder: finder,
      );

      recordSnapshots.forEach((element) {
        registerBodyModel.add(LogLogin.fromJson(element.value));
      });

    }catch(error){
      return [];
    }
    // Making a List<article> out of List<RecordSnapshot>
    return registerBodyModel;
  }
}