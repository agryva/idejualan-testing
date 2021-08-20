
import 'package:idejualan/model/user_body.dart';
import 'package:idejualan/repository/appdatabase.dart';
import 'package:sembast/sembast.dart';

class UserDao {
  static const String USER_STORE_NAME = 'user';

  final _userStore = intMapStoreFactory.store(USER_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(UserBody user) async{
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

  Future<UserBody?> getUser(UserBody userBody) async {
    UserBody registerBodyModel;
    // Finder object can also sort data.
//    final finder = Finder(sortOrders: [
//      SortOrder('nipp'),
//    ]);

    final finder = Finder(
      filter: Filter.and([
        Filter.equals("email", userBody.email),
        Filter.equals("password", userBody.password),
      ])
    );

    try {
      final recordSnapshots = await _userStore.findFirst(
        await _db,
        finder: finder,
      );

      registerBodyModel = UserBody.fromJson(recordSnapshots!.value);
    }catch(error){
      return null;
    }
    // Making a List<article> out of List<RecordSnapshot>
    return registerBodyModel;
  }
}