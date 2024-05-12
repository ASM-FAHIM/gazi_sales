import '../module/model/ca_cus_price_model.dart';
import '../module/model/dealer_model.dart';
import '../module/model/product_accessories_model.dart';
import '../module/model/product_model.dart';
import '../module/model/product_nature_model.dart';
import 'database_helper.dart';

class DatabaseRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();

  ///Dealer Table Section
  Future<int> addDealer(DealerModel dealerModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      // Check if the zid exists in the dealer table
      int zidInt = dealerModel.zid; // No need to parse zid since it's already an int
      bool zidExists = await checkZidExists(DBHelper.dealerTable, zidInt);

      if (!zidExists) {
        // zid doesn't exist, delete all existing data from the table
        await dbClient!.delete(DBHelper.dealerTable);
      }

      // Check if the dealer already exists in the local storage
      var existingDealers = await dbClient!.query(
        DBHelper.dealerTable,
        where: 'zid = ? AND xcus = ?',
        whereArgs: [zidInt, dealerModel.xcus], // Use zidInt instead of dealerModel.zid
      );

      if (existingDealers.isEmpty) {
        // Dealer does not exist, proceed with insertion
        result = await dbClient.insert(DBHelper.dealerTable, dealerModel.toJson());
      } else {
        // Dealer already exists, perform update
        result = await dbClient.update(
          DBHelper.dealerTable,
          {
            'xorg': dealerModel.xorg,
            'xphone': dealerModel.xphone,
            'xmadd': dealerModel.xmadd,
            'xgcus': dealerModel.xgcus,
            'xterritory': dealerModel.xterritory,
            'xcontact': dealerModel.xcontact,
            'xmobile': dealerModel.xmobile,
            'xtso': dealerModel.xtso,
            'xzone': dealerModel.xzone,
            'xzm': dealerModel.xzm,
            'xdivision': dealerModel.xdivision,
            'xdm': dealerModel.xdm,
            'xthana': dealerModel.xthana,
            'xdistrict': dealerModel.xdistrict,
          },
          where: 'zid = ? AND xcus = ?',
          whereArgs: [zidInt, dealerModel.xcus], // Use zidInt instead of dealerModel.zid
        );
      }
    } catch (e) {
      print('There are some issues addDealer method : $e');
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

  Future getDealer(String xterritory, String zid) async {
    var dbClient = await conn.db;
    List dealerList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.query(
          DBHelper.dealerTable,
          where: "xterritory=? AND zid=?",
          whereArgs: [xterritory, zid]);
      for (var dealers in maps) {
        dealerList.add(dealers);
      }
    } catch (e) {
      print("There are some issues getDealer method : $e");
    }
    return dealerList;
  }

  Future<List<Map<String, dynamic>>> getDealersByName(String name) async {
    // Open the connection to the database
    var dbClient = await conn.db;
    List<Map<String, dynamic>> dealerNameList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!
          .query(DBHelper.dealerTable, where: 'xorg=?', whereArgs: [name]);
      for (var dealers in maps) {
        dealerNameList.add(dealers);
      }
      return dealerNameList;
    } catch (e) {
      print("There are some issues getDealersByName : $e");
    }
    return dealerNameList;
  }

  Future<void> dropTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.dealerTable);
  }

  /*Future<int> deleteDealer(int zid) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(dbHelper.tableDealer, where: "zid = ?", whereArgs: [zid]);
  }*/

  ///Product Tbale Section

  //insert product nature
  Future<int> insertProductNature(ProductNatureModel productNatureModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      // Check if the zid exists in the dealer table
      bool zidExists = await checkZidExists(DBHelper.productNature, productNatureModel.zid);

      if (!zidExists) {
        // zid doesn't exist, delete all existing data from the table
        await dbClient!.delete(DBHelper.productNature);
      }

      // Check if the product nature already exists in the local storage
      var existingProductNature = await dbClient!.query(
        DBHelper.productNature,
        where: 'zid = ? AND xcode = ?',
        whereArgs: [
          productNatureModel.zid,
          productNatureModel.xcode,
        ],
      );

      if (existingProductNature.isEmpty) {
        // Product nature does not exist, proceed with insertion
        result = await dbClient.insert(
          DBHelper.productNature,
          productNatureModel.toJson(),
        );
      } else {
        // Product nature already exists, perform update
        result = await dbClient.update(
          DBHelper.productNature,
          {
            'xlong': productNatureModel.xlong,
          },
          where: 'zid = ? AND xcode = ?',
          whereArgs: [
            productNatureModel.zid,
            productNatureModel.xcode,
          ],
        );
      }
    } catch (e) {
      print('There are some issues inserting product nature insertProductNature method : $e');
    }
    return result;
  }

  //get product natures from product nature table
  Future getProductNature(String zid) async {
    var dbClient = await conn.db;
    List productNatureList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!
          .query(DBHelper.productNature, where: 'zid = ?', whereArgs: [zid]);
      for (var productNatures in maps) {
        productNatureList.add(productNatures);
      }
    } catch (e) {
      print("There are some issues getting products nature getProductNature : $e");
    }
    return productNatureList;
  }

  //drop table product nature
  Future<void> dropProductNatureTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.productNature);
  }

  //for product table CRUD
  Future<int> addProduct(ProductModel productModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {

      // Check if the zid exists in the dealer table
      bool zidExists = await checkZidExists(DBHelper.productTable, productModel.zid);

      if (!zidExists) {
        // zid doesn't exist, delete all existing data from the table
        await dbClient!.delete(DBHelper.productTable);
      }

      // Check if the product already exists in the local storage
      var existingProducts = await dbClient!.query(
        DBHelper.productTable,
        where: 'zid = ? AND xitem = ?',
        whereArgs: [productModel.zid, productModel.xitem],
      );

      if (existingProducts.isEmpty) {
        // Product does not exist, proceed with insertion
        result =
            await dbClient.insert(DBHelper.productTable, productModel.toJson());
      } else {
        // Product already exists, perform update
        result = await dbClient.update(
          DBHelper.productTable,
          {
            'xdesc': productModel.xdesc,
            'xrate': productModel.xrate,
            'xdealerp': productModel.xdealerp,
            'xmrp': productModel.xmrp,
            'xcolor': productModel.xcolor,
            'color': productModel.color,
            'xdisc': productModel.xdisc,
            'xcapacity': productModel.xcapacity,
            'xunit': productModel.xunit,
            'xunitsel': productModel.xunitsel,
            'xcatitem': productModel.xcatitem,
            'xstype': productModel.xstype,
            'stype': productModel.stype,
            'xpnature': productModel.xpnature,
            'xdateeff': productModel.xdateeff,
            'xdateexp': productModel.xdateexp,
          },
          where: 'zid = ? AND xitem = ?',
          whereArgs: [productModel.zid, productModel.xitem],
        );
      }
    } catch (e) {
      print('There are some issues inserting product addProduct : $e');
    }
    return result;
  }

  Future getProduct(String zId, String dealerType, String pNature) async {
    var dbClient = await conn.db;
    List productList = [];
    try {
      if (dealerType == 'Dealer') {
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
            "SELECT xitem, xdesc, xunit, xcolor, color, xstype, stype, xpnature, xdisc, xcapacity, xdateeff, xdateexp,  xdealerp as totrate FROM ${DBHelper.productTable} Where xpnature = '$pNature'");
        for (var products in maps) {
          productList.add(products);
        }
      } else if (dealerType == 'Corporate') {
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
            "SELECT xitem, xdesc, xunit, xcolor, color, xstype, stype, xpnature, xdisc, xcapacity, xdateeff, xdateexp, xrate as totrate FROM ${DBHelper.productTable} Where xpnature = '$pNature'");
        for (var products in maps) {
          productList.add(products);
        }
      } else {
        List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
            "SELECT xitem, xdesc, xunit, xcolor, color, xstype, stype, xpnature, xdisc, xcapacity, xdateeff, xdateexp, mainRate as totrate FROM ${DBHelper.productTable} Where xpnature = '$pNature'");
        for (var products in maps) {
          productList.add(products);
        }
      }
    } catch (e) {
      print("There are some issues getting products getProduct : $e");
    }
    return productList;
  }

  Map<String, dynamic>? _product;

  Future getSpecificProductsInfo(String xitem) async {
    var dbClient = await conn.db;
    List productList = [];
    try {
      productList = await dbClient!.query(
        DBHelper.productTable,
        where: 'xitem = ?',
        whereArgs: [xitem],
      );
      _product = productList.first;
      return _product;
    } catch (e) {
      print("There are some issues getSpecificProductsInfo : $e");
    }
    return productList;
  }

  Future<void> dropProductTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.productTable);
  }

  ///Product-Accessories Tbale Section

  //for product accessories table CRUD
  Future<int> addProductAccessories(
      ProductAccessoriesModel productAccessoriesModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {

      bool zidExists = await checkZidExists(DBHelper.productAccessories, productAccessoriesModel.zid );

      if (!zidExists) {
        // zid doesn't exist, delete all existing data from the table
        await dbClient!.delete(DBHelper.productAccessories);
      }

      // Check if the product accessories entry already exists in the local storage
      var existingEntries = await dbClient!.query(
        DBHelper.productAccessories,
        where: 'zid = ? AND xitemaccessories = ? AND xitem = ?',
        whereArgs: [
          productAccessoriesModel.zid,
          productAccessoriesModel.xitemaccessories,
          productAccessoriesModel.xitem,
        ],
      );

      if (existingEntries.isEmpty) {
        // Product accessories entry does not exist, proceed with insertion
        result = await dbClient.insert(
          DBHelper.productAccessories,
          productAccessoriesModel.toJson(),
        );
      } else {
        // Product accessories entry already exists, perform update
        result = await dbClient.update(
          DBHelper.productAccessories,
          {
            'name': productAccessoriesModel.name,
            'xunit': productAccessoriesModel.xunit,
            'xqty': productAccessoriesModel.xqty,
          },
          where: 'zid = ? AND xitemaccessories = ? AND xitem = ?',
          whereArgs: [
            productAccessoriesModel.zid,
            productAccessoriesModel.xitemaccessories,
            productAccessoriesModel.xitem,
          ],
        );
      }
    } catch (e) {
      print('There are some issues inserting product accessories table addProductAccessories : $e');
    }
    return result;
  }

  Future getProductAccessories() async {
    var dbClient = await conn.db;
    List productAccessoriesList = [];
    try {
      List<Map<String, dynamic>> maps =
          await dbClient!.query(DBHelper.productAccessories);
      for (var productAcs in maps) {
        productAccessoriesList.add(productAcs);
      }
    } catch (e) {
      print("There are some issues getting products getProductAccessories : $e");
    }
    return productAccessoriesList;
  }

  Future<void> dropProductAccessoriesTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.productAccessories);
  }

  ///Cart table Section

  //For inserting into cart table and cart_details table
  Future<int> cartInsert(Map<String, dynamic> data) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!.insert(DBHelper.cartTable, data);
    } catch (e) {
      print('There are some issues inserting cartTable cartInsert : $e');
    }
    return result;
  }

  //first need cartId for insert value in details table
  Future<int> getCartID() async {
    var dbClient = await conn.db;
    List cartId = [];
    try {
      cartId = await dbClient!.rawQuery(
          'SELECT COUNT(*) as cartID from ${DBHelper.cartTable} order by id desc');
    } catch (e) {
      print("There are some issues getCartID : $e");
    }
    return cartId.isEmpty ? 0 : cartId[0]['cartID'];
  }

  //inserting cart_details table
  Future<int> cartDetailsInsert(Map<String, dynamic> data) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      result = await dbClient!.insert(DBHelper.cartDetailsTable, data);
    } catch (e) {
      print('There are some issues inserting product cartDetailsInsert : $e');
    }
    return result;
  }

  Future<void> cartTableAccInsert(
      String xitem, String zid, String cartID) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      var result = await dbClient!.rawQuery('''
        INSERT INTO ${DBHelper.cartDetailsTable} (zid,  cartID, xitem,  xdesc, xunit,  xrate, xqty, subTotal, yes_no, xmasteritem)
        SELECT zid, ?, xitem, accName, xunit, 0, xqty, 0,'Yes',  ? 
        FROM ${DBHelper.cartAccessoriesTable}
        WHERE xmasteritem = ? and zid =?
      ''', [cartID, xitem, xitem, zid]);
    } catch (e) {
      print(
          'There are some issues inserting product from accessoories table to cart details table cartTableAccInsert: $e');
    }
  }

  //cartHeaderInfo
  Future getCartHeader() async {
    var dbClient = await conn.db;
    List cartList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
          "SELECT * FROM ${DBHelper.cartTable} WHERE xstatus = 'Saved' order by id desc");
      for (var products in maps) {
        cartList.add(products);
      }
    } catch (e) {
      print("There are some issues getting products getCartHeader : $e");
    }
    // print("All cart product from Header: $cartList");
    return cartList;
  }


  // for check the zid when inserting
  Future<bool> checkZidExists(String tableName, int  zid) async {
    var dbClient = await conn.db;
    var result = await dbClient!.query(
      tableName,
      where: 'zid = ?',
      whereArgs: [zid],
    );
    return result.isNotEmpty;
  }

  //for deleting if the zid alreading has value
  Future<int> deleteAllFromTable(String tableName) async {
    var dbClient = await conn.db;
    return await dbClient!.delete(tableName);
  }

  //cartHeaderInfo only for sync
  Future getCartHeaderForSync() async {
    var dbClient = await conn.db;
    List cartListForSync = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.rawQuery(
          "SELECT * FROM ${DBHelper.cartTable} WHERE xstatus = 'Open' order by id desc");
      for (var cartSync in maps) {
        cartListForSync.add(cartSync);
      }
    } catch (e) {
      print("There are some issues getting products getCartHeaderForSync : $e");
    }
    // print("All cart product from Header: $cartList");
    return cartListForSync;
  }

  //delete cart header Table
  Future<void> dropCartHeaderTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.cartTable);
  }

  //delete item wise cart
  Future<void> deleteItemWiseCartHeader(String cartId) async {
    await deleteItemWiseCartDetails(cartId);
    var dbClient = await conn.db;
    await dbClient!.rawQuery(
        'DELETE FROM ${DBHelper.cartTable} WHERE cartId = ?', [cartId]);
  }

  //delete item wise cart
  Future<void> deleteItemWiseCartDetails(String cartId) async {
    var dbClient = await conn.db;
    await dbClient!.rawQuery(
        'DELETE FROM ${DBHelper.cartDetailsTable} WHERE cartId = ?', [cartId]);
  }

  //delete cart header Table using cartID
  Future<void> dropSyncedCartID(String cartId) async {
    var dbClient = await conn.db;
    dbClient!
        .delete(DBHelper.cartTable, where: "cartId =?", whereArgs: [cartId]);
  }

  //delete cart details info
  Future<void> dropCartDetailsTable(String cartId) async {
    var dbClient = await conn.db;
    await dbClient!.rawQuery(
        'DELETE FROM ${DBHelper.cartDetailsTable} WHERE cartId = ?', [cartId]);
  }

  //delete cart details info table
  Future<void> dropCartDetails() async {
    var dbClient = await conn.db;
    await dbClient!.delete(DBHelper.cartDetailsTable);
  }

  //For inserting into cartAccessories table
  Future<void> cartAccessoriesInsert(String xitem, String zid) async {
    var dbClient = await conn.db;
    try {
      var existingRow = await dbClient!.rawQuery('''
      SELECT * FROM ${DBHelper.cartAccessoriesTable}
      WHERE zid = ? AND xmasteritem = ?
      ''', [zid, xitem]);

      print("length of row: ${existingRow.length}");

      if (existingRow.isNotEmpty) {
        for (int i = 0; i < existingRow.length; i++) {
          var productAcc = await dbClient.rawQuery('''
          SELECT CAST(xqty AS INTEGER) as xqty FROM ${DBHelper.productAccessories}
          WHERE zid = ? AND xitemaccessories = ? AND xitem = ?
        ''', [zid, existingRow[i]['xitem'], xitem]);

          var founded = productAcc[0]['xqty'] as int;
          var newQty = (existingRow[i]['xqty'] as double) +
              founded; // cast to int before adding 1
          print("newQty: -------------$newQty");
          var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartAccessoriesTable}
          SET xqty = ?
           WHERE zid = ? AND xmasteritem = ? AND xitem = ?
            ''', [newQty, zid, xitem, existingRow[i]['xitem']]);
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
      }
    } catch (e) {
      print('There are some issues inserting/updating cartTable cartAccessoriesInsert: $e');
    }
  }

//Method for only inserting accessories to cartAccories table
  Future<void> additionalAccessoriesInsert(
      String xitem, String zid, String masteritem, String qty) async {
    var dbClient = await conn.db;
    try {
      var existingRow = await dbClient!.rawQuery('''
      SELECT * FROM ${DBHelper.cartAccessoriesTable}
      WHERE zid = ? AND xmasteritem = ? AND xitem = ?
      ''', [zid, masteritem, xitem]);

      if (existingRow.isNotEmpty) {
        var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartAccessoriesTable}
          SET xqty = xqty +1
           WHERE zid = ? AND xmasteritem = ? AND xitem = ?
            ''', [zid, masteritem, xitem]);
        // Combination of zid and xmasteritem already exists, update the quantity

      } else {
        // Combination of zid and xmasteritem does not exist, insert a new row
        var sqlResult = await dbClient.rawQuery('''
          INSERT INTO ${DBHelper.cartAccessoriesTable} (zid, xitem, accName, xqty, xunit, xmasteritem)
          VALUES (?, ?, (SELECT name FROM ${DBHelper.productAccessories} WHERE xitemaccessories = ? LIMIT 1),
                  ?, (SELECT xunit FROM ${DBHelper.productAccessories} WHERE xitemaccessories = ? LIMIT 1), ?)
        ''', [zid, xitem, xitem, qty, xitem, masteritem]);

        if (sqlResult != -1) {
        } else {
        }
      }
    } catch (e) {
      print('There are some issues inserting/updating cartTable additionalAccessoriesInsert: $e');
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
      return acccItem;
    } catch (e) {
      print('There are some issues for getting cartAccessoriesTable getAccessories : $e');
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
      return accList;
    } catch (e) {
      print('There are some issues for getting accessories list getAllAccessoriesList : $e');
      return [];
    }
  }

  //Update Accessories for inside accessories page
  Future<void> updateAccessories(
      String xitem, String xmasteritem, int qtyChange) async {
    var dbClient = await conn.db;
    try {
      var result = await dbClient!.rawQuery('''
        UPDATE ${DBHelper.cartAccessoriesTable}
        SET xqty = xqty + ?
        WHERE xmasteritem = ? AND xitem = ?
        ''', [qtyChange, xmasteritem, xitem]);

      // Check if xqty is less than or equal to 0
      var xqtyResult = await dbClient.rawQuery('''
        SELECT xqty FROM ${DBHelper.cartAccessoriesTable}
        WHERE xmasteritem = ? AND xitem = ?
        ''', [xmasteritem, xitem]);
      if (xqtyResult.isNotEmpty && xqtyResult.first['xqty'] as double <= 0) {
        await dbClient.rawQuery('''
          DELETE FROM ${DBHelper.cartAccessoriesTable}
          WHERE xmasteritem = ? AND xitem = ?
          ''', [xmasteritem, xitem]);
      }
    } catch (e) {
      print('There are some issues for getting cartAccessoriesTable updateAccessories : $e');
    }
  }

  //update accessories from cart page
  Future<void> updateFromCartScreenAccessories(
      String zid, String xmasteritem, int qtyChange) async {
    var dbClient = await conn.db;
    try {
      if (qtyChange == 0) {
        print("the updated qty : $qtyChange");
        await dbClient!.rawQuery('''
          DELETE FROM ${DBHelper.cartAccessoriesTable}
          WHERE xmasteritem = ?
          ''', [xmasteritem]);
      } else {
        var existingRow = await dbClient!.rawQuery('''
        SELECT * FROM ${DBHelper.cartAccessoriesTable}
        WHERE xmasteritem = ?
        ''', [xmasteritem]);

        if (existingRow.isNotEmpty) {
          for (int i = 0; i < existingRow.length; i++) {
            // cast to int before adding 1
            var qtyFromPA = await dbClient.rawQuery('''
             SELECT CAST(xqty AS INTEGER) as xqty FROM ${DBHelper.productAccessories}
             WHERE zid = ? AND xitemaccessories = ? AND xitem = ?
           ''', [zid, existingRow[i]['xitem'], xmasteritem]);
            var qty = qtyFromPA[0]['xqty'];
            var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartAccessoriesTable}
          SET xqty = ? * ?
           WHERE xmasteritem = ? AND xitem = ?
            ''', [qty, qtyChange, xmasteritem, existingRow[i]['xitem']]);
          }
          // Combination of zid and xmasteritem already exists, update the quantity

        }
      }
    } catch (e) {
      print('There are some issues inserting/updating cartTable updateFromCartScreenAccessories : $e');
    }
  }

  Future<bool> deleteAccessory() async {
    var dbClient = await conn.db;
    try {
      await dbClient!.rawDelete('''
      DELETE FROM ${DBHelper.cartAccessoriesTable}
      ''');
      return true;
    } catch (e) {
      print('There are some issues for deleting accessory deleteAccessory : $e');
      return false;
    }
  }

  Future updateCartHeaderTable(String cartId, String xopincapply) async {
    try {
      var dbClient = await conn.db;
      List updatedHeaderList = [];
      await dbClient!.rawQuery(
        "UPDATE ${DBHelper.cartTable} SET xstatus = 'Applied', xopincapply = ? WHERE cartID = ?",
        [xopincapply, cartId],
      );
      updatedHeaderList = await getCartHeader();
      return updatedHeaderList;
    } catch (error) {
      print('There was an issue updating the cart header status updateCartHeaderTable : $error');
    }
  }

  Future getCartHeaderDetails(String cartId) async {
    var dbClient = await conn.db;
    List cartHeaderDetails = [];
    try {
      cartHeaderDetails = await dbClient!.rawQuery(
          "Select * FROM ${DBHelper.cartDetailsTable} WHERE cartID = ? AND yes_no = 'No'",
          // AND giftStatus =! 'Gift Item'
          [cartId]);
    } catch (e) {
      print("There are some issues getCartHeaderDetails : $e");
    }
    return cartHeaderDetails;
  }

  //for uploading all cart details
  Future getAllCartDetailsList(String cartId) async {
    var dbClient = await conn.db;
    List cartHeaderDetails = [];
    try {
      cartHeaderDetails = await dbClient!.rawQuery(
          "Select * FROM ${DBHelper.cartDetailsTable} WHERE cartID = ?",
          [cartId]);
    } catch (e) {
      print("There are some issues getAllCartDetailsList : $e");
    }
    return cartHeaderDetails;
  }

  //for place order purpose
  Future getCartHeaderDetailsForSync(String cartId) async {
    var dbClient = await conn.db;
    List cartHeaderDetailsForSync = [];
    try {
      cartHeaderDetailsForSync = await dbClient!.query(
        DBHelper.cartDetailsTable,
        where: 'cartId = ? AND yes_no = ?',
        whereArgs: [cartId, 'No'],
        orderBy: 'cartId DESC',
      );
    } catch (e) {
      print("There are some issues getCartHeaderDetailsForSync : $e");
    }
    return cartHeaderDetailsForSync;
  }

  //for history accessories list from history accessories screen
  Future getCartHistoryAccessories(String cartId, String productID) async {
    var dbClient = await conn.db;
    List cartHistoryAccessories = [];
    try {
      cartHistoryAccessories = await dbClient!.rawQuery(
          "Select * FROM ${DBHelper.cartDetailsTable} WHERE cartID = ? AND yes_no = 'Yes' AND xmasteritem = ?",
          [cartId, productID]);
    } catch (e) {
      print("There are some issues getCartHistoryAccessories : $e");
    }
    return cartHistoryAccessories;
  }

  //for update item details wise cart details acc qty by pressing eidt button from cart details screen
  Future updateCartHistoryAccessories(
      String zid, String xmasteritem, int qtyChange, String cartID) async {
    var dbClient = await conn.db;
    try {
      if (qtyChange == 0) {
        await dbClient!.rawQuery('''
          DELETE FROM ${DBHelper.cartDetailsTable}
          WHERE xmasteritem = ? AND cartID = ? AND zid = ?
          ''', [xmasteritem, cartID, zid]);
      } else {
        var existingRow = await dbClient!.rawQuery('''
        SELECT * FROM ${DBHelper.cartDetailsTable}
        WHERE xmasteritem = ? AND cartID = ? AND zid = ? AND yes_no = 'Yes'
        ''', [xmasteritem, cartID, zid]);

        if (existingRow.isNotEmpty) {
          for (int i = 0; i < existingRow.length; i++) {
            // cast to int before adding 1
            var qtyFromPA = await dbClient.rawQuery('''
             SELECT CAST(xqty AS INTEGER) as xqty FROM ${DBHelper.productAccessories}
             WHERE zid = ? AND xitemaccessories = ? AND xitem = ?
           ''', [zid, existingRow[i]['xitem'], xmasteritem]);
            var qty = qtyFromPA[0]['xqty'];
            var result = await dbClient.rawQuery('''
          UPDATE ${DBHelper.cartDetailsTable}
          SET xqty = ? * ?
           WHERE xmasteritem = ? AND xitem = ? AND cartID = ? AND zid = ? AND yes_no = 'Yes'
            ''', [
              qty,
              qtyChange,
              xmasteritem,
              existingRow[i]['xitem'],
              cartID,
              zid,
            ]);
          }
          // Combination of zid and xmasteritem already exists, update the quantity

        }
      }
    } catch (e) {
      print('There are some issues inserting/updating cartTable updateCartHistoryAccessories : $e');
    }
  }

  ///Order history calculation and all data related segments
  Future updateCartDetailsTable(
      String cartID, String itemCode, String qty, String price) async {
    var dbClient = await conn.db;
    if (qty == '0') {
      await dbClient!.delete(
        DBHelper.cartDetailsTable,
        where: 'cartID = ? AND xitem = ?',
        whereArgs: [cartID, itemCode],
      );
    } else {
      var total = double.parse(qty) * double.parse(price);
      dbClient!.rawQuery(
          "UPDATE ${DBHelper.cartDetailsTable} "
          "SET xqty = ?,subTotal = ?"
          " WHERE cartID = ? and xitem = ?",
          [qty, total, cartID, itemCode]);

      await updateCartHeader(cartID);
    }
  }

  //for edit from Accessories history screen
  Future updateFromAccHistoryScreen(
      String cartID, String accCode, String qty, String zid) async {
    var dbClient = await conn.db;
    if (qty == '0') {
      await dbClient!.rawQuery('''
          DELETE FROM ${DBHelper.cartDetailsTable}
          WHERE xitem = ? AND cartID = ? AND zid = ?
          ''', [accCode, cartID, zid]);
    } else {

      dbClient!.rawQuery(
          "UPDATE ${DBHelper.cartDetailsTable} "
          "SET xqty = ?"
          " WHERE cartID = ? and xitem = ?",
          [qty, cartID, accCode]);

      //await updateCartHeader(cartID);
    }
  }

  Future updateCartHeader(String cartID) async {
    var dbClient = await conn.db;

    var subTotalResult = await dbClient!.rawQuery(
      "SELECT SUM(xlineamt) as subTotalSum FROM ${DBHelper.cartDetailsTable} WHERE cartID = ?",
      [cartID],
    );

    await dbClient.update(
      DBHelper.cartTable,
      {'total': subTotalResult[0]["subTotalSum"]},
      where: 'cartID = ?',
      whereArgs: [cartID],
    );
  }

  Future getIDWiseCartHeader(String cartId) async {
    var dbClient = await conn.db;
    List idWiseCartList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!
          .query(DBHelper.cartTable, where: 'cartId = ?', whereArgs: [cartId]);
      for (var idWiseCart in maps) {
        idWiseCartList.add(idWiseCart);
      }
    } catch (e) {
      print("There are some issues getting products  getIDWiseCartHeader : $e");
    }
    // print("All cart product from Header: $cartList");
    return idWiseCartList;
  }

  Future getIDWiseCartDetailsHeader(String cartId) async {
    var dbClient = await conn.db;
    List idWiseCartList = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.query(
          DBHelper.cartDetailsTable,
          where: 'cartId = ?',
          whereArgs: [cartId]);
      for (var idWiseCart in maps) {
        idWiseCartList.add(idWiseCart);
      }
    } catch (e) {
      print("There are some issues getting products getIDWiseCartDetailsHeader : $e");
    }
    // print("All cart product from Header: $cartList");
    return idWiseCartList;
  }

  ///Special Table caItemTable repo
  Future<int> addIntoCaCusPrice(CaCusPriceModel caCusPriceModel) async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      // Check if the xitem already exists in the local storage
      var existingCaCusPrice = await dbClient!.query(
        DBHelper.caCusPrice,
        where: 'xitem = ? AND xcus =?',
        whereArgs: [caCusPriceModel.xitem, caCusPriceModel.xcus],
      );

      if (existingCaCusPrice.isEmpty) {
        // xitem does not exist, proceed with insertion
        result = await dbClient.insert(
            DBHelper.caCusPrice, caCusPriceModel.toJson());
      } else {
        // xitem already exists, skip insertion
      }
    } catch (e) {
      print('There are some issues addIntoCaCusPrice : $e');
    }
    return result;
  }

  Future getCusWisePrice() async {
    var dbClient = await conn.db;
    List cwpList = [];
    try {
      List<Map<String, dynamic>> maps =
          await dbClient!.rawQuery("SELECT * FROM ${DBHelper.caCusPrice}");
      for (var cwpitems in maps) {
        cwpList.add(cwpitems);
      }
    } catch (e) {
      print("There are some issues getting products getCusWisePrice : $e");
    }
    // print("All cart product from Header: $cartList");
    return cwpList;
  }

  Future<void> deleteCaCusPriceTable() async {
    var dbClient = await conn.db;
    dbClient!.delete(DBHelper.caCusPrice);
  }

  Future cuswiseprice(String cus, String xitem) async {
    var dbClient = await conn.db;
    var price = dbClient!.rawQuery(
        "select xrate from ${DBHelper.caCusPrice} where xcus = ?  and xitem =?",
        [cus, xitem]);
    return price;
  }

  Future processGift(String zid, String cartId, double spDisc, String xcus,
      String xitem, String xdesc, String xUnit, int xqty) async {
    var dbClient = await conn.db;

    List<Map<String, dynamic>> mapsGift = await dbClient!.rawQuery(
        "SELECT * FROM ${DBHelper.giftItem} WHERE xitem = ? AND zid = ?",
        [xitem, zid]);
    List<Map<String, dynamic>> mapsCaCusDisc = await dbClient.rawQuery(
        "SELECT * FROM ${DBHelper.caCusDisc} WHERE xcus = ? AND xitem = ?",
        [xcus, xitem]);

    List<Map<String, dynamic>> giftItemList = [];
    for (var gpitems in mapsGift) {
      giftItemList.add(gpitems);
    }

    List<Map<String, dynamic>> caCusDisList = [];
    for (var cusDisList in mapsCaCusDisc) {
      caCusDisList.add(cusDisList);
    }

    if (caCusDisList.isNotEmpty) {
      double cusDisc = double.tryParse(caCusDisList[0]["xdisc"]) ?? 0;

      if (cusDisc > 0) {
        spDisc = cusDisc;
      }
    }

    for (int i = 0; i < giftItemList.length; i++) {
      var giftQuantity = double.parse(giftItemList[i]["xqty"]).toInt();
      int bonusQty = int.tryParse(giftItemList[i]["xqtybonus"]) ?? 0;
      int quantity = int.tryParse(giftItemList[i]["xqty"]) ?? 0;
      String giftItem = giftItemList[i]["xgiftitem"] ?? '';
      var giftItemName = await dbClient.rawQuery(
          "SELECT IFNULL(xdesc,'') as itemName FROM ${DBHelper.productTable} WHERE zid = ? AND xitem = ?",
          [zid, giftItem]);
      int gifItemQty = bonusQty * (xqty ~/ giftQuantity);
      if (xqty >= giftQuantity && spDisc == 0) {
        Map<String, dynamic> cartDetailsInsert = {
          'zid': zid,
          'cartID': cartId,
          'xitem': giftItem,
          'xdesc': giftItemName.first.values.first as String,
          'xunit': xUnit,
          'xrate': 0.0,
          'xdisc': 0.0,
          'xdiscamt': 0.0,
          'xdiscad': 0.0,
          'xdiscadamt': 0.0,
          'xlineamt': 0.0,
          'xqty': gifItemQty,
          'subTotal': 0.0,
          'giftStatus': 'Gift Item',
          'yes_no': 'No',
          'xmasteritem': '',
        };
        await DatabaseRepo().cartDetailsInsert(cartDetailsInsert);
      }
    }
  }

  //get cartDetails after inserting
  Future getCartIdWiseCartDetails(String cartId) async {
    var dbClient = await conn.db;
    List idWiseCartDetails = [];
    try {
      List<Map<String, dynamic>> maps = await dbClient!.query(
          DBHelper.cartDetailsTable,
          where: 'cartId = ? and yes_no = "No" and giftStatus != "Gift Item"',
          whereArgs: [cartId]);
      for (var idWiseCart in maps) {
        idWiseCartDetails.add(idWiseCart);
      }
    } catch (e) {
      print("There are some issues getting products getCartIdWiseCartDetails : $e");
    }
    // print("All cart product from Header: $cartList");
    return idWiseCartDetails;
  }

  Future processDiscount(
      String zid,
      String xcus,
      String adDiscount,
      String xitem,
      String cartId,
      String qty,
      String xrate,
      String xcolor,
      String xstype) async {
    var dbClient = await conn.db;
    //additional discount calculation
    double adDisc = double.parse(adDiscount);
    double prDisc = 0.0;
    double lineamt = 0.0;
    double xlineamt = 0.0;
    double discamt = 0.0;
    double discad = 0.0;
    double discdamt = 0.0;
    double caCusDisc = 0.0;
    List<Map<String, dynamic>> promoHeader = await dbClient!
        .rawQuery("SELECT * FROM ${DBHelper.promoHeader} WHERE zid = ?", [zid]);
    List<Map<String, dynamic>> promodetails = await dbClient.rawQuery(
        "SELECT * FROM ${DBHelper.promoDetails} WHERE zid = ?", [zid]);
    List<Map<String, dynamic>> caCusList = await dbClient.rawQuery(
        "SELECT * FROM ${DBHelper.caCusDisc} WHERE zid = ? AND xcus = ? AND xitem = ?",
        [zid, xcus, xitem]);
    try {
      discdamt = ((double.parse(xrate) * double.parse(qty)) * adDisc) / 100;
      xlineamt = (double.parse(xrate) * double.parse(qty)) - discdamt;
      var updateLineamountToDetails = await dbClient.update(
        DBHelper.cartDetailsTable,
        {
          'xlineamt': xlineamt,
          'xdiscadamt': discdamt,
        },
        where: 'zid = ? AND cartID = ? AND xitem = ?',
        whereArgs: [zid, cartId, xitem],
      );
      if (promoHeader.isNotEmpty) {
        if (adDisc > 0.0) {
          print('if statement is calling');
          //updated cart header table
          var headerUpdate = await dbClient.update(
            DBHelper.cartTable,
            {
              'xdisctype': "Additional",
            },
            where: 'zid = ? AND cartID = ?',
            whereArgs: [
              zid,
              cartId,
            ],
          );
          String itemColor = '';
          if (xcolor == '1005') {
            itemColor = 'Black';
          } else {
            itemColor = 'Colored';
          }
          if (promoHeader.isNotEmpty) {
            String trnNum = promoHeader[0]["xtrnnum"] ?? '0';
            String xref = promoHeader[0]["xref"] ?? '0';

            var totalLtr = 0.0;
            if (xref == 'Invoice') {
              if (itemColor == 'Black') {
                var queryResult = await dbClient.rawQuery(
                    "SELECT sum(c.xqty * p.xcapacity) FROM ${DBHelper.cartDetailsTable} c join ${DBHelper.productTable} p on c.xitem = p.xitem and c.zid = p.zid WHERE c.zid = ? AND c.cartID = ? AND c.yes_no = 'No' AND c.giftStatus != 'Gift Item' AND p.xstype = ? AND p.xcolor='1005' ",
                    [zid, cartId, xstype]);
                double sumValue = queryResult.first.values.first as double;
                if (queryResult.isNotEmpty) {
                  totalLtr = sumValue;
                }
              } else {
                var queryResult = await dbClient.rawQuery(
                    "SELECT sum(c.xqty * p.xcapacity) FROM ${DBHelper.cartDetailsTable} c join ${DBHelper.productTable} p on c.xitem = p.xitem and c.zid = p.zid WHERE c.zid = ? AND c.cartID = ? AND c.yes_no = 'No' AND c.giftStatus != 'Gift Item' AND p.xstype = ? AND p.xcolor != '1005' ",
                    [zid, cartId, xstype]);
                double sumValue = queryResult.first.values.first as double;
                if (queryResult.isNotEmpty) {
                  totalLtr = sumValue;
                }
              }

              var queryResult = await dbClient.rawQuery(
                  "SELECT COALESCE(a.xamount, 0) AS prdisc FROM ${DBHelper.promoDetails} a JOIN ${DBHelper.promoHeader} b ON a.zid=b.zid AND a.xtrnnum=b.xtrnnum WHERE a.zid=? AND b.xtrnnum=? AND ? BETWEEN a.xfslab AND a.xtslab AND b.xstype=? AND datetime(b.xfdate) <= datetime('now') AND datetime(b.xtdate) >= datetime('now') AND a.xcolor=?",
                  [zid, trnNum, totalLtr, xstype, itemColor]);
              if (queryResult.isNotEmpty) {
                prDisc = queryResult[0][0] as double;

                if (prDisc != 0.0) {
                  if (itemColor == 'Black') {
                    List<Map<String, dynamic>> result = await dbClient.rawQuery(
                      "SELECT a.id, a.xitem, COALESCE(a.xrate, 0) AS xrate, COALESCE(a.xqtyreq, 0) AS xqtyreq, COALESCE(a.xdiscadamt, 0) AS xdiscadamt, COALESCE(a.xdiscad, 0) AS xdiscad FROM ${DBHelper.cartDetailsTable} a JOIN ${DBHelper.productTable} b ON a.zid=b.zid AND a.xitem=b.xitem WHERE a.zid=? AND a.cartID=? AND b.xstype=? AND b.xcolor='1005' AND a.yes_no<>'Yes' AND COALESCE(a.giftStatus, '')!='Gift Item'",
                      [zid, cartId, xstype],
                    );

                    for (var row in result) {
                      int id = row['id'];
                      String xitem = row['xitem'];
                      double xrate = row['xrate'];
                      double xqtyreq = row['xqtyreq'];
                      double xdiscadamt = row['xdiscadamt'];
                      double xdiscad = row['xdiscad'];

                      // Process the fetched data as needed
                      xdiscad = xdiscad + prDisc;
                      if (xdiscad <= 100) {
                        discamt = ((xqtyreq * xrate) * prDisc) / 100;

                        lineamt = (xrate * xqtyreq);

                        xlineamt = lineamt - (discamt + xdiscadamt);

                        //update cart details table one by one
                        var detailsUpdate = await dbClient.update(
                          DBHelper.cartDetailsTable,
                          {
                            'xdisc': prDisc,
                            'xdiscamt': discamt,
                            'xlineamt': xlineamt,
                          },
                          where: 'zid = ? AND cartID = ? AND xitem = ?',
                          whereArgs: [zid, cartId, xitem],
                        );
                      }
                    }
                  }
                }
              }
            }
          }
        }
        //customer discount part
        if (promoHeader[0]["xtrnnum"] == '' || prDisc < 0.0) {
          if (caCusList.isNotEmpty) {
            caCusDisc = caCusList[0]["xdisc"] as double;
            discad = caCusDisc + discad;
            if (caCusDisc != 0.0 && discad <= 100) {
              discamt =
                  ((double.parse(qty) * double.parse(xrate)) * caCusDisc) / 100;

              lineamt = (double.parse(xrate) * double.parse(qty));

              xlineamt = lineamt - (discamt + discdamt);

              //update cart details table one by one
              var detailsUpdate = await dbClient.update(
                DBHelper.cartDetailsTable,
                {
                  'xdisc': caCusDisc,
                  'xdiscamt': discamt,
                  'xlineamt': xlineamt,
                },
                where: 'zid = ? AND cartID = ? AND xitem = ?',
                whereArgs: [zid, cartId, xitem],
              );
            }
          }
        }
      }
      // item wise discount
      else {
        if (caCusDisc == 0.0) {
          List<Map<String, dynamic>> itemWiseDisc = await dbClient.rawQuery(
              "SELECT xdisc FROM ${DBHelper.productTable} WHERE zid = ? AND xitem = ?",
              [zid, xitem]);
          double itemDiscount = double.parse(itemWiseDisc[0]['xdisc']);
          discad = itemDiscount + discad;
          if (itemDiscount != 0.0 && discad <= 100) {
            discamt =
                ((double.parse(qty) * double.parse(xrate)) * itemDiscount) /
                    100;

            lineamt = (double.parse(xrate) * double.parse(qty));

            xlineamt = lineamt - (discamt + discdamt);

            //update cart details table one by one
            var detailsUpdate = await dbClient.update(
              DBHelper.cartDetailsTable,
              {
                'xdisc': itemDiscount,
                'xdiscamt': discamt,
                'xlineamt': xlineamt,
              },
              where: 'zid = ? AND cartID = ? AND xitem = ?',
              whereArgs: [zid, cartId, xitem],
            );
          }
        }
      }
    } catch (e) {
      print('exception occured processDiscount : $e');
    }
  }

  //update cart header by save order press
  Future<void> updateStatusCartHeader(
      String cartId, String zId, String xopincapply) async {
    var dbClient = await conn.db;
    var updateHeader = await dbClient!.update(
      DBHelper.cartTable,
      {
        'xstatus': "Saved",
        'xopincapply': xopincapply,
      },
      where: 'zid = ? AND cartID = ? AND xstatus = "Open"',
      whereArgs: [
        zId,
        cartId,
      ],
    );
    print("updated status is : $updateHeader");
  }
}
