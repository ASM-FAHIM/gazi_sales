import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform, exit;
import 'package:gazi_sales_app/sales/module/model/product_accessories_model.dart';
import 'package:gazi_sales_app/sales/module/model/product_nature_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data_model/promotion.dart';
import '../../constant/app_constants.dart';
import '../../constant/colors.dart';
import '../../databaseHelper/database_repo.dart';
import '../../databaseHelper/gift_promo_repo.dart';
import '../../databaseHelper/login_repo.dart';
import '../model/ca_cus_price_model.dart';
import '../model/dealer_model.dart';
import '../model/gift_promo_model/promotion_model.dart';
import '../model/master_model.dart';
import '../model/product_model.dart';
import 'login_controller.dart';

class DashboardController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  AppConstants appConstants = AppConstants();
  RxBool isLoading = false.obs;

/*  var authPicPath = "".obs;
  var dealerWisePicPath = "".obs;
  var checkOutPicPath = "".obs;
  var dealerWiseOutPicPath = "".obs;

  void initState() {
    super.onInit();
    setAuthImagePath(authPicPath.value);
    setDealerWiseImagePath(dealerWisePicPath.value);
    setCheckOutImagePath(checkOutPicPath.value);
    setDealerWiseOutImagePath(dealerWiseOutPicPath.value);
  }

  void setAuthImagePath(String path) {
    try {
      authPicPath.value = path;
      Get.back();
    } finally {}
  }

  void setDealerWiseImagePath(String path) {
    try {
      dealerWisePicPath.value = path;
      Get.back();
    } finally {}
  }

  //for check-Out
  void setCheckOutImagePath(String path) {
    try {
      checkOutPicPath.value = path;
      Get.back();
    } finally {}
  }

  void setDealerWiseOutImagePath(String path) {
    try {
      dealerWiseOutPicPath.value = path;
      Get.back();
    } finally {}
  }

  //insert to check shop
  RxBool isConnected = false.obs;
  DateTime now = DateTime.now();

  Future<void> internetCheck(String imagePath, String dVisitName) async {
    isConnected(true);
    String date = DateFormat.yMMMMd().format(now);
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            await loginController.periodicallyLocationTracking();
            print(
                '############ ${loginController.xsid.value}   -------------$dVisitName');
            print(loginController.curntLong.value.toString());
            print(loginController.addressInOut.value.toString());
            var responseDealerCheckIn = await http.post(
                Uri.parse(
                    "http://${AppConstants.baseurl}/salesforce/TSOAttDealer.php"),
                body: jsonEncode(<String, dynamic>{
                  "TSOID": loginController.xtso.value,
                  "InTime": DateTime.now().toString(),
                  "OutTime": DateTime.now().toString(),
                  "xidsup": loginController.xsid.value,
                  "dealer": dVisitName,
                  "Latitude": loginController.curntLat.value.toString(),
                  "Longitude": loginController.curntLong.value.toString(),
                  "location": loginController.addressInOut.value.toString(),
                  "image": imagePath,
                }));
            if (responseDealerCheckIn.statusCode == 200) {
              print('-----------------$responseDealerCheckIn');
              Map<String, dynamic> dealerVisitInfo = {
                "tsoId": loginController.xtso.value,
                "dealerName": dVisitName,
                "xidsup": loginController.xsid.value,
                "xdate": date,
                "InTime": DateTime.now().toString(),
                "Latitude": loginController.curntLat.value.toString(),
                "Longitude": loginController.curntLong.value.toString(),
                "location": loginController.addressInOut.value.toString(),
                "ImagePath": imagePath,
              };
              await LoginRepo().insertToDealerVisitTable(dealerVisitInfo);
              Get.snackbar('Checked in',
                  'You Checked in from ${loginController.addressInOut.value.toString()}',
                  titleText: const Text(
                    'Checked in',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  messageText: Text(
                    'You Checked in from ${loginController.addressInOut.value.toString()}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  backgroundColor: AppColor.defWhite,
                  duration: const Duration(seconds: 3));
              print('Data connection is available.');
              isConnected(false);
            } else {
              isConnected(false);
              print(
                  'Failed to connect api: ${responseDealerCheckIn.statusCode}');
            }
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            Map<String, dynamic> dealerVisitInfo = {
              "tsoId": loginController.xtso.value,
              "dealerName": dVisitName,
              "xidsup": loginController.xsid.value,
              "xdate": date,
              "InTime": now.toString(),
              "Latitude": loginController.curntLat.value.toString(),
              "Longitude": loginController.curntLong.value.toString(),
              "location": loginController.addressInOut.value.toString(),
              "ImagePath": imagePath,
            };
            LoginRepo().insertToDealerVisitTable(dealerVisitInfo);
            isConnected(false);
            Get.snackbar('Checked in status',
                'You Checked in from ${loginController.addressInOut.value.toString()}',
                titleText: const Text(
                  'Checked in',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                messageText: Text(
                  'You Checked in from ${loginController.addressInOut.value.toString()}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                backgroundColor: AppColor.defWhite,
                duration: const Duration(seconds: 3));
            print('You are disconnected from the internet.');
            break;
        }
      },
    );
    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 10));
    await listener.cancel();
  }

  //for check-out from dealer
  RxBool isOutDone = false.obs;

  Future<void> internetCheckOut(String outImagePath, String dVisitName) async {
    isOutDone(true);
    String date = DateFormat.yMMMMd().format(now);
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            await loginController.periodicallyLocationTracking();
            var responseDealerCheckOut = await http.post(
                Uri.parse(
                    "http://${AppConstants.baseurl}/salesforce/TSOAttDealer.php"),
                body: jsonEncode(<String, dynamic>{
                  "TSOID": loginController.xtso.value,
                  "InTime": DateTime.now().toString(),
                  "OutTime": DateTime.now().toString(),
                  "xidsup": loginController.xsid.value,
                  "dealer": dVisitName,
                  "Latitude": loginController.curntLat.value.toString(),
                  "Longitude": loginController.curntLong.value.toString(),
                  "location": loginController.addressInOut.value.toString(),
                  "image": outImagePath,
                }));
            if (responseDealerCheckOut.statusCode == 200) {
              print('-----------------${responseDealerCheckOut.statusCode}');
              print('-----------------${loginController.xtso.value}');
              print('-----------------${DateTime.now().toString()}');
              print('-----------------${dVisitName}');
              // Map<String, dynamic> dealerVisitInfo = {
              //   "tsoId" : loginController.xso.value,
              //   "dealerName": dVisitName,
              //   "xidsup": loginController.xsid.value,
              //   "xdate": date,
              //   "InTime" : now.toString(),
              //   "Latitude" : loginController.curntLat.value.toString(),
              //   "Longitude" : loginController.curntLong.value.toString(),
              //   "location" : loginController.addressInOut.value.toString(),
              //   "ImagePath" : imagePath,
              // };
              // await LoginRepo().insertToDealerVisitTable(dealerVisitInfo);
              Get.snackbar('Checked out',
                  'You Checked out from ${loginController.addressInOut.value.toString()}',
                  titleText: const Text(
                    'Checked out',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  messageText: Text(
                    'You Checked out from ${loginController.addressInOut.value.toString()}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  backgroundColor: AppColor.defWhite,
                  duration: const Duration(seconds: 3));
              print('Data connection is available.');
              isOutDone(false);
            } else {
              isOutDone(false);
              print(
                  'Failed to connect api: ${responseDealerCheckOut.statusCode}');
            }
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            */ /*Map<String, dynamic> dealerVisitInfo = {
              "tsoId" : loginController.xsp.value,
              "dealerName": dVisitName,
              "xidsup": loginController.xsid.value,
              "xdate": date,
              "InTime" : now.toString(),
              "Latitude" : loginController.curntLat.value.toString(),
              "Longitude" : loginController.curntLong.value.toString(),
              "location" : loginController.addressInOut.value.toString(),
              "ImagePath" : outImagePath,
            };*/ /*
            // LoginRepo().insertToDealerVisitTable(dealerVisitInfo);
            print('You are disconnected from the internet.');
            isOutDone(false);
            // Get.snackbar('Checked out', 'You Checked out from ${loginController.addressInOut.value.toString()}',
            //     titleText: const Text('Checked out', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
            //     messageText: Text('You Checked out from ${loginController.addressInOut.value.toString()}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
            //     backgroundColor: AppColor.defWhite,
            //     duration: const Duration(seconds: 3));
            break;
        }
      },
    );
    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 10));
    await listener.cancel();
  }

*/ /*  RxBool givingAtt = false.obs;
  //giving Checked In and Checked Out
  Future<void> checkFunction(String imagePath) async{
    try{
      givingAtt(true);
      await loginController.periodicallyLocationTracking();
      var inOutResponse = await http.post(Uri.parse('http://${AppConstants.baseurl}/salesforce/TSOattendance.php'),
          body: jsonEncode(<String, dynamic>{
            "TSOID" : loginController.xsp.value,
            "InTime" : now.toString(),
            "OutTime" : now.toString(),
            "Latitude" : loginController.curntLat.value.toString(),
            "Longitude" : loginController.curntLong.value.toString(),
            "location" : loginController.addressInOut.value.toString(),
            "image" : imagePath,
          })
      );
      if(inOutResponse.statusCode == 200){
        Get.snackbar('Checked in', 'You Checked in from ${loginController.addressInOut.value.toString()}',
            titleText: const Text('Checked in', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
            messageText: Text('You Checked in from ${loginController.addressInOut.value.toString()}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
            backgroundColor: AppColor.defWhite,
            duration: const Duration(seconds: 3));
        print('checking status :${inOutResponse.statusCode}');
      }

    }catch(e){
      print('Fail to give attendance because of : $e');
    }
    givingAtt(false);
  }*/ /*

  //for exit the app
  Future<bool?> showWarningContext(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: BigText(
            text: 'Exit',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                BigText(
                  text: 'Do you want to exit the app?',
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColor.appBarColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset.zero, // changes position of shadow
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: SmallText(
                      text: "No",
                      color: AppColor.defWhite,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColor.appBarColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset.zero, // changes position of shadow
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: SmallText(
                      text: "Yes",
                      color: AppColor.defWhite,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );*/

  ///dealer fetch and insert to local db
  List<DealerModel> dealersList = [];

  Future<Object> getDealerInfo() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/dealerinfo.php?xstaff=${loginController.xstaff.value}'));
      if (response.statusCode == 200) {
        dealersList = dealerModelFromJson(response.body);
        await Future.wait((json.decode(response.body) as List).map((dealer) {
          return DatabaseRepo().addDealer(DealerModel.fromJson(dealer));
        }).toList());
        isLoading(false);
        return 'Success';
      } else {
        isLoading(false);
        print("There is an Error getting dealer:  ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Something went wrong $e");
      return isLoading(false);
    }
  }

  List list = [];

  //experimental use of function
  List foundDealerList = [];
  List<String> dealerName = [];
  RxBool isLoading1 = false.obs;
  RxString dealersName = ''.obs;

  Future getDealerList() async {
    try {
      //enableDealerList(false);
      isLoading1(true);
      list = await DatabaseRepo().getDealer(
          loginController.xterritory.value, loginController.zID.value);
      foundDealerList = list;
      print('Dealers list: $list');
      isLoading1(false);
      //dealerName = (List<String>.from(list.map((e) => e['xorg'])));
      //dealerCode = (List<String>.from(list.map((e) => e['xcus'])));
    } catch (e) {
      isLoading1(false);
      print('There is an error occured: $e');
    }
  }

  RxBool isLoading5 = false.obs;

  // RxBool enableDealerList = false.obs;
  void runFilter(String keyword) async {
    try {
      isLoading5(true);
      List result = [];
      if (keyword.isEmpty) {
        result = list;
        isLoading5(false);
      } else {
        result = list
            .where((name) =>
                name['xorg'].toLowerCase().contains(keyword.toLowerCase()))
            .toList();
        isLoading5(false);
        print('Actual list : $result');
      }
      foundDealerList = result;
      isLoading5(false);
    } catch (e) {
      isLoading5(false);
      print('Error Occured: $e');
    }
  }

  /*List dealerListByName = [];
  RxBool isLoading5 = false.obs;
  RxBool enableDealerList = false.obs;
  Future getDealerListByName() async{
    try{
      enableDealerList(true);
      isLoading5(true);
      dealerListByName = await DatabaseRepo().getDealersByName(dealersName.value);
      isLoading5(false);
      print('Dealers list: $dealerListByName');
      for(int i = 1; i<dealerListByName.length; i++){
        print('----------${dealerListByName[i]}');
        print("Dealer zid : ${dealerListByName[i]['xso']}");
      }
    }catch(e){
      print('Exception occured  $e');
    }
  }*/

  //delete dealer table first
  Future dropDealerTable() async {
    DatabaseRepo().dropTable();
    print('Table deleted successfully');
  }

  ///product fetch and insert to local db
  //delete product nature table first
  Future dropProductNatureTable() async {
    DatabaseRepo().dropProductNatureTable();
  }

  //product nature fetch from server
  RxBool isPNFetched = false.obs;
  List<ProductNatureModel> pNatureList = [];

  Future<Object> insertIntoProductNature() async {
    try {
      isPNFetched(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/productNature.php?zid=${loginController.zID.value}&tso=${loginController.xtso.value}'));
      if (response.statusCode == 200) {
        pNatureList = productNatureModelFromJson(response.body);
        await Future.wait((json.decode(response.body) as List).map((pNatures) {
          return DatabaseRepo()
              .insertProductNature(ProductNatureModel.fromJson(pNatures));
        }).toList());
        isPNFetched(false);
        return 'Product nature inserted to pnature table Successfully';
      } else {
        isPNFetched(false);
        print("There is an Error getting p nature: ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Something went wrong $e");
      return isPNFetched(false);
    }
  }

  //get ProductNature List
  List productNatureList = [];
  RxBool isPNatureloaded = false.obs;

  Future<void> getPNatureList() async {
    try {
      isPNatureloaded(true);
      productNatureList =
          await DatabaseRepo().getProductNature(loginController.zID.value);
      isPNatureloaded(false);
      print("found product natures : $productNatureList");
    } catch (error) {
      isPNatureloaded(false);
      print('There are some issue getting cartAccessories List: $error');
    }
  }

  // fetch product list from server
  RxBool isLoading3 = false.obs;
  List<ProductModel> productsList = [];

  Future<Object> getProductInfo() async {
    try {
      isLoading3(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/productlist.php'));
      if (response.statusCode == 200) {
        productsList = productModelFromJson(response.body);
        await Future.wait(
          (json.decode(response.body) as List).map((product) async {
            await DatabaseRepo().addProduct(ProductModel.fromJson(product));
          }).toList(),
        );
        isLoading3(false);
        return 'Product fetched Successfully';
      } else {
        print(
            "There is an Error getting product:------------------ ${response.statusCode}");
        isLoading3(false);
        return response.statusCode;
      }
    } catch (e) {
      print("Something went wrong fetching product List:  $e");
      return isLoading3(false);
    }
  }

  List productList = [];
  List updatedProductList = [];
  RxBool isLoading2 = false.obs;

  Future getProductList(String xcus, String dealerType, String pNature) async {
    try {
      isLoading2(true);
      loginController.xPNature.value = pNature;
      productList = await DatabaseRepo()
          .getProduct(loginController.zID.value, dealerType, pNature);
      foundProductList = productList; //for search option in product list
      await getCusWisePrice();
      if (listcaCusWisePrice.isEmpty) {
        for (int k = 0; k < productList.length; k++) {
          updatedProductList.length = k + 1;
          updatedProductList[k] = '${productList[k]["totrate"]}';
        }
      } else {
        for (int i = 0; i < productList.length; i++) {
          for (int j = 0; j < listcaCusWisePrice.length; j++) {
            if (xcus == listcaCusWisePrice[j]["xcus"] &&
                productList[i]["xitem"] == listcaCusWisePrice[j]["xitem"]) {
              updatedProductList.length = i + 1;
              updatedProductList[i] = '${listcaCusWisePrice[j]["xrate"]}';
            } else {
              updatedProductList.length = i + 1;
              updatedProductList[i] = '${productList[i]["totrate"]}';
            }
          }
        }
      }
      print('Updated product list == $updatedProductList');
      isLoading2(false);
    } catch (e) {
      isLoading2(false);
      print("Error geting product from local Database: $e");
    }
  }

  RxBool isSearched = false.obs;
  List foundProductList = [];

  // RxBool enableDealerList = false.obs;
  void runFilterForProduct(String keyword) async {
    try {
      isSearched(true);
      List result = [];
      if (keyword.isEmpty) {
        result = productList;
        isSearched(false);
      } else {
        result = productList
            .where((name) =>
                name['xdesc'].toLowerCase().contains(keyword.toLowerCase()))
            .toList();
        isSearched(false);
        print('Actual list : $result');
      }
      foundProductList = result;
      isSearched(false);
    } catch (e) {
      isSearched(false);
      print('Error Occured: $e');
    }
  }

/*  var specProduct;
  Future getSpecPInfo(String xitem) async{
    specProduct = await DatabaseRepo().getSpecificProductsInfo(xitem);
  }*/

  //delete dealer table first
  Future dropProductTable() async {
    DatabaseRepo().dropProductTable();
    print('Table deleted successfully');
  }

  RxBool isFetched = false.obs;
  InvoiceModel? invoiceModel;

  Future<void> getInvoiceInfo(String tsoId) async {
    isFetched(true);
    var invoiceRes = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/salesforce/MonthlyInvoice.php?tso=$tsoId'));
    if (invoiceRes.statusCode == 200) {
      invoiceModel = invoiceModelFromJson(invoiceRes.body);
      print(invoiceRes.body);
      isFetched(false);
    }
    // await getMonthlyTarget();
  }

  ///product accessories fetch and insert to local db
  RxBool isPALoaded = false.obs;
  List<ProductAccessoriesModel> productsAccessoriesList = [];

  Future<Object> getProductAccessoriesInfo() async {
    try {
      isPALoaded(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/ProductAccessoriesList.php'));
      if (response.statusCode == 200) {
        productsAccessoriesList =
            productAccessoriesModelFromJson(response.body);
        await Future.wait(
            (json.decode(response.body) as List).map((productAccessories) {
          return DatabaseRepo().addProductAccessories(
              ProductAccessoriesModel.fromJson(productAccessories));
        }).toList());
        isPALoaded(false);
        return 'Product fetched Successfully';
      } else {
        isPALoaded(false);
        print(
            "There is an Error getting accessories:------------------ ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Something went wrong fetching product List:  $e");
      return isPALoaded(false);
    }
  }

  //delete dealer table first
  Future dropProductAccessoriesTable() async {
    DatabaseRepo().dropProductAccessoriesTable();
    print('Product Accessories table deleted successfully');
  }

  ///cus wise product
  RxBool isLoading4 = false.obs;
  List<CaCusPriceModel> caCusPriceList = [];

  Future<Object> getCusWiseProduct() async {
    try {
      isLoading4(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/CUSwiseProductList.php'));
      if (response.statusCode == 200) {
        caCusPriceList = caCusPriceModelFromJson(response.body);
        await Future.wait(
            (json.decode(response.body) as List).map((caCusPrice) {
          return DatabaseRepo()
              .addIntoCaCusPrice(CaCusPriceModel.fromJson(caCusPrice));
        }).toList());
        isLoading4(false);
        return 'CusWiseProduct fetched Successfully';
      } else {
        isLoading4(false);
        print("There is an Error getting caCus price: ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Something went wrong $e");
      return isLoading4(false);
    }
  }

  //delete cuc wise product first
  Future dropCaCusPriceTable() async {
    DatabaseRepo().deleteCaCusPriceTable();
    print('Table deleted successfully');
  }

  RxBool isLoading7 = false.obs;

  Future<void> asyncFunction() async {
    isLoading7(true);
    DateTime startTime = DateTime.now();
    try {
      await getDealerInfo();
      await getProductInfo();
      await getProductAccessoriesInfo();
      await insertIntoProductNature();
      await getCusWiseProduct();
      Get.snackbar(
        'Success',
        'Successfully fetched data',
        backgroundColor: AppColor.defWhite,
        duration: const Duration(seconds: 1),
      );
      isLoading7(false);
    } catch (e) {
      print("Something went wrong $e");
      isLoading7(false);
      // handle the error accordingly
    } finally {
      isLoading7(false);
      print('--------Successfully fetched');
    }
  }

  //for getting cacuswisePrice from cart table
  List listcaCusWisePrice = [];
  RxBool listCusPriceFetched = false.obs;

  Future getCusWisePrice() async {
    try {
      listCusPriceFetched(true);
      listcaCusWisePrice = await DatabaseRepo().getCusWisePrice();
      print('---------------$listcaCusWisePrice');
      listCusPriceFetched(false);
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //for count DealerVisit Table row

  //delete cuc wise product first
  Future dropDealerVisitTable() async {
    LoginRepo().deleteFromDealerVisitTable();
    print('Table deleted successfully');
  }

  //get dealer visit table count
  RxInt dVisitedShops = 0.obs;
  RxInt dRemainShops = 0.obs;
  RxInt mVisitedShops = 0.obs;
  RxInt mRemainShops = 0.obs;

  Future checkMonthlyTarget() async {
    try {
      int temp1 = int.parse('${loginController.tsoInfoList[0]["mTarget"]}');
      mVisitedShops.value =
          int.parse('${loginController.tsoInfoList[0]["mshopvisit"]}');
      if (temp1 >= mVisitedShops.value) {
        mRemainShops.value = temp1 - mVisitedShops.value;
        print('count visit : $mVisitedShops');
        print('count remaining : $mRemainShops');
      } else {
        Get.snackbar('Limit error', 'Daily limit exceed',
            backgroundColor: AppColor.defRed,
            duration: const Duration(seconds: 1));
      }
    } catch (error) {
      print('There are some issue: $error');
    }
  }

  //get visited dealer list
  //for getting cart_List from cart table
  // List visitedDealer = [];
  List dashBoardValues = [];
  RxBool isValueFound = false.obs;

  Future getDashboardValues() async {
    try {
      // await countDealerVisitTable();
      // await checkMonthlyTarget();
      isValueFound(true);
      dashBoardValues = await LoginRepo().getTsoInfo(loginController.zID.value);
      isValueFound(false);
      print(dashBoardValues);
    } catch (error) {
      isValueFound(false);
      print('There are some issue: $error');
    }
  }

/*Future countDealerVisitTable() async {
    try {
      await checkMonthlyTarget();
      int temp = int.parse('${loginController.tsoInfoList[0]["dTarget"]}');
      print("total shops need to visit : $temp");
      dVisitedShops.value = await LoginRepo().countDealerVisit();
      if (temp >= dVisitedShops.value) {
        dRemainShops.value = temp - dVisitedShops.value;
        print('count visit : $dVisitedShops');
        print('count remaining : $dRemainShops');
      } else {
        Get.snackbar('Limit error', 'Daily limit exceed',
            backgroundColor: AppColor.defRed,
            duration: const Duration(seconds: 1));
      }
    } catch (error) {
      print('There are some issue: $error');
    }
  }*/

  //for getting cart_List from cart table
  var listGiftPromo = <ListPromotionModel>[].obs;
  RxBool listFetched = false.obs;

  Future getGiftPromoList() async {
    try {
      listFetched(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/promoreport.php?zid=${loginController.zID.value}"));
      var promotions = listPromotionModelFromJson(response.body);
      listGiftPromo.assignAll(promotions.map((e) => e));
      print("Promotions are: ${listGiftPromo}");
    } catch (error) {
      print('There are some issue: $error');
    } finally {
      listFetched(false);
    }
  }
}
