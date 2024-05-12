import 'package:gazi_sales_app/sales/databaseHelper/database_helper.dart';

class SyncTime{

  // SqfliteDatabaseHelper.internal();
  // static final SqfliteDatabaseHelper instance = new SqfliteDatabaseHelper.internal();
  // factory SqfliteDatabaseHelper() =>instance;


  final conn = DBHelper.internal();

  Future updatelastSyncTime(String time,String syncFeature) async {


    var dbclient = await conn.db;
    int value = 0;
    value = await dbclient!.rawUpdate('UPDATE ${DBHelper.lastSyncTime} SET time = ? WHERE syncFeature = ?', [time,syncFeature]);
    return value;
    }


  Future<void> insertSyncTime(String time, String syncFeature) async {
    try {
      var dbClient = await conn.db; // Assuming `conn` is your database connection object
      await dbClient!.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO ${DBHelper.lastSyncTime} (syncFeature, time) VALUES(?, ?)',
            [syncFeature, time]);
      });

    } catch (e) {
      print('Error inserting sync time: $e');
    }
  }





  // Future getDiscount_from_cart(String syncFeature) async {
  //   var dbclient = await conn.db;
  //   var result = await dbclient!.rawQuery("SELECT time FROM ${DBHelper.lastSyncTime} where syncFeature = '$syncFeature'");
  //
  //   Object? value = result[0]["time"];
  //   print(result);
  //   return value.toString();
  //   }

  Future<Map<String, dynamic>> getLastSyncTime(String syncFeature) async {
    var dbclient = await conn.db;
    var result = await dbclient!.rawQuery("SELECT time FROM ${DBHelper.lastSyncTime} where syncFeature = '$syncFeature'");

    Object? value = result.isNotEmpty ? result[0]["time"] : null;
    int length = result.length;

    print(result);

    return {
      'value': value?.toString(),
      'length': length,
    };
  }


}