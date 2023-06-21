import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../constant/app_constants.dart';
import '../../databaseHelper/database_repo.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../../databaseHelper/login_repo.dart';
import '../model/deposit_number_list_model.dart';
import '../model/process_response_model.dart';
import '../model/so_model.dart';
import '../view/order_process/bill_screen.dart';
import 'login_controller.dart';

class CartController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  AppConstants appConstants = AppConstants();

  // Define the custom ID string
  RxString customId = ''.obs;
  List<List<String>> addedProducts = [];

  Future<void> generateSoNumber() async {
    var response = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/salesforce/getsonum.php?zid=${loginController.zID.value}'));
    if (response.statusCode == 200) {
      SoModel? data = soModelFromJson(response.body);
      print('So number : ${data!.sOnum}');

      // Define the regular expression for the custom ID format
      final RegExp idFormat = RegExp(r'^SO[0-9]{2}[0-9]{2}[0-9]{4,}$');

      // Define a function to generate the custom ID
      // Get the current date
      var now = DateTime.now();

      // Get the year and month as two digits each
      var year = now.year.toString().substring(2, 4);
      var month = now.month.toString().padLeft(2, '0');

      // Assemble the custom ID string
      customId.value = 'SO$year$month${data.sOnum}';
      print('Actual So number is : ${customId.value}');

      // Validate the custom ID using the regular expression
      if (!idFormat.hasMatch(customId.value)) {
        throw Exception(
            'Generated custom ID does not match the required format');
      }
    }
  }

  Future<void> addToCart(
      String productId,
      String pName,
      String pPrice,
      String xUnit,
      String xDisc,
      String xcolor,
      String xstype,
      String xcapacity,
      String dateEff,
      String dateExp) async {
    try {
      await DatabaseRepo()
          .cartAccessoriesInsert(productId, loginController.zID.value);
      if (addedProducts.isNotEmpty) {
        bool flag = false;
        for (int i = 0; i < addedProducts.length; i++) {
          if (addedProducts[i][0] == productId) {
            flag = true;
            int tempCount;
            tempCount = int.parse(addedProducts[i][1]);
            addedProducts[i][1] = (tempCount + 1).toString();
          }
        }
        if (!flag) {
          addedProducts.add([
            productId,
            '1',
            pName,
            pPrice,
            xUnit,
            xDisc,
            xcolor,
            xstype,
            xcapacity,
            dateEff,
            dateExp
          ]);
        }
      } else {
        addedProducts.add([
          productId,
          '1',
          pName,
          pPrice,
          xUnit,
          xDisc,
          xcolor,
          xstype,
          xcapacity,
          dateEff,
          dateExp
        ]);
      }
      print('The selected products are: $addedProducts');
      totalClicked();
      update();
    } catch (e) {
      print('There is an error $e');
    }
  }

  void increment(String productId) async {
    for (int i = 0; i < addedProducts.length; i++) {
      if (addedProducts[i][0] == productId) {
        int tempCount;
        tempCount = int.parse(addedProducts[i][1]);
        addedProducts[i][1] = (tempCount + 1).toString();
        //updateQuantity(addedProducts[i][0], int.parse(addedProducts[i][1]));
        await updateFromCartScreenAcc(
            productId, int.parse(addedProducts[i][1]));
      }
    }
    totalClicked();
    update();
  }

  void decrement(String productId) async {
    for (int i = 0; i < addedProducts.length; i++) {
      if (addedProducts[i][0] == productId) {
        if (addedProducts[i][1] == '1') {
          addedProducts.removeAt(i);
          await updateFromCartScreenAcc(productId, 0);
        } else {
          int tempCount;
          tempCount = int.parse(addedProducts[i][1]);
          addedProducts[i][1] = (tempCount - 1).toString();
          await updateFromCartScreenAcc(
              productId, int.parse(addedProducts[i][1]));
        }
      }
    }
    totalClicked();
    update();
  }

  //update for textfield
  void updateQuantity(String item, int quantity) async {
    for (var i = 0; i < addedProducts.length; i++) {
      if (addedProducts[i][0] == item) {
        addedProducts[i][1] = quantity.toString();
        update();
        await updateFromCartScreenAcc(item, int.parse(addedProducts[i][1]));
        break;
      }
    }
    totalClicked();
  }

  RxInt totalClick = 0.obs;
  final totalPrice = 0.0.obs;
  final totalPackQty = 0.0.obs;

  void totalClicked() {
    try {
      int totalQty = 0;
      double subTotalPrice = 0.0;
      double subTotalPackQty = 0.0;
      for (int i = 0; i < addedProducts.length; i++) {
        int temp = int.parse(addedProducts[i][1]);
        totalQty += temp;
        double tempPrice = double.parse(addedProducts[i][3]);
        subTotalPrice += tempPrice * temp;
        /*double tempQty = double.parse(addedProducts[i][5]);
        subTotalPackQty += tempQty * temp;*/
      }
      totalClick.value = totalQty;
      totalPrice.value = subTotalPrice;
      // totalPackQty.value = subTotalPackQty;
      //
      // print('total clicked is: $totalClick');
      // print('total price is: $totalPrice');
      // print('total pack is: $totalPackQty');
    } catch (e) {
      print('There is an error : $e');
    }
  }

  /// functions for accessories
  ///

  List<Map<String, dynamic>> cartAcc = [];
  RxBool isAccLoaded = false.obs;

  Future<void> getAccessoriesList(String productCode) async {
    try {
      isAccLoaded(true);
      cartAcc = await DatabaseRepo().getAccessories(productCode);
      isAccLoaded(false);
      print("found cartAccessories by masterItem: $cartAcc");
    } catch (error) {
      isAccLoaded(false);
      print('There are some issue getting cartAccessories List: $error');
    }
  }

  //get all cart accessories list from product accessories table
  List<Map<String, dynamic>> allAccList = [];
  RxBool isAllAccLoaded = false.obs;

  Future<void> getAllAccessoriesList() async {
    try {
      isAllAccLoaded(true);
      allAccList =
          await DatabaseRepo().getAllAccessoriesList(loginController.zID.value);
      foundAccList = allAccList;
      isAllAccLoaded(false);
      print(
          "found all accessories list from product accessories table: $allAccList");
    } catch (error) {
      isAllAccLoaded(false);
      print('There are some issue getting all Accessories List: $error');
    }
  }

  Future<void> deleteFromCartAccTable() async {
    print('Delete cart accessories table c cartTableAccInsert');
    await DatabaseRepo().deleteAccessory();
  }

  //search function for accessories
  RxBool isSearched = false.obs;
  List foundAccList = [];

  // RxBool enableDealerList = false.obs;
  void runFilterForAccessories(String keyword) async {
    try {
      isSearched(true);
      List result = [];
      if (keyword.isEmpty) {
        result = allAccList;
        isSearched(false);
      } else {
        result = allAccList
            .where((name) =>
                name['name'].toLowerCase().contains(keyword.toLowerCase()))
            .toList();
        isSearched(false);
        print('Actual list : $result');
      }
      foundAccList = result;
      isSearched(false);
    } catch (e) {
      isSearched(false);
      print('Error Occured: $e');
    }
  }

  //function for addional accessories insert
  Future<void> insertAdditionalAccessories(String xitem, String masteritem,
      String qty, GlobalKey<ScaffoldState> scaffoldKey) async {
    await DatabaseRepo().additionalAccessoriesInsert(
        xitem, loginController.zID.value, masteritem, '1');
    final currentContext = scaffoldKey
        .currentContext; // Replace 'scaffoldKey' with the key of your scaffold widget

    ScaffoldMessenger.of(currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          'Accessories added to table',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        duration: Duration(seconds: 1),
      ),
    );
    await getAccessoriesList(masteritem);
  }

  //cart accessories update method from cart accessories screen
  void updateCartAccessories(
      String accCode, String proCode, int plusMinus) async {
    if (plusMinus == 1) {
      await DatabaseRepo().updateAccessories(accCode, proCode, plusMinus);
      await getAccessoriesList(proCode);
    } else {
      await DatabaseRepo().updateAccessories(accCode, proCode, plusMinus);
      await getAccessoriesList(proCode);
    }
  }

