import '../module/model/ca_cus_disc_model.dart';
import '../module/model/promo_details_model.dart';
import '../module/model/promo_header_model.dart';
import 'database_helper.dart';

class GiftPromoRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Promotion Header
  Future<int> insertIntoPromoHeaderTable(
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
  }

  /// Promotion details
  Future<int> insertIntoPromoDetailsTable(
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
  }

  /// CaCusDisc table
  Future<int> insertIntoCaCusDiscTable(CaCusDiscModel caCusDiscModel) async {
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
