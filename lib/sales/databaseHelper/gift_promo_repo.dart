import '../module/model/ca_cus_disc_model.dart';
import '../module/model/promo_details_model.dart';
import '../module/model/promo_header_model.dart';
import 'database_helper.dart';

class GiftPromoRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Promotion Header
  /*Future<int> insertIntoPromoHeaderTable(
      PromoHeaderModel promoHeaderModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!
          .insert(DBHelper.promoHeader, promoHeaderModel.toJson());
      print("-------------$result");
    } catch (e) {
      print('There are some issues insertIntoPromoHeaderTable : $e');
    }
    return result;
  }*/

  Future<int> insertIntoPromoHeaderTable(
      PromoHeaderModel promoHeaderModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      var existingRecords = await dbClient!.query(
        DBHelper.promoHeader,
        where: 'xtrnnum = ? AND zid = ?',
        whereArgs: [promoHeaderModel.xtrnnum,
          promoHeaderModel.zid,],
      );

      if (existingRecords.isNotEmpty) {
        result = await dbClient.update(
          DBHelper.promoHeader,
          {

            'xstype': promoHeaderModel.xstype,
            'xfdate': promoHeaderModel.xfdate,
            'xtdate': promoHeaderModel.xtdate,
            'xref': promoHeaderModel.xref,
          },
          where: 'xtrnnum = ? AND zid = ?',
          whereArgs: [promoHeaderModel.xtrnnum,
            promoHeaderModel.zid,],
        );
      } else {
        result = await dbClient.insert(
          DBHelper.promoHeader,
          promoHeaderModel.toJson(),
        );
      }

      print("-------------$result");
    } catch (e) {
      print('There are some issues insertIntoPromoHeaderTable: $e');
    }
    return result;
  }


  /// Promotion details
/*  Future<int> insertIntoPromoDetailsTable(
      PromoDetailsrModel promoDetailsrModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!
          .insert(DBHelper.promoDetails, promoDetailsrModel.toJson());
      print("-------------$result");
    } catch (e) {
      print('There are some issues insertIntoPromoDetailsTable : $e');
    }
    return result;
  }*/
  Future<int> insertIntoPromoDetailsTable(
      PromoDetailsrModel promoDetailsModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      var existingRecords = await dbClient!.query(
        DBHelper.promoDetails,
        where: 'xtrnnum = ? AND xrow = ?',
        whereArgs: [
          promoDetailsModel.xtrnnum,
          promoDetailsModel.xrow,
        ],
      );

      if (existingRecords.isNotEmpty) {
        result = await dbClient.update(
          DBHelper.promoDetails,
          {
            'xstype': promoDetailsModel.xstype,
            'xcolor': promoDetailsModel.xcolor,
            'xtype': promoDetailsModel.xtype,
            'xfslab': promoDetailsModel.xfslab,
            'xtslab': promoDetailsModel.xtslab,
            'xamount': promoDetailsModel.xamount,
          },
          where: 'xtrnnum = ? AND xrow = ?',
          whereArgs: [
            promoDetailsModel.xtrnnum,
            promoDetailsModel.xrow,
          ],
        );
      } else {
        result = await dbClient.insert(
          DBHelper.promoDetails,
          promoDetailsModel.toJson(),
        );
      }

      print("-------------$result");
    } catch (e) {
      print('There are some issues insertIntoPromoDetailsTable: $e');
    }
    return result;
  }


  /// CaCusDisc table
/*  Future<int> insertIntoCaCusDiscTable(CaCusDiscModel caCusDiscModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!
          .insert(DBHelper.caCusDisc, caCusDiscModel.toJson());
      print("-------------$result");
    } catch (e) {
      print('There are some issues in insertIntoCaCusDiscTable : $e');
    }
    return result;
  }*/
  Future<int> insertIntoCaCusDiscTable(CaCusDiscModel caCusDiscModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      var existingRecords = await dbClient!.query(
        DBHelper.caCusDisc,
        where: 'xcus = ? AND xitem = ?',
        whereArgs: [
          caCusDiscModel.xcus,
          caCusDiscModel.xitem,
        ],
      );

      if (existingRecords.isNotEmpty)  {
        result = await dbClient.update(
          DBHelper.caCusDisc,
          {

            'xdisc': caCusDiscModel.xdisc,
            'xdateeff': caCusDiscModel.xdateeff,
            'xdateexp': caCusDiscModel.xdateexp,
          },
          where: 'xcus = ? AND xitem = ?',
          whereArgs: [
            caCusDiscModel.xcus,
            caCusDiscModel.xitem,
          ],
        );
      }else {
        result = await dbClient.insert(
          DBHelper.caCusDisc,
          caCusDiscModel.toJson(),
        );
      }

      print("-------------$result");
    } catch (e) {
      print('There are some issues in insertIntoCaCusDiscTable: $e');
    }
    return result;
  }


// Future<void> deleteGiftPromoTable() async {
//   var dbClient = await conn.db;
//   dbClient!.delete(DBHelper.giftAndPromotion);
//   print("Table deleted successfully");
// }
//
// //cartHeaderInfo
// Future getGiftPromo() async {
//   var dbClient = await conn.db;
//   List gpList = [];
//   try {
//     List<Map<String, dynamic>> maps = await dbClient!
//         .rawQuery("SELECT * FROM ${DBHelper.giftAndPromotion}");
//     for (var gpitems in maps) {
//       gpList.add(gpitems);
//     }
//   } catch (e) {
//     print("There are some issues getting products : $e");
//   }
//   // print("All cart product from Header: $cartList");
//   return gpList;
// }
}
