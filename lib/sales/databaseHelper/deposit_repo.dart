import 'package:gazi_sales_app/sales/module/model/payment_model_model.dart';
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
      List<Map<String, dynamic>> maps =
          await dbClient!.rawQuery("SELECT xbank, xname FROM "
              "${DBHelper.bankTable} Where zid = '$zid'");

      for (var banks in maps) {
        bankList.add(banks);
      }
    } catch (e) {
      print("There are some issues getting products : $e");
    }
    return bankList;
  }

  ///payment section
  Future<int> insertIntoPaymentTable(dynamic payment) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      if (payment is PaymentModeModel) {
        // Single object
        var existingRecord = await dbClient!.query(
          DBHelper.paymentTable,
          where: 'zid = ? AND xcode = ?',
          whereArgs: [
            payment.zid,
            payment.xcode,
          ],
        );
        if (existingRecord.isNotEmpty) {
          result = await dbClient.update(
            DBHelper.paymentTable,
            payment.toJson(),
            where: 'zid = ? AND xcode = ? AND id = ?',
            whereArgs: [
              payment.zid,
              payment.xcode,
              payment.id,
            ],
          );
        } else {
          result =
              await dbClient.insert(DBHelper.paymentTable, payment.toJson());
        }
      } else if (payment is List<PaymentModeModel>) {
        // List of objects
        for (var paymentMode in payment) {
          var existingRecord = await dbClient!.query(
            DBHelper.paymentTable,
            where: 'zid = ? AND xcode = ?',
            whereArgs: [
              paymentMode.zid,
              paymentMode.xcode,
            ],
          );
          if (existingRecord.isNotEmpty) {
            result += await dbClient.update(
              DBHelper.paymentTable,
              paymentMode.toJson(),
              where: 'zid = ? AND xcode = ? AND id = ?',
              whereArgs: [
                paymentMode.zid,
                paymentMode.xcode,
                paymentMode.id,
              ],
            );
          } else {
            result += await dbClient.insert(
                DBHelper.paymentTable, paymentMode.toJson());
          }
        }
      }
      print("-------------$result");
    } catch (e) {
      print('There are some issues inserting into payment table: $e');
    }
    return result;
  }

  //bank table delete
  Future<void> deleteFromPaymentTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.bankTable);
      print("Table deleted successfully");
    } catch (e) {
      print('Something went wrong when deleting Item: $e');
    }
  }

  //get from banktable
  Future<List> getFromPaymentTable(String zid) async {
    var dbClient = await conn.db;
    List paymentList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.query(
        DBHelper.paymentTable,
        where: 'zid=?',
        whereArgs: [zid],
        orderBy: 'id desc',
      );
      for (var banks in maps) {
        paymentList.add(banks);
      }
    } catch (e) {
      print("There are some issues getting products : $e");
    }
    return paymentList;
  }

  //For inserting into Deposit table
  Future<int> depositInsert(Map<String, dynamic> data) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!.insert(DBHelper.depositTable, data);
      print("Inserted Successfully in header table: -------------$result");
    } catch (e) {
      print('There are some issues inserting DepositTable: $e');
    }
    return result;
  }

  //Getting Deposit ID
  Future<int> getDepositID() async {
    var dbClient = await conn.db;
    List depositID = [];
    try {
      depositID = await dbClient!.rawQuery(
          'SELECT COUNT(*) as depositID from ${DBHelper.depositTable} order by id desc');
    } catch (e) {
      print("There are some issues: $e");
    }
    return depositID.isEmpty ? 0 : depositID[0]['depositID'];
  }

  //Getting Deposit List for showing in the Deposit History
  Future<List> getOpenDeposit(String zID) async {
    var dbClient = await conn.db;
    List openDeposit = [];
    try {
      openDeposit = await dbClient!.rawQuery(
          'SELECT * from ${DBHelper.depositTable} where xstatus = "Open" and zid=?',
          [zID]);
    } catch (e) {
      print("There are some issues: $e");
    }
    return openDeposit;
  }

  //Updating status of cartTable
  Future updateDepositStatus(String depositID) async {
    var dbClient = await conn.db;
    dbClient!.rawQuery(
        "UPDATE ${DBHelper.depositTable} SET xstatus = 'Applied' WHERE depositID = ?",
        [depositID]);
  }

  //Deleting single Deposit Number
  Future singleDepositDelete(String depositID) async {
    var dbClient = await conn.db;
    dbClient!.rawQuery(
        "DELETE from ${DBHelper.depositTable}  WHERE depositID = ?",
        [depositID]);
    print(getOpenDeposit("400080"));
  }
}
