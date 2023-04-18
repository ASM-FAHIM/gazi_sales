import '../module/model/ca_cus_price_model.dart';
import '../module/model/dealer_model.dart';
import '../module/model/gift_promo_model.dart';
import '../module/model/product_model.dart';
import 'database_helper.dart';

class DatabaseRepo{
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Dealer Table Section
  Future<int> addDealer(DealerModel dealerModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.dealerTable, dealerModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  Future<int?> updateDealer(DealerModel dealerModel) async{
    var dbClient = await conn.db;
    int? result;
    try{
      result = await dbClient!.update(DBHelper.dealerTable, dealerModel.toJson(), where: "id=?", whereArgs: [dealerModel.id]);
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  /*Future getDealer() async{
    var dbClient = await conn.db;
    List dealerList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.dealerTable);
      for(var dealers in maps){
        dealerList.add(dealers);
      }
    }catch(e){
      print("There are some issues: $e");
    }
    return dealerList;
  }*/

  Future getDealer(String xterritory, String zid) async{
    var dbClient = await conn.db;
    List dealerList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(
          DBHelper.dealerTable,
          where: "xterritory=? AND zid=?",
          whereArgs: [xterritory, zid]
      );
      for(var dealers in maps){
        dealerList.add(dealers);
      }
    }catch(e){
      print("There are some issues: $e");
    }
    return dealerList;
  }

  Future<List<Map<String, dynamic>>> getDealersByName(String name) async {
    // Open the connection to the database
    var dbClient = await conn.db;
    List<Map<String, dynamic>> dealerNameList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.dealerTable, where: 'xorg=?', whereArgs: [name]);
      for(var dealers in maps){
        dealerNameList.add(dealers);
      }
      return dealerNameList;
    }catch(e){
      print("There are some issues: $e");
    }
    return dealerNameList;
  }

