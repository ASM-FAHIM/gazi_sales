import 'package:sqflite/sqflite.dart';
import '../module/model/bank_list_model.dart';
import 'database_helper.dart';

class DepositRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  Future<int> insertIntoBankTable(dynamic bankData) async {
    var dbClient = await conn.db;
    int result = 0;

    try {
      if (bankData is BankListModel) {
        // Single object
        var existingRecord = await dbClient!.query(
          DBHelper.bankTable,
          where: 'xbank = ? AND zid=?',
          whereArgs: [
            bankData.xbank,
            bankData.zid,
          ],
        );

        if (existingRecord.isNotEmpty) {
          result = await dbClient.update(
            DBHelper.bankTable,
            bankData.toJson(),
            where: 'xbank = ? AND zid=? AND id=?',
            whereArgs: [
              bankData.xbank,
              bankData.zid,
              bankData.id,
            ],
          );
        } else {
          result = await dbClient.insert(DBHelper.bankTable, bankData.toJson());
        }
      } else if (bankData is List<BankListModel>) {
        // List of objects
        for (var bank in bankData) {
          var existingRecord = await dbClient!.query(
            DBHelper.bankTable,
            where: 'xbank = ? AND zid=?',
            whereArgs: [
              bank.xbank,
              bank.zid,
            ],
          );

          if (existingRecord.isNotEmpty) {
            result += await dbClient.update(
              DBHelper.bankTable,
              bank.toJson(),
              where: 'xbank = ? AND zid=? AND id=?',
              whereArgs: [
                bank.xbank,
                bank.zid,
                bank.id,
              ],
            );
          } else {
            result += await dbClient.insert(DBHelper.bankTable, bank.toJson());
          }
        }
      }

      print("-------------$result");
    } catch (e) {
      print('There are some issues inserting into bank table: $e');
    }

    return result;
  }

  /*///Inserting Invoice type into invoice type table\
  Future<int> insertIntoBankTable(BankListModel bankList) async {
    var dbClient = await conn.db;
    int result = 0;

    try {
      var existingRecord = await dbClient!.query(
        DBHelper.bankTable,
        where: 'xbank = ? AND zid=?',
        whereArgs: [
          bankList.xbank,
          bankList.zid
        ], // Specify the column to check against
      );

      if (existingRecord.isNotEmpty) {
        // Value already exists in the table, perform an update instead
        result = await dbClient.update(
          DBHelper.bankTable,
          bankList.toJson(),
          where: 'xbank = ? AND zid=?',
          whereArgs: [bankList.xbank, bankList.zid],
        );
      } else {
        // Value doesn't exist, perform an insert
        result = await dbClient.insert(DBHelper.bankTable, bankList.toJson());
      }

      print("-------------$result");
    } catch (e) {
      print('There are some issues inserting into bank table: $e');
    }

    return result;
  }*/

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
