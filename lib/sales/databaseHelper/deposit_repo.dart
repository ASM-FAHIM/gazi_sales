import 'package:sqflite/sqflite.dart';
import '../module/model/bank_list_model.dart';
import 'database_helper.dart';

class DepositRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Inserting Invoice type into invoice type table\
  Future<int> insertIntoBankTable(BankListModel bankList) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!.insert(DBHelper.bankTable, bankList.toJson());
      print("-------------$result");
    } catch (e) {
      print('There are some issues inserting into bank table: $e');
    }
    return result;
  }

  //bank table delete
  Future<void> deleteFromBankTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.bankTable);
      print("Table deleted successfully");
    } catch (e) {
      print('Something went wrong when deleting Item: $e');
    }
  }

  //get from banktable
  Future<List> getFromBankTable(String zid) async {
    var dbClient = await conn.db;
    List bankList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.query(
        DBHelper.bankTable,
        where: 'zid=?',
        whereArgs: [zid],
        orderBy: 'id desc',
      );
      for (var banks in maps) {
        bankList.add(banks);
      }
    } catch (e) {
      print("There are some issues getting products : $e");
    }
    return bankList;
  }
}