  Future<void> dropTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.dealerTable);
    print("Table deleted successfully");
  }

  /*Future<int> deleteDealer(int zid) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(dbHelper.tableDealer, where: "zid = ?", whereArgs: [zid]);
  }*/

  ///Product Tbale Section

  //for product table CRUD
  Future<int> addProduct(ProductModel productModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.productTable, productModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues inserting product: $e');
    }
    return result;
  }


  Future<int?> updateProduct(ProductModel productModel) async{
    var dbClient = await conn.db;
    int? result;
    try{
      result = await dbClient!.update(DBHelper.productTable, productModel.toJson(), where: "id=?", whereArgs: [productModel.id]);
    }catch(e){
      print('There are some issues updating products: $e');
    }
    return result;
  }

  /*Future getProduct(String dealerType) async{
    var dbClient = await conn.db;
    List productList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.productTable);
      for(var products in maps){
        productList.add(products);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    return productList;
  }*/

  Future getProduct(String dealerType) async{
    var dbClient = await conn.db;
    List productList = [];
    try{
      if(dealerType == 'Dealer' || dealerType == 'Corporate'){
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery('SELECT xitem, xdesc, xunitsel, CAST(dealrate as int) as totrate, CAST(xpackqty as int) as packQty FROM ${DBHelper.productTable}');
        for(var products in maps){
          productList.add(products);
          print('Product List from repo : $productList');
        }
      }else{
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery('SELECT xitem, xdesc, xunitsel, totrate, CAST(xpackqty as int) as packQty  FROM ${DBHelper.productTable}');
        for(var products in maps){
          productList.add(products);
          print('Product List from repo : $productList');
        }
      }

    }catch(e){
      print("There are some issues getting products : $e");
    }
    return productList;
  }

  Map<String, dynamic>? _product;
  Future getSpecificProductsInfo(String xitem) async{
    var dbClient = await conn.db;
    List productList = [];
    try{
      productList = await dbClient!.query(
        DBHelper.productTable,
        where: 'xitem = ?',
        whereArgs: [xitem],
      );
      _product = productList.first;
      print('Product: $_product');
      return _product;
    }catch(e){
      print("There are some issues: $e");
    }
    return productList;
  }

  Future<void> dropProductTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.productTable);
    print("Table deleted successfully");
  }

  ///Cart table Section

  //For inserting into cart table and cart_details table
  Future<int> cartInsert(Map<String, dynamic> data ) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.cartTable, data);
      print("Inserted Successfully in header table: -------------$result");
    }catch(e){
      print('There are some issues inserting cartTable: $e');
    }
    return result;
  }

  //first need cartId for insert value in details table
  Future<int> getCartID() async{
    var dbClient = await conn.db;
    List cartId = [];
    try{
      cartId = await dbClient!.rawQuery('SELECT COUNT(*) as cartID from ${DBHelper.cartTable} order by id desc');
    }catch(e){
      print("There are some issues: $e");
    }
    return cartId.isEmpty ? 0 : cartId[0]['cartID'];
  }

  //inserting cart_details table
  Future<int> cartDetailsInsert(Map<String, dynamic> data ) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.cartDetailsTable, data);
      // print("Inserted Successfully in details table : -------------$result");
    }catch(e){
      print('There are some issues inserting product: $e');
    }
    return result;
  }

  //cartHeaderInfo
  Future getCartHeader() async{
    var dbClient = await conn.db;
    List cartList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery("SELECT * FROM ${DBHelper.cartTable} WHERE xstatus = 'Open' order by id desc");
      for(var products in maps){
        cartList.add(products);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    // print("All cart product from Header: $cartList");
    return cartList;
  }

  //cartHeaderInfo only for sync
  Future getCartHeaderForSync() async{
    var dbClient = await conn.db;
    List cartListForSync = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery("SELECT * FROM ${DBHelper.cartTable} WHERE xstatus = 'Applied' order by id desc");
      for(var cartSync in maps){
        cartListForSync.add(cartSync);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    // print("All cart product from Header: $cartList");
    return cartListForSync;
  }

  //delete cart header Table
  Future<void> dropCartHeaderTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.cartTable);
    print("Table deleted successfully");
  }

  //delete item wise cart
  Future<void> deleteItemWiseCartHeader(String cartId) async {
    await deleteItemWiseCartDetails(cartId);
    var dbClient = await conn.db;
    await dbClient!.rawQuery('DELETE FROM ${DBHelper.cartTable} WHERE cartId = ?', [cartId]);
  }
  //delete item wise cart
  Future<void> deleteItemWiseCartDetails(String cartId) async {
    var dbClient = await conn.db;
    await dbClient!.rawQuery('DELETE FROM ${DBHelper.cartDetailsTable} WHERE cartId = ?', [cartId]);
  }


  //delete cart header Table using cartID
  Future<void> dropSyncedCartID(String cartId) async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.cartTable, where: "cartId =?", whereArgs: [cartId]);
    print("Table deleted successfully");
  }

  //delete cart details info
  Future<void> dropCartDetailsTable(String cartId) async {
    var dbClient = await conn.db;
    await dbClient!.rawQuery('DELETE FROM ${DBHelper.cartDetailsTable} WHERE cartId = ?', [cartId]);
  }

  //delete cart details info table
  Future<void> dropCartDetails() async {
    var dbClient = await conn.db;
    await dbClient!.delete(DBHelper.cartDetailsTable);
  }



