import 'package:sqflite/sqflite.dart';
import '../../data_model/offline_login_model.dart';
import '../module/model/login_model.dart';
import '../module/model/tsolist_model.dart';
import '../module/model/user_wise_business_model.dart';
import 'database_helper.dart';

class LoginRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Business Table section
  Future<int> insertToBusinessTable(
      UserWiseBusinessModel businessTableModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!
          .insert(DBHelper.businessTable, businessTableModel.toJson());
    } catch (e) {
      print('There are some issues insertToBusinessTable : $e');
    }
    return result;
  }

  Future<void> deleteBusinessTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.businessTable);
    } catch (e) {
      print('Something went wrong when deleting Item deleteBusinessTable : $e');
    }
  }

  Future<List> getFromBusinessTable() async {
    var dbClient = await conn.db;
    List businessList = [];
    try {
      List<Map<String, dynamic>> maps =
          await dbClient!.query(DBHelper.businessTable, orderBy: 'id desc');
      for (var business in maps) {
        businessList.add(business);
      }
    } catch (e) {
      print("There are some issues getting products : $e");
    }
    return businessList;
  }

  ///Login table Section
  Future<int> insertToLoginTable(OfflineLoginModel loginModel) async {
    var dbClient = await conn.db;
    int result = 0;

    try {
      var existingRecords = await dbClient!.query(
        DBHelper.loginTable,
        where: 'zemail = ?',
        whereArgs: [loginModel.zemail], // Specify the column to check against
      );

      if (existingRecords.isNotEmpty) {
        // Value already exists in the table, perform an update instead
        result = await dbClient.update(
          DBHelper.loginTable,
          loginModel.toJson(),
          where: 'zemail = ?', // Specify the column to update
          whereArgs: [loginModel.zemail],
        );
      } else {
        // Value doesn't exist, perform an insert
        result =
            await dbClient.insert(DBHelper.loginTable, loginModel.toJson());
      }
    } catch (e) {
      print('There are some issues insertToLoginTable : $e');
    }

    return result;
  }

  Future<void> deleteFromLoginTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.loginTable);
    } catch (e) {
      print('Something went wrong when deleting Item deleteFromLoginTable : $e');
    }
  }

  Future getLoginStatus() async {
    var dbClient = await conn.db;
    var result = await dbClient!
        .rawQuery('SELECT loginStatus from ${DBHelper.loginStatus}');
    if (result.length == 0) {
      return 'Null';
    } else {
      Object? value = result[0]["loginStatus"];
      return value.toString();
    }
  }

  Future<void> deleteLoginStatusTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.loginStatus);
    } catch (e) {
      print('Something went wrong when deleting Item deleteLoginStatusTable: $e');
    }
  }

  Future updateLoginStatus() async {
    var dbclient = await conn.db;
    int value = 0;
    value = await dbclient!.rawUpdate(
        "INSERT INTO ${DBHelper.loginStatus} (loginStatus) VALUES ('0')");
    return value;
  }

  ///login as a tso
  Future<int> insertToTerritoryTable(
      TerritoryListModel territoryListModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!
          .insert(DBHelper.territoryTable, territoryListModel.toJson());
    } catch (e) {
      print('There are some issues insertToTerritoryTable: $e');
    }
    return result;
  }

  //get territory list
  Future<List> getTerritoryList(String zid) async {
    var dbClient = await conn.db;
    List territoryList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!
          .query(DBHelper.territoryTable, where: "zid=?", whereArgs: [zid]);
      for (var territory in maps) {
        territoryList.add(territory);
      }
    } catch (e) {
      print("There are some issues getTerritoryList : $e");
    }
    return territoryList;
  }

  Future<void> deleteFromTerritoryTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.territoryTable);
    } catch (e) {
      print('Something went wrong deleteFromTerritoryTable: $e');
    }
  }

  /// only tso_info
  Future<int> insertToTsoInfoTable(TsoInfoListModel tsoInfoModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result =
          await dbClient!.insert(DBHelper.tsoInfoTable, tsoInfoModel.toJson());
    } catch (e) {
      print('There are some issues insertToTsoInfoTable : $e');
    }
    return result;
  }

  Future<void> deleteFromtsoInfoTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.tsoInfoTable);
    } catch (e) {
      print('Something went wrong deleteFromtsoInfoTable : $e');
    }
  }

  Future getTsoInfo(String zid) async {
    var dbClient = await conn.db;
    List tsoInfoList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!
          .query(DBHelper.tsoInfoTable, where: "zid=?", whereArgs: [zid]);
      if (maps.isEmpty) {
        // insert default row
        await dbClient.insert(DBHelper.tsoInfoTable, {
          "zid": zid,
          "achievement": "0",
          "target": "0",
          "totalSO": "0",
          "totalDPnum": "0"
        });
        // query again to get the default row
        maps = await dbClient
            .query(DBHelper.tsoInfoTable, where: "zid=?", whereArgs: [zid]);
      }
      for (var tsoInfo in maps) {
        tsoInfoList.add(tsoInfo);
      }
    } catch (e) {
      print("There are some issues getTsoInfo : $e");
    }
    return tsoInfoList;
  }

  /// only for dealerVisit Table
  Future<int> insertToDealerVisitTable(Map<String, dynamic> data) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!.insert(DBHelper.dealerVisitTable, data);
    } catch (e) {
      print('There are some issues insertToDealerVisitTable : $e');
    }
    return result;
  }

  Future<void> deleteFromDealerVisitTable() async {
    try {
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.dealerVisitTable);
    } catch (e) {
      print('Something went wrong deleteFromDealerVisitTable : $e');
    }
  }

  Future getFromDealerVisitTable() async {
    var dbClient = await conn.db;
    List visitedDealerList = [];
    try {
      List<Map<String, dynamic>> maps =
          await dbClient!.query(DBHelper.dealerVisitTable, orderBy: 'id desc');
      for (var visitedDealer in maps) {
        visitedDealerList.add(visitedDealer);
      }
    } catch (e) {
      print("There are some issues getFromDealerVisitTable : $e");
    }
    return visitedDealerList;
  }

  Future<int> countDealerVisit() async {
    var dbClient = await conn.db;
    int? count = 0;
    try {
      count = Sqflite.firstIntValue(await dbClient!
          .rawQuery('SELECT COUNT(*) FROM ${DBHelper.dealerVisitTable}'));
    } catch (e) {
      print("There are some issues getting products countDealerVisit : $e");
    }
    return count!;
  }
}