// method for accessories update from cart screeen
  List<Map<String, dynamic>> cartScreenAcc = [];
  RxBool isCartAccLoaded = false.obs;

  Future<void> updateFromCartScreenAcc(String productCode, int qty) async {
    try {
      isCartAccLoaded(true);
      await DatabaseRepo().updateFromCartScreenAccessories(
          loginController.zID.value, productCode, qty);
      isCartAccLoaded(false);
      print("found cartAccessories by masterItem: $cartScreenAcc");
    } catch (error) {
      isCartAccLoaded(false);
      print('There are some issue getting cartAccessories List: $error');
    }
  }

  //getLatitude and longitude
  RxDouble curntLong = 0.0.obs;
  RxDouble curntLat = 0.0.obs;
  Position? position;

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    curntLat.value = position!.latitude;
    curntLong.value = position!.longitude;
    print('Actual position is : $position');
    print('Actual Current Latitude is : ${curntLat.value}');
    print('Actual Current Longitude is : ${curntLong.value}');
    return position!;
  }

  //for getting CartId and Insert it to the cart Table as well as Cart_details Table
  RxInt cartTableMax = 0.obs;
  RxBool saving = false.obs;

  void updateDiscount(int itemIndex, String discount) {
    addedProducts[itemIndex][5] = discount;
  }

  var cartID = '';

  Future<void> insertToCart(String cusId, String xOrg, String status) async {
    try {
      saving(true);
      cartTableMax.value = await DatabaseRepo().getCartID();
      cartID = 'C-00${(cartTableMax + 1)}';
      Map<String, dynamic> cartInsert = {
        'zid': loginController.zID.value,
        'cartID': cartID,
        'xtso': loginController.xtso.value,
        'xcus': cusId,
        'xorg': xOrg,
        'xterritory': loginController.xterritory.value,
        'xopincapply': incentive.value,
        'total': totalPrice.toDouble(),
        'xdisctype': '',
        'xfwh': 30, // need to check again
        'xdm': loginController.xDM.value,
        'xdivision': loginController.xDivision.value,
        'xzm': loginController.xZM.value,
        'xzone': loginController.xZone.value,
        'xpnature': loginController.xPNature.value, //need to check again
        'lattitude': ' ',
        'longitude': ' ',
        'xstatus': status
      };
      await DatabaseRepo().cartInsert(cartInsert);
      for (int i = 0; i < addedProducts.length; i++) {
        print('Inside from for details');
        String xItem = addedProducts[i][0];
        double qty = double.parse(addedProducts[i][1]);
        String xDesc = addedProducts[i][2];
        double itemPrice = double.parse(addedProducts[i][3]);
        double subTotal = qty * itemPrice;
        String xunit = addedProducts[i][4];
        double addDisc = double.parse(addedProducts[i][5]);
        String xcolor = addedProducts[i][6];
        String xstype = addedProducts[i][7];
        print('Additional Discount : $addDisc');
        Map<String, dynamic> cartDetailsInsert = {
          'zid': loginController.zID.value,
          'cartID': cartID,
          'xitem': xItem,
          'xdesc': xDesc,
          'xunit': xunit,
          'xcolor': xcolor,
          'xstype': xstype,
          'xrate': itemPrice.toString(),
          'xdisc': 0.0,
          'xdiscamt': 0.0,
          'xdiscad': addDisc,
          'xdiscadamt': 0.0,
          'xlineamt': 0.0,
          'xqty': qty.toString(),
          'subTotal': subTotal.toString(),
          'giftStatus': '',
          'yes_no': 'No',
          'xmasteritem': xItem,
        };
        print('Calling cartDetailsInsert');
        await DatabaseRepo().cartDetailsInsert(cartDetailsInsert);
        print('Calling cartTableAccInsert');
        await DatabaseRepo()
            .cartTableAccInsert(xItem, loginController.zID.value, cartID);
        /*
        //process Gift part follow ZAB
        print('Calling processGift');
        await DatabaseRepo().processGift(loginController.zID.value, cartID,
            double.parse(delDisc), cusId, xItem, xDesc, xunit, qty.toInt());

        //promotion discount part
        if (discount.text.isEmpty) {
          print('Calling processDiscount');
          await DatabaseRepo().processDiscount(
              loginController.zID.value,
              cusId,
              addDisc.toString(),
              xItem,
              cartID,
              qty.toString(),
              itemPrice.toString(),
              xcolor,
              xstype);
        } else {
          print('Calling processDiscount');
          await DatabaseRepo().processDiscount(
              loginController.zID.value,
              cusId,
              discount.text,
              xItem,
              cartID,
              qty.toString(),
              itemPrice.toString(),
              xcolor,
              xstype);
        }*/
      }
      print('Delete cart accessories table c cartTableAccInsert');
      await DatabaseRepo().deleteAccessory();
      saving(false);
/*      Get.snackbar('Successful', 'Order added successfully',
          backgroundColor: Colors.white, duration: const Duration(seconds: 2));*/
      /*Get.to(() => BillDetailsScreen(
            cartId: cartID,
            xOrg: xOrg,
            xCus: cusId,
          ));*/
    } catch (error) {
      saving(false);
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeader = [];
  RxBool isLoading = false.obs;

  Future getCartHeaderList() async {
    try {
      isLoading(true);
      listCartHeader = await DatabaseRepo().getCartHeader();
      isLoading(false);
    } catch (error) {
      print('There are some issue getting cart header list: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeaderDetails = [];
  RxBool isLoading1 = false.obs;

  Future<void> getCartHeaderDetailsList(String cartId) async {
    try {
      isLoading1(true);
      listCartHeaderDetails = await DatabaseRepo().getCartHeaderDetails(cartId);
      print(listCartHeaderDetails);
      isLoading1(false);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //for getting cart accessories List from cart details table
  List listCartAccessoriesDetails = [];
  RxBool isAccLoad = false.obs;

  Future<void> getCarHisAccList(String cartId, String productId) async {
    try {
      isAccLoad(true);
      listCartAccessoriesDetails =
          await DatabaseRepo().getCartHistoryAccessories(cartId, productId);
      print(listCartAccessoriesDetails);
      isAccLoad(false);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeaderForSync = [];
  RxBool isLoadingForSync = false.obs;

  Future getCartHeaderListForSync() async {
    try {
      isLoadingForSync(true);
      listCartHeaderForSync = await DatabaseRepo().getCartHeaderForSync();
      isLoadingForSync(false);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeaderDetailsForSync = [];
  RxBool isLoadingForDetails = false.obs;

  Future<void> getCartHeaderDetailsListForSync(String cartId) async {
    try {
      isLoadingForDetails(true);
      listCartHeaderDetailsForSync =
          await DatabaseRepo().getCartHeaderDetailsForSync(cartId);
      print(listCartHeaderDetailsForSync);
      isLoadingForDetails(false);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //for getting All cart details _List from cart table
  List allCartDetails = [];

  Future<void> allCartHeaderDetails(String cartId) async {
    try {
      allCartDetails = await DatabaseRepo().getAllCartDetailsList(cartId);
      print(allCartDetails);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //for place order button
  RxBool isPlaced = false.obs;

  Future<void> saveOrder(String cartId) async {
    isPlaced(true);
    DatabaseRepo().updateStatusCartHeader(
        cartId, loginController.zID.value, incentive.value);
    print("List of added products in the bill screen: $listOfAddedProducts");
    // await insertToCart(cusId, xOrg, status, delDisc);
    isPlaced(false);
    Get.back();
    Get.back();
    Get.back();
    Get.back();
    Get.snackbar('Successful', 'Order added successfully',
        backgroundColor: Colors.white, duration: const Duration(seconds: 2));
  }

  //for uploading cartHeader and details to-gather
  RxBool isUploading = false.obs;

  Future<void> uploadCartOrder() async {
    try {
      final StreamSubscription<InternetConnectionStatus> listener =
          InternetConnectionChecker()
              .onStatusChange
              .listen((InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            //code
            isUploading(true);
            await getCartHeaderList();
            if (listCartHeader.isEmpty) {
              Get.snackbar('Warning!', 'Your have no order to upload',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 1));
              isUploading(false);
            } else {
              for (int i = 0; i < listCartHeader.length; i++) {
                await generateSoNumber();
                var dataHeader = jsonEncode(<String, dynamic>{
                  "zauserid": loginController.xposition.value,
                  "zid": "${listCartHeader[i]['zid']}",
                  "xtornum": customId.value,
                  "xdate": "${listCartHeader[i]['createdAt']}",
                  "xcus": "${listCartHeader[i]['xcus']}",
                  "xpreparer": loginController.xstaff.value,
                  "xterritory": "${listCartHeader[i]['xterritory']}",
                  "xtso": "${listCartHeader[i]['xtso']}",
                  "xdm": "${listCartHeader[i]['xdm']}",
                  "xtotamt": '${listCartHeader[i]['total']}',
                  "xfwh": '${listCartHeader[i]['xfwh']}',
                  "xdivision": '${listCartHeader[i]['xdivision']}',
                  "xpnature": '${listCartHeader[i]['xpnature']}',
                  "xzm": '${listCartHeader[i]['xzm']}',
                  "xzone": '${listCartHeader[i]['xzone']}',
                  "xdisctype": '${listCartHeader[i]['xdisctype']}',
                  "xopincapply": "${listCartHeader[i]['xopincapply']}",
                });

                var responseHeader = await http.post(
                    Uri.parse(
                        'http://${AppConstants.baseurl}/gazi/salesforce/SOtableInsert.php'),
                    body: dataHeader);
                print('cart uploaded: $responseHeader');
                var tempHeader = '${listCartHeader[i]['cartID']}';
                await allCartHeaderDetails(tempHeader);
                print('details length: ${allCartDetails.length}');
                for (int j = 0; j < allCartDetails.length; j++) {
                  var dataDetails = jsonEncode(<String, dynamic>{
                    "zid": allCartDetails[j]['zid'],
                    "zauserid": loginController.xposition.value,
                    "xtornum": customId.value,
                    "xrow": "${j + 1}",
                    "xitem": allCartDetails[j]['xitem'],
                    "xunit": allCartDetails[j]['xunit'],
                    "qty": allCartDetails[j]['xqty'],
                    "amount": allCartDetails[j]['subTotal'],
                    "xpartno": allCartDetails[j]['yes_no'],
                    "xmasteritem": allCartDetails[j]['xmasteritem'],
                    "xrate": allCartDetails[j]['xrate '],
                    "xvatrate": '0.0',
                    "xdisc": allCartDetails[j]['xdisc '],
                    "xdiscamt": allCartDetails[j]['xdiscamt '],
                    "xdiscad": allCartDetails[j]['xdiscad '],
                    "xdiscadamt": allCartDetails[j]['xdiscadamt '],
                    "xnote1": allCartDetails[j]['giftStatus'],
                  });

                  var responseDetails = await http.post(
                      Uri.parse(
                          'http://${AppConstants.baseurl}/gazi/salesforce/SOdetailsTableInsert.php'),
                      body: dataDetails);
                  if (responseDetails.statusCode == 200) {
                    //update the table xstatus
                    await DatabaseRepo().updateCartHeaderTable(
                      tempHeader,
                      "${listCartHeader[i]['xopincapply']}",
                    );
                  }
                  print('Details Data: ${responseDetails.body}');
                }
                var updateSO = await http.get(Uri.parse(
                    'http://${AppConstants.baseurl}/gazi/salesforce/TRNincrement.php?zid=${loginController.zID.value}'));
                if (updateSO.statusCode == 200) {
                  print('Successfully updated');
                }
              }
              /*await DatabaseRepo().dropCartDetails();
              await DatabaseRepo().dropCartHeaderTable();*/
              await LoginRepo().deleteFromLoginTable();
              await LoginRepo().deleteLoginStatusTable();
              await getCartHeaderList();
              Get.snackbar('Successful', 'All orders uploaded successfully',
                  backgroundColor: Colors.white,
                  duration: const Duration(seconds: 1));
              isUploading(false);
            }
            break;
          case InternetConnectionStatus.disconnected:
            //code
            Get.snackbar(
                'Connection Error', 'You are disconnected from the internet',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 2));
            break;
        }
      });
      // close listener after 30 seconds, so the program doesn't run forever
      await Future<void>.delayed(const Duration(seconds: 10));
      await listener.cancel();
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //instant order
  RxBool isSync = false.obs;

  Future<void> placeOrder(
      String cusId, String xOrg, BuildContext context) async {
    try {
      final StreamSubscription<InternetConnectionStatus> listener =
          InternetConnectionChecker()
              .onStatusChange
              .listen((InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            //code
            isSync(true);
            //await getGeoLocationPosition();
            //await insertToCart(cusId, xOrg, 'Applied');
            await getCartHeaderListForSync();
            int i = (listCartHeaderForSync.length - 1);
            await generateSoNumber();
            var dataHeader = jsonEncode(<String, dynamic>{
              "zauserid": loginController.xposition.value,
              "zid": "${listCartHeaderForSync[i]['zid']}",
              "xtornum": customId.value,
              "xdate": "${listCartHeaderForSync[i]['createdAt']}",
              "xcus": "${listCartHeaderForSync[i]['xcus']}",
              "xpreparer": loginController.xstaff.value,
              "xterritory": "${listCartHeaderForSync[i]['xterritory']}",
              "xtso": "${listCartHeaderForSync[i]['xtso']}",
              "xdm": "${listCartHeaderForSync[i]['xdm']}",
              "xtotamt": '${listCartHeaderForSync[i]['total']}',
              "xfwh": '${listCartHeaderForSync[i]['xfwh']}',
              "xdivision": '${listCartHeaderForSync[i]['xdivision']}',
              "xpnature": '${listCartHeaderForSync[i]['xpnature']}',
              "xzm": '${listCartHeaderForSync[i]['xzm']}',
              "xzone": '${listCartHeaderForSync[i]['xzone']}',
              "xdisctype": '${listCartHeaderForSync[i]['xdisctype']}',
              "xopincapply": incentive.value,
            });

            var responseHeader = await http.post(
                Uri.parse(
                    'http://${AppConstants.baseurl}/gazi/salesforce/SOtableInsert.php'),
                body: dataHeader);
            var tempHeader = '${listCartHeaderForSync[i]['cartID']}';
            await getCartHeaderDetailsListForSync(tempHeader);
            for (int j = 0; j < listCartHeaderDetailsForSync.length; j++) {
              var dataDetails = jsonEncode(<String, dynamic>{
                "zid": listCartHeaderDetailsForSync[j]['zid'],
                "zauserid": loginController.xposition.value,
                "xtornum": customId.value,
                "xrow": "${j + 1}",
                "xitem": listCartHeaderDetailsForSync[j]['xitem'],
                "xunit": listCartHeaderDetailsForSync[j]['xunit'],
                "qty": listCartHeaderDetailsForSync[j]['xqty'],
                "amount": listCartHeaderDetailsForSync[j]['subTotal'],
                "xpartno": listCartHeaderDetailsForSync[j]['yes_no'],
                "xmasteritem": listCartHeaderDetailsForSync[j]['xmasteritem'],
                "xrate": listCartHeaderDetailsForSync[j]['xrate'],
                "xvatrate": '0.0',
                "xdisc": listCartHeaderDetailsForSync[j]['xdisc'],
                "xdiscamt": listCartHeaderDetailsForSync[j]['xdiscamt'],
                "xdiscad": listCartHeaderDetailsForSync[j]['xdiscad'],
                "xdiscadamt": listCartHeaderDetailsForSync[j]['xdiscadamt'],
                "xnote1": listCartHeaderDetailsForSync[j]['giftStatus'],
              });
              var responseDetails = await http.post(
                  Uri.parse(
                      'http://${AppConstants.baseurl}/gazi/salesforce/SOdetailsTableInsert.php'),
                  body: dataDetails);
              if (responseDetails.statusCode == 200) {
                await DatabaseRepo()
                    .updateCartHeaderTable(tempHeader, incentive.value);
              }
              print('so details = $responseDetails');
            }
            await getCartHeaderList();
            var updateSO = await http.get(Uri.parse(
                'http://${AppConstants.baseurl}/gazi/salesforce/TRNincrement.php?zid=${loginController.zID.value}'));
            if (updateSO.statusCode == 200) {
              print('Successfully updated----${updateSO.statusCode}');
              isSync(false);
              Get.back();
              Get.back();
              Get.back();
              Get.back();
              Get.snackbar('Successful', 'Order placed successfully',
                  backgroundColor: Colors.white,
                  duration: const Duration(seconds: 2));
            }
            break;
          case InternetConnectionStatus.disconnected:
            //code
            Get.snackbar(
                'Connection Error', 'You are disconnected from the internet',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 1));
            break;
        }
      });
      // close listener after 30 seconds, so the program doesn't run forever
      await Future<void>.delayed(const Duration(seconds: 10));
      await listener.cancel();
    } catch (e) {
      print('Error occured $e');
    }
  }

  //for single cart wise upload segments
  List idWiseCartHeader = [];

  Future getIdWiseCartHeaderList(String cartId) async {
    try {
      idWiseCartHeader = await DatabaseRepo().getIDWiseCartHeader(cartId);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List idWiseCartHeaderDetails = [];

  Future<void> getIdWiseCartDetailsList(String cartId) async {
    try {
      idWiseCartHeaderDetails =
          await DatabaseRepo().getIDWiseCartDetailsHeader(cartId);
      print(idWiseCartHeaderDetails);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  Future<void> updateCartHeaderStatus(String cartId, String xopincapply) async {
    try {
      idWiseCartHeaderDetails =
          await DatabaseRepo().updateCartHeaderTable(cartId, xopincapply);
      print(idWiseCartHeaderDetails);
    } catch (error) {
      print('There are some issue getting updateCart headerStatus: $error');
    }
  }

  RxBool isCartUploaded = false.obs;

  Future<void> singleCartUpload(String cartID) async {
    try {
      final StreamSubscription<InternetConnectionStatus> listener =
          InternetConnectionChecker()
              .onStatusChange
              .listen((InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            //code
            isLoading(true);
            await getIdWiseCartHeaderList(cartID);
            int i = (idWiseCartHeader.length);
            print('idWise cart Header: $i');
            await generateSoNumber();
            var dataHeader = jsonEncode(<String, dynamic>{
              "zauserid": loginController.xposition.value,
              "zid": "${idWiseCartHeader[0]['zid']}",
              "xtornum": customId.value,
              "xdate": "${idWiseCartHeader[0]['createdAt']}",
              "xcus": "${idWiseCartHeader[0]['xcus']}",
              "xpreparer": loginController.xstaff.value,
              "xterritory": "${idWiseCartHeader[0]['xterritory']}",
              "xtso": "${idWiseCartHeader[0]['xtso']}",
              "xdm": "${idWiseCartHeader[0]['xdm']}",
              "xtotamt": '${idWiseCartHeader[0]['total']}',
              "xfwh": '${idWiseCartHeader[0]['xfwh']}',
              "xdivision": '${idWiseCartHeader[0]['xdivision']}',
              "xpnature": '${idWiseCartHeader[0]['xpnature']}',
              "xzm": '${idWiseCartHeader[0]['xzm']}',
              "xzone": '${idWiseCartHeader[0]['xzone']}',
              "xdisctype": '${idWiseCartHeader[0]['xdisctype']}',
              "xopincapply": '${idWiseCartHeader[0]['xopincapply']}',
            });
            var responseHeader = await http.post(
                Uri.parse(
                    'http://${AppConstants.baseurl}/gazi/salesforce/SOtableInsert.php'),
                body: dataHeader);
            print('Cart header is uploaded: $responseHeader');
            await getIdWiseCartDetailsList(cartID);
            for (int j = 0; j < idWiseCartHeaderDetails.length; j++) {
              var dataDetails = jsonEncode(<String, dynamic>{
                "zid": idWiseCartHeaderDetails[j]['zid'],
                "zauserid": loginController.xposition.value,
                "xtornum": customId.value,
                "xrow": "${j + 1}",
                "xitem": idWiseCartHeaderDetails[j]['xitem'],
                "xunit": idWiseCartHeaderDetails[j]['xunit'],
                "qty": idWiseCartHeaderDetails[j]['xqty'],
                "amount": idWiseCartHeaderDetails[j]['subTotal'],
                "xpartno": idWiseCartHeaderDetails[j]['yes_no'],
                "xmasteritem": idWiseCartHeaderDetails[j]['xmasteritem'],
                'xrate': idWiseCartHeaderDetails[j]['xrate'],
                'xvatrate': '0.0',
                'xdisc': idWiseCartHeaderDetails[j]['xdisc'],
                'xdiscamt': idWiseCartHeaderDetails[j]['xdiscamt'],
                'xdiscad': idWiseCartHeaderDetails[j]['xdiscad'],
                'xdiscadamt': idWiseCartHeaderDetails[j]['xdiscadamt'],
                'xnote1': idWiseCartHeaderDetails[j]['giftStatus'],
              });
              var responseDetails = await http.post(
                  Uri.parse(
                      'http://${AppConstants.baseurl}/gazi/salesforce/SOdetailsTableInsert.php'),
                  body: dataDetails);
              print('so details = $responseDetails');
            }
            await updateCartHeaderStatus(
              cartID,
              '${idWiseCartHeader[0]['xopincapply']}',
            );
            await getCartHeaderList();
            var updateSO = await http.get(Uri.parse(
                'http://${AppConstants.baseurl}/gazi/salesforce/TRNincrement.php?zid=${loginController.zID.value}'));
            if (updateSO.statusCode == 200) {
              print('Successfully updated----${updateSO.statusCode}');
              Get.snackbar('Successful',
                  '${idWiseCartHeader[0]['xorg']} order upload successfully',
                  messageText: Text(
                    '${idWiseCartHeader[0]['xorg']} order upload successfully',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  maxWidth: double.infinity,
                  backgroundColor: Colors.white,
                  duration: const Duration(seconds: 1));
              isLoading(false);
            }
            break;
          case InternetConnectionStatus.disconnected:
            //code
            isLoading(false);
            Get.snackbar(
                'Connection Error', 'You are disconnected from the internet',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 1));
            break;
        }
      });
      // close listener after 30 seconds, so the program doesn't run forever
      await Future<void>.delayed(const Duration(seconds: 2));
      await listener.cancel();
    } catch (e) {
      print('Error occured $e');
    }
  }

  //for order history operation
  Future<void> deleteFromItemWiseCart(String cartID) async {
    await DatabaseRepo().deleteItemWiseCartHeader(cartID);
    await getCartHeaderList();
  }

  //update cartdetails
  TextEditingController quantity = TextEditingController();

  Future<void> updateItemWiseCartDetails(
      String cartID,
      String itemCode,
      String qty,
      String price,
      String zId,
      String cusId,
      String addDisc,
      String xColor,
      String xsType) async {
    try {
      print('updating quantity : $qty');
      await DatabaseRepo().updateCartDetailsTable(cartID, itemCode, qty, price);
      await DatabaseRepo()
          .updateCartHistoryAccessories(zId, itemCode, int.parse(qty), cartID);
      await DatabaseRepo().processDiscount(
          zId, cusId, addDisc, itemCode, cartID, qty, price, xColor, xsType);
      await getCartHeaderDetailsList(cartID);
      await getCartHeaderList();
      quantity.clear();
    } catch (e) {
      print('Failed to execute the process: $e');
    }
  }

  //update cart hist acc screen
  TextEditingController accQty = TextEditingController();

  Future<void> updateFromAccHisScreen(String accCode, String cartID, String qty,
      String zId, String productId) async {
    try {
      print("Quantity inside updateFromAccHisScreen: $qty");
      await DatabaseRepo()
          .updateFromAccHistoryScreen(cartID, accCode, qty, zId);
      await getCarHisAccList(cartID, productId);
      accQty.clear();
    } catch (e) {
      print('Failed to execute the process: $e');
    }
  }

  ///discount portion
  TextEditingController discount = TextEditingController();
  RxBool isValueLoaded = false.obs;

  // Incentive count
  //List listOfAddedProducts = [];
  List<ProcessResponseModel> listOfAddedProducts = [];
  double totalAmount = 0.0;
  double totalDiscount = 0.0;

//normally database theke anar jonno
  /*listOfAddedProducts =
          await DatabaseRepo().getCartIdWiseCartDetails(cartId);
      print(listOfAddedProducts);
      // totalAmount = listOfAddedProducts.fold(0, (sum, product) => sum + product['subTotal']);
      totalAmount = listOfAddedProducts.fold(
          0, (sum, product) => sum + product['xlineamt']);
      print("Total price is :$totalAmount");
      totalDiscount = listOfAddedProducts.fold(
          0.0, (sum, product) => sum + (product['xdisc'] as double));
      print("Total price is :$totalDiscount");*/
  Future getAddedProducts(String zId, String soNum) async {
    try {
      print('soNum: $soNum');
      print('selected zid : $zId');
      isValueLoaded(true);
      var responseProcess = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/SODetailValues.php?zid=$zId&xsonum=$soNum'));
      if (responseProcess.statusCode == 200) {
        var responseData = processResponseModelFromJson(responseProcess.body);
        listOfAddedProducts
            .assignAll(List<ProcessResponseModel>.from(responseData));
        // Handle the data as per your requirement
        print('Response data: $listOfAddedProducts');
        // totalAmount = listOfAddedProducts.fold(0, (sum, product) => sum + product['subTotal']);
        totalAmount = listOfAddedProducts.fold(
            0, (sum, product) => sum + double.parse(product.xlineamt));
        print("Total price is :$totalAmount");
        totalDiscount = listOfAddedProducts.fold(
            0.0, (sum, product) => sum + (product.xdisc as double));
        print("Total price is :$totalDiscount");
      } else {
        print(
            'Error happens fetching dp numbers: ${responseProcess.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isValueLoaded(false);
    }
  }

  /// new process work
  RxBool isChecked = true.obs;
  RxString incentive = 'Yes'.obs;
  RxString selectedAmount = '0.0'.obs;
  RxBool isProcessing = false.obs;
  RxString selectedNumber = 'Select deposit number'.obs;
  final RxList<DepositListModel> dropdownItems = <DepositListModel>[].obs;

  Future<void> fetchDropdownItems(String xcus) async {
    try {
      print('customer ID: $xcus');
      print('selected zid : ${loginController.zID.value}');
      isProcessing(true);
      var responseDeposit = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/depositSelection.php?zid=${loginController.zID.value}&xcus=$xcus'));
      if (responseDeposit.statusCode == 200) {
        if (responseDeposit.body.isNotEmpty) {
          var dpNum = depositListModelFromJson(responseDeposit.body);
          dropdownItems.assignAll(dpNum.map((e) => e));
          print('Dp numbers are: $dropdownItems');
        } else {
          print('Response body is empty');
        }
      } else {
        print(
            'Error happens fetching dp numbers: ${responseDeposit.statusCode}');
      }
    } catch (e) {
      print('Please check again: $e');
    } finally {
      isProcessing(false);
    }
  }

  Future<void> processOrder(
      String cusId, String xOrg, BuildContext context) async {
    try {
      final StreamSubscription<InternetConnectionStatus> listener =
          InternetConnectionChecker()
              .onStatusChange
              .listen((InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            //code
            isProcessing(true);
            await insertToCart(cusId, xOrg, 'Open');
            await generateSoNumber();
            await getCartHeaderListForSync();
            int i = (listCartHeaderForSync.length - 1);
            var dataHeader = jsonEncode(<String, dynamic>{
              "zauserid": loginController.xposition.value,
              "zid": "${listCartHeaderForSync[i]['zid']}",
              "xtornum": customId.value,
              "xdate": "${listCartHeaderForSync[i]['createdAt']}",
              "xcus": "${listCartHeaderForSync[i]['xcus']}",
              "xpreparer": loginController.xstaff.value,
              "xterritory": "${listCartHeaderForSync[i]['xterritory']}",
              "xtso": "${listCartHeaderForSync[i]['xtso']}",
              "xdm": "${listCartHeaderForSync[i]['xdm']}",
              "xtotamt": '${listCartHeaderForSync[i]['total']}',
              "xfwh": '${listCartHeaderForSync[i]['xfwh']}',
              "xdivision": '${listCartHeaderForSync[i]['xdivision']}',
              "xpnature": '${listCartHeaderForSync[i]['xpnature']}',
              "xzm": '${listCartHeaderForSync[i]['xzm']}',
              "xzone": '${listCartHeaderForSync[i]['xzone']}',
              "xdisctype": '${listCartHeaderForSync[i]['xdisctype']}',
              "xopincapply": incentive.value,
              "xdepositnum": selectedNumber.value,
            });

            var responseHeader = await http.post(
                Uri.parse(
                    'http://${AppConstants.baseurl}/gazi/salesforce/SOtableInsert.php'),
                body: dataHeader);
            print('response header : ${responseHeader.body}');
            var tempHeader = '${listCartHeaderForSync[i]['cartID']}';
            await getCartHeaderDetailsListForSync(tempHeader);
            for (int j = 0; j < listCartHeaderDetailsForSync.length; j++) {
              var dataDetails = jsonEncode(<String, dynamic>{
                "zid": listCartHeaderDetailsForSync[j]['zid'],
                "zauserid": loginController.xposition.value,
                "xtornum": customId.value,
                "xrow": "${j + 1}",
                "xitem": listCartHeaderDetailsForSync[j]['xitem'],
                "xunit": listCartHeaderDetailsForSync[j]['xunit'],
                "qty": listCartHeaderDetailsForSync[j]['xqty'],
                "amount": listCartHeaderDetailsForSync[j]['subTotal'],
                "xpartno": listCartHeaderDetailsForSync[j]['yes_no'],
                "xmasteritem": listCartHeaderDetailsForSync[j]['xmasteritem'],
                "xrate": listCartHeaderDetailsForSync[j]['xrate'],
                "xvatrate": '0.0',
                "xdisc": listCartHeaderDetailsForSync[j]['xdisc'],
                "xdiscamt": listCartHeaderDetailsForSync[j]['xdiscamt'],
                "xdiscad": listCartHeaderDetailsForSync[j]['xdiscad'],
                "xdiscadamt": listCartHeaderDetailsForSync[j]['xdiscadamt'],
                "xnote1": listCartHeaderDetailsForSync[j]['giftStatus'],
              });
              var responseDetails = await http.post(
                  Uri.parse(
                      'http://${AppConstants.baseurl}/gazi/salesforce/SOdetailsTableInsert.php'),
                  body: dataDetails);
              if (responseDetails.statusCode == 200) {
                await DatabaseRepo()
                    .updateCartHeaderTable(tempHeader, incentive.value);
              }
              print('so details = $responseDetails');
            }
            await getCartHeaderList();
            var updateSO = await http.get(Uri.parse(
                'http://${AppConstants.baseurl}/gazi/salesforce/TRNincrement.php?zid=${loginController.zID.value}'));
            if (updateSO.statusCode == 200) {
              print('Successfully updated----${updateSO.statusCode}');
              isProcessing(false);
              Get.to(() => BillDetailsScreen(
                    soNum: customId.value,
                    tsoId: loginController.xtso.value,
                    zID: loginController.zID.value,
                    cartId: tempHeader,
                    xOrg: xOrg,
                    xCus: cusId,
                  ));
              Get.snackbar('Successful', 'Order placed successfully',
                  backgroundColor: Colors.white,
                  duration: const Duration(seconds: 1));
            }
            /*isProcessing(false);
            Get.to(() => BillDetailsScreen(
                  cartId: cartID,
                  xOrg: xOrg,
                  xCus: cusId,
                ));
            Get.snackbar('Successful', 'Order placed successfully',
                backgroundColor: Colors.white,
                duration: const Duration(seconds: 2));*/
            break;
          case InternetConnectionStatus.disconnected:
            //code
            Get.snackbar(
                'Connection Error', 'You are disconnected from the internet',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 1));
            break;
        }
      });
      // close listener after 30 seconds, so the program doesn't run forever
      await Future<void>.delayed(const Duration(seconds: 2));
      await listener.cancel();
    } catch (e) {
      print('Error occured $e');
    }
  }

  RxBool isConfirmed = false.obs;

  Future<void> confirmOrder(String zid, String soNum, String tsoId) async {
    try {
      isConfirmed(true);
      var responseConfirm = await http.post(
          Uri.parse(
              'http://${AppConstants.baseurl}/gazi/salesforce/soConfirm.php'),
          body: jsonEncode(<String, String>{
            "zid": zid,
            "xsonum": soNum,
            "xtso": tsoId,
          }));
      if (responseConfirm.statusCode == 200) {
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar('Successful', 'Order confirmed',
            backgroundColor: Colors.white,
            duration: const Duration(seconds: 2));
      } else {
        print('Response body is empty');
      }
    } catch (e) {
      print('Please check again: $e');
    } finally {
      isConfirmed(false);
    }
  }
}