/*  Map<String, dynamic>? singleHeader;
  Future deleteSingleCartInfo(String cartId) async{
    var dbClient = await conn.db;
    List singleCartList = [];
    try{
      singleCartList = await dbClient!.rawQuery('DELETE FROM ${DBHelper.cartDetailsTable} WHERE cartId = ?', [cartId]);
      cartHeaderList = await dbClient.rawQuery('DELETE FROM ${DBHelper.cartTable} WHERE cartId = ?', [cartId]);
      singleHeader = cartHeaderList.first;
      print('CartHeader: $singleHeader');
      return singleHeader;
    }catch(e){
      print("There are some issues: $e");
    }
    return singleHeader;
  }*/

  Future updateCartHeaderTable(String cartId) async{
    var dbClient = await conn.db;
    dbClient!.rawQuery("UPDATE ${DBHelper.cartTable} SET xstatus = 'Applied' WHERE cartID = ?",[cartId]);
    print(getCartHeader());
  }

  Future getCartHeaderDetails(String cartId) async{
    var dbClient = await conn.db;
    List cartHeaderDetails = [];
    try{
      cartHeaderDetails = await dbClient!.query(
        DBHelper.cartDetailsTable,
        where: 'cartId = ?',
        whereArgs: [cartId],
        orderBy: 'cartId DESC',
      );
      print('Product: $cartHeaderDetails');
    }catch(e){
      print("There are some issues: $e");
    }
    return cartHeaderDetails;
  }

  Future getCartHeaderDetailsForSync(String cartId) async{
    var dbClient = await conn.db;
    List cartHeaderDetailsForSync = [];
    try{
      cartHeaderDetailsForSync = await dbClient!.query(
        DBHelper.cartDetailsTable,
        where: 'cartId = ?',
        whereArgs: [cartId],
        orderBy: 'cartId DESC',
      );
      print('Product: $cartHeaderDetailsForSync');
    }catch(e){
      print("There are some issues: $e");
    }
    return cartHeaderDetailsForSync;
  }

  ///Order history calculation and all data related segments
  Future updateCartDetailsTable(String cartID, String itemCode, String qty, String price, String packQty) async{
    var dbClient = await conn.db;
    if(qty == '0'){
      await dbClient!.delete(
        DBHelper.cartDetailsTable,
        where: 'cartID = ? AND xitem = ?',
        whereArgs: [cartID, itemCode],
      );
    }else{
      print('Price = $price');
      print('Quantity = $qty');
      var total= double.parse(qty) * double.parse(price);
      var subPackQty= double.parse(qty) * double.parse(packQty);
      print('Total = $total');
      dbClient!.rawQuery(
          "UPDATE ${DBHelper.cartDetailsTable} "
              "SET xqty = ?,subTotal = ?, subPackQty = ? "
              " WHERE cartID = ? and xitem = ?", [qty,total,subPackQty,cartID,itemCode]);

      await updateCartHeader(cartID);
    }
  }

  Future updateCartHeader(String cartID) async {
    var dbClient = await conn.db;

    var subTotalResult = await dbClient!.rawQuery(
      "SELECT SUM(subTotal) as subTotalSum FROM ${DBHelper.cartDetailsTable} WHERE cartID = ?",
      [cartID],
    );

    var subPackQty = await dbClient.rawQuery(
      "SELECT SUM(subPackQty) as subTotalPack FROM ${DBHelper.cartDetailsTable} WHERE cartID = ?",
      [cartID],
    );

    print('Total in Details table = ${subTotalResult[0]["subTotalSum"]}');

    await dbClient.update(
      DBHelper.cartTable,
      {'total': subTotalResult[0]["subTotalSum"],
        'totalPackQty': subPackQty[0]["subTotalPack"]},
      where: 'cartID = ?',
      whereArgs: [cartID],
    );
  }


  Future getIDWiseCartHeader(String cartId) async{
    var dbClient = await conn.db;
    List idWiseCartList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(
          DBHelper.cartTable,
          where: 'cartId = ?',
          whereArgs: [cartId]
      );
      for(var idWiseCart in maps){
        idWiseCartList.add(idWiseCart);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    // print("All cart product from Header: $cartList");
    return idWiseCartList;
  }


  Future getIDWiseCartDetailsHeader(String cartId) async{
    var dbClient = await conn.db;
    List idWiseCartList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(
          DBHelper.cartDetailsTable,
          where: 'cartId = ?',
          whereArgs: [cartId]
      );
      for(var idWiseCart in maps){
        idWiseCartList.add(idWiseCart);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    // print("All cart product from Header: $cartList");
    return idWiseCartList;
  }



  ///Special Table caItemTable repo

  Future<int> addIntoCaCusPrice(CaCusPriceModel caCusPriceModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.caCusPrice, caCusPriceModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }
  Future getCusWisePrice() async{
    var dbClient = await conn.db;
    List cwpList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery("SELECT * FROM ${DBHelper.caCusPrice}");
      for(var cwpitems in maps){
        cwpList.add(cwpitems);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    // print("All cart product from Header: $cartList");
    return cwpList;
  }

  Future <void> deleteCaCusPriceTable() async{
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.caCusPrice);
    print("Table caCusPrice deleted successfully");
  }

  Future cuswiseprice(String cus, String xitem) async{
    var dbClient = await conn.db;
    var price = dbClient!.rawQuery("select xrate from ${DBHelper.caCusPrice} where xcus = ?  and xitem =?", [cus,xitem]);
    print("Got the product price:::::::$price");
    return price;
  }


  ///Gift and Promotion item repo
  Future<int> addgiftItem(GiftModel giftModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.giftAndPromotion, giftModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  Future<int> addPromotionItem(PromoModel promoModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.giftAndPromotion, promoModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues: $e');
    }
    return result;
  }

  Future <void> deleteGiftPromoTable() async{
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.giftAndPromotion);
    print("Table deleted successfully");
  }

  //cartHeaderInfo
  Future getGiftPromo() async{
    var dbClient = await conn.db;
    List gpList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery("SELECT * FROM ${DBHelper.giftAndPromotion}");
      for(var gpitems in maps){
        gpList.add(gpitems);
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    // print("All cart product from Header: $cartList");
    return gpList;
  }


}