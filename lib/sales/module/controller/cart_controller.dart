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
import '../model/so_model.dart';
import 'login_controller.dart';

class CartController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  AppConstants appConstants = AppConstants();

  RxString dropDownValue = 'Any time'.obs;
  // Define the custom ID string
  RxString customId = ''.obs;
  List<List<String>> addedProducts = [];

  Future<void> generateSoNumber() async{
    var response = await http.get(Uri.parse('http://${AppConstants.baseurl}/salesforce/getsonum.php'));
    if(response.statusCode == 200) {
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


  void addToCart(String productId, String pName, String packQty, String pPrice, String xUnit) {
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
        addedProducts.add([productId, '1', pName, pPrice, xUnit, packQty]);
      }
    } else {
      addedProducts.add([productId, '1', pName, pPrice, xUnit, packQty]);
    }
    print('The selected products are: $addedProducts');
    totalClicked();
    update();
  }

  void increment(String productId) {
    for (int i = 0; i < addedProducts.length; i++) {
      if (addedProducts[i][0] == productId) {
        int tempCount;
        tempCount = int.parse(addedProducts[i][1]);
        addedProducts[i][1] = (tempCount + 1).toString();
        updateQuantity(addedProducts[i][0], int.parse(addedProducts[i][1]));
      }
    }
    totalClicked();
    update();
  }

  void decrement(String productId) {
    for (int i = 0; i < addedProducts.length; i++) {
      if (addedProducts[i][0] == productId) {
        if (addedProducts[i][1] == '1') {
          addedProducts.removeAt(i);
        } else {
          int tempCount;
          tempCount = int.parse(addedProducts[i][1]);
          addedProducts[i][1] = (tempCount - 1).toString();
        }
      }
    }
    totalClicked();
    update();
  }

  //update for textfield
  void updateQuantity(String item, int quantity) {
    for (var i = 0; i < addedProducts.length; i++) {
      if (addedProducts[i][0] == item) {
        addedProducts[i][1] = quantity.toString();
        update();
        break;
      }
    }
    totalClicked();
  }

  RxInt totalClick = 0.obs;
  final totalPrice = 0.0.obs;
  final totalPackQty = 0.0.obs;
  void totalClicked() {
    try{
      int totalQty = 0;
      double subTotalPrice = 0.0;
      double subTotalPackQty = 0.0;
      for (int i = 0; i < addedProducts.length; i++) {
        int temp = int.parse(addedProducts[i][1]);
        totalQty += temp;
        double tempPrice = double.parse(addedProducts[i][3]);
        subTotalPrice += tempPrice * temp;
        double tempQty = double.parse(addedProducts[i][5]);
        print('===============${double.parse(addedProducts[i][5])}------------- ');
        subTotalPackQty += tempQty * temp;
      }
      totalClick.value = totalQty;
      totalPrice.value = subTotalPrice;
      totalPackQty.value = subTotalPackQty;

      print('total clicked is: $totalClick');
      print('total price is: $totalPrice');
      print('total pack is: $totalPackQty');
    }catch(e){
      print('There is an error : $e');
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
  Future<void> insertToCart(String tsoId, String Xsp, String cusId, String xOrg, String xterritory, String xareaop, String xdivision, String xsubcat, String status) async {
    try{
      saving(true);
      cartTableMax.value = await DatabaseRepo().getCartID();
      var cartID = 'C-00${(cartTableMax + 1)}';
      Map<String, dynamic> cartInsert = {
        'zid': loginController.zID.value,
        'xwh': loginController.xwh.value,
        'cartID': cartID,
        'xso': tsoId,
        'xsp': Xsp,
        'xcus': cusId,
        'xorg': xOrg,
        'xterritory': xterritory,
        'xareaop': xareaop,
        'xdivision': xdivision,
        'xsubcat': xsubcat,
        'xdelivershift': dropDownValue.value,
        'total': totalPrice.toDouble(),
        'totalPackQty': totalPackQty.toDouble(),
        'lattitude': '$curntLat',
        'longitude' : '$curntLong',
        'xstatus': status
      };
      DatabaseRepo().cartInsert(cartInsert);
      for (int i = 0; i < addedProducts.length; i++) {
        String xItem = addedProducts[i][0];
        double qty = double.parse(addedProducts[i][1]);
        String xDesc = addedProducts[i][2];
        double itemPrice = double.parse(addedProducts[i][3]);
        double subTotal = qty * itemPrice;
        String xunit = addedProducts[i][4];
        double itemPackQty = double.parse(addedProducts[i][5]);
        double subPackQty = qty * itemPackQty;
        Map<String, dynamic> cartDetailsInsert = {
          'zid': loginController.zID.value,
          'cartID': cartID,
          'xitem': xItem,
          'xdesc': xDesc,
          'xunit': xunit,
          'xrate': itemPrice,
          'xqty': qty,
          'subTotal': subTotal,
          'subPackQty': subPackQty,
        };
        DatabaseRepo().cartDetailsInsert(cartDetailsInsert);
      }
      saving(false);
      Get.back();
      Get.back();
      Get.snackbar(
          'Successful',
          'Order added successfully',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2)
      );
    }catch(error){
      saving(false);
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeader = [];
  RxBool isLoading = false.obs;
  Future getCartHeaderList() async{
    try{
      isLoading(true);
      listCartHeader = await DatabaseRepo().getCartHeader();
      isLoading(false);
    }catch(error){
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeaderDetails = [];
  RxBool isLoading1 = false.obs;
  Future<void> getCartHeaderDetailsList(String cartId) async{
    try{
      isLoading1(true);
      listCartHeaderDetails = await DatabaseRepo().getCartHeaderDetails(cartId);
      print(listCartHeaderDetails);
      isLoading1(false);
    }catch(error){
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeaderForSync = [];
  RxBool isLoadingForSync = false.obs;
  Future getCartHeaderListForSync() async{
    try{
      isLoadingForSync(true);
      listCartHeaderForSync = await DatabaseRepo().getCartHeaderForSync();
      isLoadingForSync(false);
    }catch(error){
      print('There are some issue: $error');
    }
  }

  //for getting cart_List from cart table
  List listCartHeaderDetailsForSync = [];
  RxBool isLoadingForDetails = false.obs;
  Future<void> getCartHeaderDetailsListForSync(String cartId) async{
    try{
      isLoadingForDetails(true);
      listCartHeaderDetailsForSync = await DatabaseRepo().getCartHeaderDetailsForSync(cartId);
      print(listCartHeaderDetailsForSync);
      isLoadingForDetails(false);
    }catch(error){
      print('There are some issue: $error');
    }
  }


  //for place order button
  RxBool isPlaced= false.obs;
  Future<void> placeOrder(String tsoId, String Xsp, String cusId, String xOrg, String xterritory, String xareaop, String xdivision, String xsubcat, String status) async{
    isPlaced(true);
    await getGeoLocationPosition();
    await insertToCart(tsoId, Xsp,cusId, xOrg, xterritory, xareaop, xdivision, xsubcat, status);
    isPlaced(false);
  }

  //for uploading cartHeader and details to-gather
  RxBool isUploading = false.obs;
  Future<void> uploadCartOrder() async{
    try{
      final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
              (InternetConnectionStatus status) async {
            switch (status) {
              case InternetConnectionStatus.connected:
              //code
                isUploading(true);
                await getCartHeaderList();
                if(listCartHeader.isEmpty){
                  Get.snackbar(
                      'Warning!',
                      'Your cart history is empty',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 1)
                  );
                  isUploading(false);
                }else{
                  for(int i = 0; i< listCartHeader.length; i++){
                    await generateSoNumber();
                    var dataHeader = jsonEncode(<String, dynamic>{
                      "zauserid" : loginController.xposition.value,
                      "zid" : "${listCartHeader[i]['zid']}",
                      "xtornum" : customId.value,
                      "xdate" : "${listCartHeader[i]['createdAt']}",
                      "xstatustor" : "Applied",
                      "xcus" : "${listCartHeader[i]['xcus']}",
                      "xidsup" : loginController.xsid.value,
                      "xpreparer" : loginController.xstaff.value,
                      "xterritory" : "${listCartHeader[i]['xterritory']}",
                      "xtso" : "${listCartHeader[i]['xso']}",
                      "xsp" : "${listCartHeader[i]['xsp']}",
                      "xtotamt" : '${listCartHeader[i]['total']}',
                      "xfwh" : '${listCartHeader[i]['xwh']}',
                    });
                    var responseHeader = await http.post(
                        Uri.parse('http://${AppConstants.baseurl}/salesforce/SOtableInsert.php'),
                        body: dataHeader);
                    var tempHeader = '${listCartHeader[i]['cartID']}';
                    await getCartHeaderDetailsList(tempHeader);
                    for(int j = 0; j< listCartHeaderDetails.length; j++){
                      var dataDetails = jsonEncode(<String, dynamic>{
                        "zid" : listCartHeaderDetails[j]['zid'],
                        "zauserid" : loginController.xposition.value,
                        "xtornum" : customId.value,
                        "xrow" : "${j+1}",
                        "xitem" : listCartHeaderDetails[j]['xitem'],
                        "xunit" : listCartHeaderDetails[j]['xunit'],
                        "qty" : listCartHeaderDetails[j]['xqty'],
                        "amount" : listCartHeaderDetails[j]['subTotal'],
                      });
                      var responseDetails = await http.post(
                          Uri.parse('http://${AppConstants.baseurl}/salesforce/SOdetailsTableInsert.php'),
                          body: dataDetails);
                      print('Details Data: ${responseDetails.body}');
                    }
                    var updateSO = await http.get(
                        Uri.parse('http://${AppConstants.baseurl}/salesforce/TRNincrement.php?zid=${loginController.zID.value}'));
                    if(updateSO.statusCode == 200){
                      print('Successfully updated');
                    }
                  }
                  await DatabaseRepo().dropCartDetails();
                  await DatabaseRepo().dropCartHeaderTable();
                  await LoginRepo().deleteFromLoginTable();
                  await LoginRepo().deleteLoginStatusTable();
                  await getCartHeaderList();
                  Get.snackbar(
                      'Successful',
                      'File uploaded successfully',
                      backgroundColor: Colors.white,
                      duration: const Duration(seconds: 1)
                  );
                  isUploading(false);
                }
                break;
              case InternetConnectionStatus.disconnected:
              //code
                Get.snackbar(
                    'Connection Error',
                    'You are disconnected from the internet',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2)
                );
                break;
            }
          }
      );
      // close listener after 30 seconds, so the program doesn't run forever
      await Future<void>.delayed(const Duration(seconds: 10));
      await listener.cancel();
    }catch(error){
      print('There are some issue: $error');
    }
  }

  //instant order
  RxBool isSync = false.obs;
  Future<void> syncNow(String tsoId,String Xsp, String cusId, String xOrg, String xterritory, String xareaop, String xdivision, String xsubcat, BuildContext context) async{
    try{
      final StreamSubscription<InternetConnectionStatus> listener =
          InternetConnectionChecker().onStatusChange.listen(
              (InternetConnectionStatus status) async {
            switch (status) {
              case InternetConnectionStatus.connected:
                //code
                isSync(true);
                await getGeoLocationPosition();
                await insertToCart(tsoId,Xsp, cusId, xOrg, xterritory, xareaop, xdivision, xsubcat,'Applied');
                await getCartHeaderListForSync();
                int i = (listCartHeaderForSync.length - 1);
                await generateSoNumber();
                var dataHeader = jsonEncode(<String, dynamic>{
                  "zauserid" : loginController.xposition.value,
                  "zid" : "${listCartHeaderForSync[i]['zid']}",
                  "xtornum" : customId.value,
                  "xdate" : "${listCartHeaderForSync[i]['createdAt']}",
                  "xstatustor" : "Applied",
                  "xcus" : "${listCartHeaderForSync[i]['xcus']}",
                  "xidsup" : loginController.xsid.value,
                  "xpreparer" : loginController.xstaff.value,
                  "xterritory" : "${listCartHeaderForSync[i]['xterritory']}",
                  "xtso" : "${listCartHeaderForSync[i]['xso']}",
                  "xsp" : "${listCartHeaderForSync[i]['xsp']}",
                  "xtotamt" : listCartHeaderForSync[i]['total'],
                  "xfwh" : '${listCartHeaderForSync[i]['xwh']}',
                });
                var responseHeader = await http.post(
                    Uri.parse('http://${AppConstants.baseurl}/salesforce/SOtableInsert.php'),
                    body: dataHeader);
                var tempHeader = '${listCartHeaderForSync[i]['cartID']}';
                await getCartHeaderDetailsListForSync(tempHeader);
                for(int j = 0; j< listCartHeaderDetailsForSync.length; j++){
                  var dataDetails = jsonEncode(<String, dynamic>{
                    "zid" : listCartHeaderDetailsForSync[j]['zid'],
                    "zauserid" : loginController.xposition.value,
                    "xtornum" : customId.value,
                    "xrow" : "${j+1}",
                    "xitem" : listCartHeaderDetailsForSync[j]['xitem'],
                    "xunit" : listCartHeaderDetailsForSync[j]['xunit'],
                    "qty" : listCartHeaderDetailsForSync[j]['xqty'],
                    "amount" : listCartHeaderDetailsForSync[j]['subTotal'],
                  });
                  var responseDetails = await http.post(
                      Uri.parse('http://${AppConstants.baseurl}/salesforce/SOdetailsTableInsert.php'),
                      body: dataDetails);
                  print('so details = $responseDetails');
                }
                await getCartHeaderList();
                var updateSO = await http.get(
                    Uri.parse('http://${AppConstants.baseurl}/salesforce/TRNincrement.php?zid=${loginController.zID.value}'));
                if(updateSO.statusCode == 200){
                  print('Successfully updated----${updateSO.statusCode}');
                  isSync(false);
                }
                break;
              case InternetConnectionStatus.disconnected:
                //code
                Get.snackbar(
                    'Connection Error',
                    'You are disconnected from the internet',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 1)
                );
                break;
            }
          }
      );
      // close listener after 30 seconds, so the program doesn't run forever
      await Future<void>.delayed(const Duration(seconds: 10));
      await listener.cancel();
    }catch(e){
      print('Error occured $e');
    }
  }



  //for single cart wise upload segments
  List idWiseCartHeader = [];
  Future getIdWiseCartHeaderList(String cartId) async{
    try{
      idWiseCartHeader = await DatabaseRepo().getIDWiseCartHeader(cartId);
    }catch(error){
      print('There are some issue: $error');
    }
  }
  //for getting cart_List from cart table
  List idWiseCartHeaderDetails = [];
  Future<void> getIdWiseCartDetailsList(String cartId) async{
    try{
      idWiseCartHeaderDetails = await DatabaseRepo().getIDWiseCartDetailsHeader(cartId);
      print(idWiseCartHeaderDetails);
    }catch(error){
      print('There are some issue: $error');
    }
  }

  Future<void> updateCartHeaderStatus(String cartId) async{
    try{
      idWiseCartHeaderDetails = await DatabaseRepo().updateCartHeaderTable(cartId);
      print(idWiseCartHeaderDetails);
    }catch(error){
      print('There are some issue: $error');
    }
  }

  RxBool isCartUploaded = false.obs;
  Future<void> singleCartUpload(String cartID) async{
    try{
      final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
              (InternetConnectionStatus status) async {
            switch (status) {
              case InternetConnectionStatus.connected:
              //code
                isLoading(true);
                await getIdWiseCartHeaderList(cartID);
                int i = (idWiseCartHeader.length);
                await generateSoNumber();
                var dataHeader = jsonEncode(<String, dynamic>{
                  "zauserid" : loginController.xposition.value,
                  "zid" : "${idWiseCartHeader[0]['zid']}",
                  "xtornum" : customId.value,
                  "xdate" : "${idWiseCartHeader[0]['createdAt']}",
                  "xstatustor" : "Applied",
                  "xcus" : "${idWiseCartHeader[0]['xcus']}",
                  "xidsup" : loginController.xsid.value,
                  "xpreparer" : loginController.xstaff.value,
                  "xterritory" : "${idWiseCartHeader[0]['xterritory']}",
                  "xtso" : "${idWiseCartHeader[0]['xso']}",
                  "xsp" : "${idWiseCartHeader[0]['xsp']}",
                  "xtotamt" : idWiseCartHeader[0]['total'],
                  "xfwh" : '${idWiseCartHeader[0]['xwh']}',
                });
                var responseHeader = await http.post(
                    Uri.parse('http://${AppConstants.baseurl}/salesforce/SOtableInsert.php'),
                    body: dataHeader);
                print('Cart header is uploaded: $responseHeader');
                await getIdWiseCartDetailsList(cartID);
                for(int j = 0; j< idWiseCartHeaderDetails.length; j++){
                  var dataDetails = jsonEncode(<String, dynamic>{
                    "zid" : idWiseCartHeaderDetails[0]['zid'],
                    "zauserid" : loginController.xposition.value,
                    "xtornum" : customId.value,
                    "xrow" : "${j+1}",
                    "xitem" : idWiseCartHeaderDetails[0]['xitem'],
                    "xunit" : idWiseCartHeaderDetails[0]['xunit'],
                    "qty" : idWiseCartHeaderDetails[0]['xqty'],
                    "amount" : idWiseCartHeaderDetails[0]['subTotal'],
                  });
                  var responseDetails = await http.post(
                      Uri.parse('http://${AppConstants.baseurl}/salesforce/SOdetailsTableInsert.php'),
                      body: dataDetails);
                  print('so details = $responseDetails');
                }
                await updateCartHeaderStatus(cartID);
                await getCartHeaderList();
                var updateSO = await http.get(
                    Uri.parse('http://${AppConstants.baseurl}/salesforce/TRNincrement.php?zid=${loginController.zID.value}'));
                if(updateSO.statusCode == 200){
                  print('Successfully updated----${updateSO.statusCode}');
                  Get.snackbar(
                      'Successful',
                      'Cart uploaded successfully',
                      backgroundColor: Colors.white,
                      duration: const Duration(seconds: 1)
                  );
                  isLoading(false);
                }
                break;
              case InternetConnectionStatus.disconnected:
              //code
                isLoading(false);
                Get.snackbar(
                    'Connection Error',
                    'You are disconnected from the internet',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 1)
                );
                break;
            }
          }
      );
      // close listener after 30 seconds, so the program doesn't run forever
      await Future<void>.delayed(const Duration(seconds: 2));
      await listener.cancel();
    }catch(e){
      print('Error occured $e');
    }
  }

  //for order history operation
  Future<void> deleteFromItemWiseCart(String cartID) async{
    await DatabaseRepo().deleteItemWiseCartHeader(cartID);
    await getCartHeaderList();
  }


  //update cartdetails
  TextEditingController quantity = TextEditingController();
  Future<void> updateItemWiseCartDetails(String cartID, String itemCode, String qty, String price, String packQty)async{
    try{
      await DatabaseRepo().updateCartDetailsTable(cartID, itemCode, qty, price, packQty);
      await getCartHeaderDetailsList(cartID);
      await getCartHeaderList();
      quantity.clear();
    }catch(e){
      print('Failed to execute the process: $e');
    }
  }

}