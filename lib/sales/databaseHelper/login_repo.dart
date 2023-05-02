import 'package:sqflite/sqflite.dart';
import '../../data_model/offline_login_model.dart';
import '../module/model/login_model.dart';
import '../module/model/tsolist_model.dart';
import '../module/model/user_wise_business_model.dart';
import 'database_helper.dart';

class LoginRepo{
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Business Table section
  Future<int> insertToBusinessTable(UserWiseBusinessModel businessTableModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.businessTable, businessTableModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  Future<void> deleteBusinessTable() async{
    try{
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.businessTable);
      print("Table deleted successfully");
    }catch(e){
      print('Something went wrong when deleting Item: $e');
    }
  }

  Future<List> getFromBusinessTable() async{
    var dbClient = await conn.db;
    List businessList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.businessTable, orderBy: 'id desc');
      for(var business in maps){
        businessList.add(business);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    return businessList;
  }

  ///Login table Section
  Future<int> insertToLoginTable(OfflineLoginModel loginModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.loginTable, loginModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  Future<void> deleteFromLoginTable() async{
    try{
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.loginTable);
      print("Table deleted successfully");
    }catch(e){
      print('Something went wrong when deleting Item: $e');
    }
  }


  Future getLoginStatus() async{
    var dbClient = await conn.db;
    var result =await  dbClient!.rawQuery('SELECT loginStatus from ${DBHelper.loginStatus}');
    print("result Status"+ result.toString());
    if(result.length == 0){
      return 'Null' ;
    }else{
      Object? value = result[0]["loginStatus"];
      return value.toString();
    }

  }

  Future<void> deleteLoginStatusTable() async{
    try{
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.loginStatus);
      print("Table deleted successfully");
    }catch(e){
      print('Something went wrong when deleting Item: $e');
    }
  }

  Future updateLoginStatus() async {
    var dbclient = await conn.db;
    int value = 0;
    value = await dbclient!.rawUpdate("INSERT INTO ${DBHelper.loginStatus} (loginStatus) VALUES ('0')");
    return value;
  }


  ///login as a tso
  Future<int> insertToTerritoryTable(TerritoryListModel territoryListModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.territoryTable, territoryListModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  //get territory list
  Future<List> getTerritoryList(String zid) async{
    var dbClient = await conn.db;
    List territoryList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.territoryTable, where: "zid=?", whereArgs: [zid]);
      for(var territory in maps){
        territoryList.add(territory);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    return territoryList;
  }


  Future<void> deleteFromTerritoryTable() async{
    try{
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.territoryTable);
      print("Table deleted successfully");
    }catch(e){
      print('Something went wrong when deleting Item: $e');
    }
  }

/*  /// only tso_info
  Future<int> insertToTsoInfoTable(TsoInfoListModel tsoInfoModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.tsoInfoTable, tsoInfoModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  Future<void> deleteFromtsoInfoTable() async{
    try{
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.tsoInfoTable);
      print("Table deleted successfully");
    }catch(e){
      print('Something went wrong when deleting Item: $e');
    }
  }

  Future getTsoInfo(String zid) async{
    var dbClient = await conn.db;
    List tsoInfoList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.tsoInfoTable, where: "zid=?", whereArgs: [zid]);
      if(maps.isEmpty){
        // insert default row
        await dbClient.insert(DBHelper.tsoInfoTable, {
          "zid": zid,
          "xwh": 8,
          "xstaff":" ",
          "xsm":" ",
          "rsm":" ",
          "xname":" ",
          "mTarget": "0",
          "dTarget": "0",
          "mshopvisit": "0"
        });
        // query again to get the default row
        maps = await dbClient.query(DBHelper.tsoInfoTable, where: "zid=?", whereArgs: [zid]);
      }
      for(var tsoInfo in maps){
        tsoInfoList.add(tsoInfo);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    return tsoInfoList;
  }*/

  /// only for dealerVisit Table
  Future<int> insertToDealerVisitTable(Map<String, dynamic> data ) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.dealerVisitTable, data);
      print("Inserted Successfully in dealer visit table: -------------$result");
    }catch(e){
      print('There are some issues inserting cartTable: $e');
    }
    return result;
  }

  Future<void> deleteFromDealerVisitTable() async{
    try{
      var dbClient = await conn.db;
      dbClient!.delete(DBHelper.dealerVisitTable);
      print("Table deleted successfully");
    }catch(e){
      print('Something went wrong when deleting Item: $e');
    }
  }

  Future getFromDealerVisitTable() async{
    var dbClient = await conn.db;
    List visitedDealerList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.dealerVisitTable, orderBy: 'id desc');
      for(var visitedDealer in maps){
        visitedDealerList.add(visitedDealer);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    return visitedDealerList;
  }

  Future<int> countDealerVisit() async{
    var dbClient = await conn.db;
    int? count = 0;
    try{
      count = Sqflite.firstIntValue(await dbClient!.rawQuery('SELECT COUNT(*) FROM ${DBHelper.dealerVisitTable}'));
    }catch(e){
      print("There are some issues getting products : $e");
    }
    return count!;
  }


}