import '../module/model/ca_cus_price_model.dart';
import '../module/model/dealer_model.dart';
import '../module/model/gift_promo_model.dart';
import '../module/model/product_accessories_model.dart';
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

  Future getProduct(String dealerType) async{
    var dbClient = await conn.db;
    List productList = [];
    try{
      if(dealerType == 'Dealer'){
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery('SELECT xitem, xdesc, xunit,color, xdealerp as totrate, xpnature FROM ${DBHelper.productTable} where xpnature = "Tank"' );
        for(var products in maps){
          productList.add(products);
          print('Product List from repo : $productList');
        }
      }else if(dealerType == 'Corporate'){
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery('SELECT xitem, xdesc, xunit,color, xrate as totrate, xpnature FROM ${DBHelper.productTable} where xpnature = "Tank"');
        for(var products in maps){
          productList.add(products);
          print('Product List from repo : $productList');
        }
      }else{
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery('SELECT xitem, xdesc, xunit,color, xmrp as totrate, xpnature FROM ${DBHelper.productTable} where xpnature = "Tank"');
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


  ///Product-Accessories Tbale Section

  //for product table CRUD
  Future<int> addProductAccessories(ProductAccessoriesModel productAccessoriesModel) async{
    var dbClient = await conn.db;
    int result = 0;
    try{
      result = await dbClient!.insert(DBHelper.productAccessories, productAccessoriesModel.toJson());
      print("-------------$result");
    }catch(e){
      print('There are some issues inserting product accessories table : $e');
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

  Future getProductAccessories() async{
    var dbClient = await conn.db;
    List productAccessoriesList = [];
    try{
      List<Map<String, dynamic>> maps = await dbClient!.query(DBHelper.productAccessories);
      for(var productAcs in maps){
        productAccessoriesList.add(productAcs);
        print('Product List from repo : $productAccessoriesList');
      }
    }catch(e){
      print("There are some issues getting products : $e");
    }
    return productAccessoriesList;
  }

  Future<void> dropProductAccessoriesTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.productAccessories);
    print("Accessories table deleted successfully");
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
    print('Called from cartDetailsInsert');
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


  Future<void> cartTableAccInsert(String xitem, String zid, String cartID ) async{
    print('Called from cartTableAccInsert');
    var dbClient = await conn.db;
    int result = 0;
    try{
      var result = await dbClient!.rawQuery('''
        INSERT INTO ${DBHelper.cartDetailsTable} (zid,  cartID, xitem,  xdesc, xunit,  xrate, xqty, subTotal, yes_no, xmasteritem)
        SELECT zid, ?, xitem, accName, xunit, 0, xqty, 0,'Yes',  ? 
        FROM ${DBHelper.cartAccessoriesTable}
        WHERE xmasteritem = ? and zid =?
      ''', [cartID,xitem, xitem, zid]);
       print("Inserted Successfully in details table : -------------$result");
    }catch(e){
      print('There are some issues inserting product from accessoories table to cart details table: $e');
    }
  }

  /*zid INTEGER,
      cartID VARCHAR(150) NOT NULL,
      xitem VARCHAR(150),
  xdesc VARCHAR(150),
  xunit VARCHAR(150),
  xrate REAL,
      xqty REAL,
  subTotal REAL,
  yes_no VARCHAR(20),
  xmasteritem VARCHAR(20),*/

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

  //For inserting into cartAccessories table
  Future<void> cartAccessoriesInsert(String xitem, String zid) async{
    var dbClient = await conn.db;
    try{
      var existingRow = await dbClient!.rawQuery('''
      SELECT * FROM ${DBHelper.cartAccessoriesTable}
      WHERE zid = ? AND xmasteritem = ?
      ''', [zid, xitem]);

      print("length of row: ${existingRow.length}");

      if (existingRow.isNotEmpty) {
        for(int i = 0; i< existingRow.length; i++){
          var productAcc = await dbClient.rawQuery('''
          SELECT CAST(xqty AS INTEGER) as xqty FROM ${DBHelper.productAccessories}
          WHERE zid = ? AND xitemaccessories = ? AND xitem = ?
        ''', [zid, existingRow[i]['xitem'], xitem]);
          print('Searched from PA Table = ${int.parse(productAcc[0]['xqty'].toString())}') ;
          print('Searched from CA Table = ${(existingRow[i]['xqty'] as double)}') ;

          var founded = productAcc[0]['xqty'] as int;
          var newQty = (existingRow[i]['xqty'] as double) + founded ; // cast to int before adding 1
          print("newQty: -------------$newQty");
          var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartAccessoriesTable}
          SET xqty = ?
           WHERE zid = ? AND xmasteritem = ? AND xitem = ?
            ''', [newQty, zid, xitem, existingRow[i]['xitem']]);
          print("Updated Successfully into cartAccessoriesTable table: -------------$result");
        }
        // Combination of zid and xmasteritem already exists, update the quantity

      } else {
        // Combination of zid and xmasteritem does not exist, insert a new row
        var result = await dbClient.rawQuery('''
        INSERT INTO ${DBHelper.cartAccessoriesTable} (zid,  xitem, accName, xqty, xunit, xmasteritem)
        SELECT zid, xitemaccessories, name, xqty, xunit, xitem
        FROM ${DBHelper.productAccessories}
        WHERE xitem = ? and zid =?
      ''', [xitem, zid]);
        print("Inserted Successfully into cartAccessoriesTable table: -------------$result");
      }
    } catch(e){
      print('There are some issues inserting/updating cartTable: $e');
    }
  }

//Method for only inserting accessories to cartAccories table
  Future<void> additionalAccessoriesInsert(String xitem, String zid, String masteritem, String qty) async{
    var dbClient = await conn.db;
    try{
      var existingRow = await dbClient!.rawQuery('''
      SELECT * FROM ${DBHelper.cartAccessoriesTable}
      WHERE zid = ? AND xmasteritem = ? AND xitem = ?
      ''', [zid, masteritem, xitem]);

      print("length of row of new added item acc: ${existingRow.length}");

      if (existingRow.isNotEmpty) {
        var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartAccessoriesTable}
          SET xqty = xqty +1
           WHERE zid = ? AND xmasteritem = ? AND xitem = ?
            ''', [ zid, masteritem, xitem]);
        print("Updated Successfully into cartAccessoriesTable table: -------------$result");
        // Combination of zid and xmasteritem already exists, update the quantity

      } else {
        // Combination of zid and xmasteritem does not exist, insert a new row
        var sqlResult = await dbClient.rawQuery('''
          INSERT INTO ${DBHelper.cartAccessoriesTable} (zid, xitem, accName, xqty, xunit, xmasteritem)
          VALUES (?, ?, (SELECT name FROM ${DBHelper.productAccessories} WHERE xitemaccessories = ? LIMIT 1),
                  ?, (SELECT xunit FROM ${DBHelper.productAccessories} WHERE xitemaccessories = ? LIMIT 1), ?)
        ''', [zid, xitem, xitem, qty, xitem, masteritem]);

        if (sqlResult != -1) {
          print("Inserted Successfully into cartAccessoriesTable: $sqlResult");
        } else {
          print("Failed to insert into cartAccessoriesTable");
        }
      }
    } catch(e){
      print('There are some issues inserting/updating cartTable: $e');
    }
  }

  //for getting product wise accessories list from cart screen to cart accessories screen
  Future<List<Map<String, dynamic>>> getAccessories(String xitem) async {
    var dbClient = await conn.db;
    try {
      var acccItem = await dbClient!.rawQuery('''
      SELECT zid, xitem, accName, xunit, xqty, xmasteritem  
      FROM ${DBHelper.cartAccessoriesTable}
      WHERE xmasteritem = ?
    ''', [xitem]);
      print('Accessories List = $acccItem') ;
      return acccItem;
    } catch(e) {
      print('There are some issues for getting cartAccessoriesTable: $e');
      return [];
    }
  }

  //Method for getting all Accessories list
  Future<List<Map<String, dynamic>>> getAllAccessoriesList(String zid) async {
    var dbClient = await conn.db;
    try {
      var accList = await dbClient!.rawQuery('''
      SELECT DISTINCT xitemaccessories, name, xunit, xqty
      FROM productAccessories
      WHERE zid = ?
    ''', [zid]);
      print('Accessories List = $accList') ;
      return accList;
    } catch(e) {
      print('There are some issues for getting accessories list: $e');
      return [];
    }
  }



  //Update Accessories for inside accessories page
  Future<void> updateAccessories(String xitem, String xmasteritem, int qtyChange) async {
    var dbClient = await conn.db;
    try {
      var result = await dbClient!.rawQuery('''
        UPDATE ${DBHelper.cartAccessoriesTable}
        SET xqty = xqty + ?
        WHERE xmasteritem = ? AND xitem = ?
        ''', [qtyChange, xmasteritem, xitem]);
      print('Accessories List = $result');

      // Check if xqty is less than or equal to 0
      var xqtyResult = await dbClient.rawQuery('''
        SELECT xqty FROM ${DBHelper.cartAccessoriesTable}
        WHERE xmasteritem = ? AND xitem = ?
        ''', [xmasteritem, xitem]);
      print("the updated qty : $xqtyResult");
      print("the updated qty : ${xqtyResult.first['xqty']}");
      if (xqtyResult.isNotEmpty && xqtyResult.first['xqty'] as double <= 0) {
        print("the updated qty : $xqtyResult");
        await dbClient.rawQuery('''
          DELETE FROM ${DBHelper.cartAccessoriesTable}
          WHERE xmasteritem = ? AND xitem = ?
          ''', [xmasteritem, xitem]);
        print('Accessory deleted');
      }

    } catch(e) {
      print('There are some issues for getting cartAccessoriesTable: $e');
    }
  }

  //update accessories from cart page
  Future<void> updateFromCartScreenAccessories(String zid,String xmasteritem, int qtyChange) async {
    var dbClient = await conn.db;
    print('Qty from cart screen: $qtyChange');
    try{
      if (qtyChange==0) {
        print("the updated qty : $qtyChange");
        await dbClient!.rawQuery('''
          DELETE FROM ${DBHelper.cartAccessoriesTable}
          WHERE xmasteritem = ?
          ''', [xmasteritem]);
        print('Accessory deleted');
      }else{
        var existingRow = await dbClient!.rawQuery('''
        SELECT * FROM ${DBHelper.cartAccessoriesTable}
        WHERE xmasteritem = ?
        ''', [xmasteritem]);

        print("length of row: ${existingRow.length}");

        if (existingRow.isNotEmpty) {
          for(int i = 0; i< existingRow.length; i++){
            // cast to int before adding 1
            var qtyFromPA = await dbClient.rawQuery('''
             SELECT CAST(xqty AS INTEGER) as xqty FROM ${DBHelper.productAccessories}
             WHERE zid = ? AND xitemaccessories = ? AND xitem = ?
           ''', [zid, existingRow[i]['xitem'], xmasteritem]);
            var qty = qtyFromPA[0]['xqty'];
            print("Length of qtyFromPA: -------------${qtyFromPA.length}");

            print("newQty from for loop: -------------$qty");
            var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartAccessoriesTable}
          SET xqty = ? * ?
           WHERE xmasteritem = ? AND xitem = ?
            ''', [qty,qtyChange,xmasteritem, existingRow[i]['xitem']]);
            print("Updated Successfully into cartAccessoriesTable table: -------------$result");


          }
          // Combination of zid and xmasteritem already exists, update the quantity

        }
      }
    } catch(e){
      print('There are some issues inserting/updating cartTable: $e');
    }
  }

  Future<bool> deleteAccessory() async {
    var dbClient = await conn.db;
    try {
      await dbClient!.rawDelete('''
      DELETE FROM ${DBHelper.cartAccessoriesTable}
      ''');
      return true;
    } catch(e) {
      print('There are some issues for deleting accessory: $e');
      return false;
    }
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
      cartHeaderDetails = await dbClient!.rawQuery("Select * FROM ${DBHelper.cartDetailsTable} WHERE cartID = ? AND yes_no = 'No'",[cartId]);
      print('Product: $cartHeaderDetails');
      print('Product details length: ${cartHeaderDetails.length}');
    }catch(e){
      print("There are some issues: $e");
    }
    return cartHeaderDetails;
  }

  //for uploading all cart details
  Future getAllCartDetailsList(String cartId) async{
    var dbClient = await conn.db;
    List cartHeaderDetails = [];
    try{
      cartHeaderDetails = await dbClient!.rawQuery("Select * FROM ${DBHelper.cartDetailsTable} WHERE cartID = ?",[cartId]);
      print('Product: $cartHeaderDetails');
      print('Product details length: ${cartHeaderDetails.length}');
    }catch(e){
      print("There are some issues: $e");
    }
    return cartHeaderDetails;
  }

  //for place order purpose
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

  //for history accessories list from history accessories screen
  Future getCartHistoryAccessories(String cartId,String productID) async{
    var dbClient = await conn.db;
    List cartHistoryAccessories = [];
    try{
      cartHistoryAccessories = await dbClient!.rawQuery("Select * FROM ${DBHelper.cartDetailsTable} WHERE cartID = ? AND yes_no = 'Yes' AND xmasteritem = ?",[cartId, productID]);
      print('Product: $cartHistoryAccessories');
    }catch(e){
      print("There are some issues: $e");
    }
    return cartHistoryAccessories;
  }


  //for update item details wise cart details acc qty by pressing eidt button from cart details screen
  Future updateCartHistoryAccessories(String zid,String xmasteritem, int qtyChange, String cartID) async{
    var dbClient = await conn.db;
    print('Qty from cart screen: $qtyChange');
    try{
      if (qtyChange==0) {
        print("the updated qty : $qtyChange");
        await dbClient!.rawQuery('''
          DELETE FROM ${DBHelper.cartDetailsTable}
          WHERE xmasteritem = ? AND cartID = ? AND zid = ?
          ''', [xmasteritem, cartID, zid]);
        print('Accessory deleted');
      }else{
        var existingRow = await dbClient!.rawQuery('''
        SELECT * FROM ${DBHelper.cartDetailsTable}
        WHERE xmasteritem = ? AND cartID = ? AND zid = ? AND yes_no = 'Yes'
        ''', [xmasteritem,cartID, zid]);

        print("length of row: ${existingRow.length}");

        if (existingRow.isNotEmpty) {
          for(int i = 0; i< existingRow.length; i++){
            // cast to int before adding 1
            var qtyFromPA = await dbClient.rawQuery('''
             SELECT CAST(xqty AS INTEGER) as xqty FROM ${DBHelper.productAccessories}
             WHERE zid = ? AND xitemaccessories = ? AND xitem = ?
           ''', [zid, existingRow[i]['xitem'], xmasteritem]);
            var qty = qtyFromPA[0]['xqty'];
            print("Length of qtyFromPA: -------------${qtyFromPA.length}");

            print("newQty from for loop: -------------$qty");
            var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartDetailsTable}
          SET xqty = ? * ?
           WHERE xmasteritem = ? AND xitem = ? AND cartID = ? AND zid = ? AND yes_no = 'Yes'
            ''', [qty,qtyChange,xmasteritem, existingRow[i]['xitem'], cartID, zid,]);
            print("Updated Successfully into cartAccessoriesTable table: -------------$result");

          }
          // Combination of zid and xmasteritem already exists, update the quantity

        }
      }
    } catch(e){
      print('There are some issues inserting/updating cartTable: $e');
    }
  }


  ///Order history calculation and all data related segments
  Future updateCartDetailsTable(String cartID, String itemCode, String qty, String price) async{
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
      print('Total = $total');
      dbClient!.rawQuery(
          "UPDATE ${DBHelper.cartDetailsTable} "
              "SET xqty = ?,subTotal = ?"
              " WHERE cartID = ? and xitem = ?", [qty,total,cartID,itemCode]);

      await updateCartHeader(cartID);
    }
  }


  //for edit from Accessories history screen
  Future updateFromAccHistoryScreen(String cartID, String accCode, String qty, String zid) async{
    var dbClient = await conn.db;
    print("Quantity inside updateFromAccHistoryScreen: $qty");
    if(qty == '0'){
      await dbClient!.rawQuery('''
          DELETE FROM ${DBHelper.cartDetailsTable}
          WHERE xitem = ? AND cartID = ? AND zid = ?
          ''', [accCode, cartID, zid]);
    }else{

      print('Quantity = $qty');

      dbClient!.rawQuery(
          "UPDATE ${DBHelper.cartDetailsTable} "
              "SET xqty = ?"
              " WHERE cartID = ? and xitem = ?", [qty,cartID,accCode]);

      //await updateCartHeader(cartID);
    }
  }

  Future updateCartHeader(String cartID) async {
    var dbClient = await conn.db;

    var subTotalResult = await dbClient!.rawQuery(
      "SELECT SUM(subTotal) as subTotalSum FROM ${DBHelper.cartDetailsTable} WHERE cartID = ?",
      [cartID],
    );
    print('Total in Details table = ${subTotalResult[0]["subTotalSum"]}');

    await dbClient.update(
      DBHelper.cartTable,
      {'total': subTotalResult[0]["subTotalSum"]},
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