import '../module/model/ca_cus_disc_model.dart';
import '../module/model/gift_promo_model/gift_promo_model.dart';
import '../module/model/gift_promo_model/promo_details_model.dart';
import '../module/model/gift_promo_model/promo_header_model.dart';
import 'database_helper.dart';

class GiftPromoRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Gift and Promotion item repo
  Future<int> insertIntoGiftItem(GiftModel giftModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      var existingRecords = await dbClient!.query(
        DBHelper.giftItem,
        where: 'zid = ? AND xitem = ? AND xgiftitem = ?',
        whereArgs: [
          giftModel.zid,
          giftModel.xitem,
          giftModel.xgiftitem,
        ],
      );

      if (existingRecords.isNotEmpty) {
        result = await dbClient.update(
          DBHelper.giftItem,
          {
            'xwh': giftModel.xwh,
            'xqty': giftModel.xqty,
            'xqtybonus': giftModel.xqtybonus,
            'xdateeff': giftModel.xdateeff,
            'xdateexp': giftModel.xdateexp,
          },
          where: 'zid = ? AND xitem = ? AND xgiftitem = ?',
          whereArgs: [
            giftModel.zid,
            giftModel.xitem,
            giftModel.xgiftitem,
          ],
        );
      } else {
        result = await dbClient.insert(
          DBHelper.giftItem,
          giftModel.toJson(),
        );
      }
    } catch (e) {
      print('There are some issues insertIntoGiftItem : $e');
    }
    return result;
  }

  Future<void> deleteGiftItemTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.giftItem);
  }

  //getGiftItem
  Future getGiftItem(String xitem, String zId) async {
    var dbClient = await conn.db;
    List gpList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
          "SELECT * FROM ${DBHelper.giftItem} Where xitem =? AND zid = ?",
          [xitem, zId]);
      for (var gpitems in maps) {
        gpList.add(gpitems);
      }
    } catch (e) {
      print("There are some issues getting products getGiftItem : $e");
    }
    return gpList;
  }

  ///getAll giftPromoDetails
  Future getAllPromoItems(String zId) async {
    var dbClient = await conn.db;
    List promoList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
          "SELECT * FROM ${DBHelper.promoDetails} Where zid = ?", [zId]);
      for (var promos in maps) {
        promoList.add(promos);
      }
    } catch (e) {
      print("There are some issues getting products getAllPromoItems: $e");
    }
    return promoList;
  }

  ///Promotion Header
  Future<int> insertIntoPromoHeaderTable(
      PromoHeaderModel promoHeaderModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      var existingRecords = await dbClient!.query(
        DBHelper.promoHeader,
        where: 'xtrnnum = ? AND zid = ?',
        whereArgs: [
          promoHeaderModel.xtrnnum,
          promoHeaderModel.zid,
        ],
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
          whereArgs: [
            promoHeaderModel.xtrnnum,
            promoHeaderModel.zid,
          ],
        );
      } else {
        result = await dbClient.insert(
          DBHelper.promoHeader,
          promoHeaderModel.toJson(),
        );
      }
    } catch (e) {
      print('There are some issues insertIntoPromoHeaderTable: $e');
    }
    return result;
  }

  /// Promotion details
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
    } catch (e) {
      print('There are some issues insertIntoPromoDetailsTable: $e');
    }
    return result;
  }

  /// CaCusDisc table
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

      if (existingRecords.isNotEmpty) {
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
      } else {
        result = await dbClient.insert(
          DBHelper.caCusDisc,
          caCusDiscModel.toJson(),
        );
      }
    } catch (e) {
      print('There are some issues in insertIntoCaCusDiscTable: $e');
    }
    return result;
  }

  Future getFromCaCusDiscTable(String xcus, String xitem) async {
    var dbClient = await conn.db;
    List caCusDisc = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
          "SELECT * FROM ${DBHelper.caCusDisc} WHERE xcus =? AND xitem = ?",
          [xcus, xitem]);
      for (var cusDisList in maps) {
        caCusDisc.add(cusDisList);
      }
    } catch (e) {
      print("There are some issues getting products : $e");
    }
    // print("All cart product from Header: $cartList");
    return caCusDisc;
  }
}
