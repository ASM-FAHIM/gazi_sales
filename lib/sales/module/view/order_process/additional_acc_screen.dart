import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';


class AdditionAccScreen extends StatefulWidget {
  String productCode;
  AdditionAccScreen({Key? key, required this.productCode}) : super(key: key);

  @override
  State<AdditionAccScreen> createState() => _AdditionAccScreenState();
}

class _AdditionAccScreenState extends State<AdditionAccScreen> {
  CartController cartController = Get.find<CartController>();
  TextEditingController accNameSearch = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getAllAccessoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            ),
          ),
          title: BigText(
            text: "Add Accessories",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Obx((){
          return cartController.isAllAccLoaded.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const CircularProgressIndicator(
                          color: AppColor.appBarColor,
                        ),
                      ),
                      const Text('Loading...')
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: accNameSearch,
                        decoration: const InputDecoration(
                            hintText: 'Search by name',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.search)
                        ),
                        onChanged: (value) => cartController.runFilterForAccessories(value),
                      ),
                      const SizedBox(height: 10,),
                      Obx((){
                        return Expanded(
                          child: cartController.isSearched.value
                              ? Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: CircularProgressIndicator(
                                          color: AppColor.appBarColor,
                                        ),
                                      ),
                                      Text('Loading...')
                                    ],
                                  ),
                                )
                              : ListView.builder(
                              itemCount: cartController.foundAccList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Container(
                                    height: Dimensions.height70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //color: Colors.green,
                                      boxShadow: const [
                                        BoxShadow(
                                          // color: Colors.greenAccent[200],
                                          offset: Offset(0.01,0.01,),
                                          blurRadius: 1.10,
                                          spreadRadius: .05,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ],
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColor.appBarColor,
                                      ),
                                      onPressed: (){
                                        print("Main producy COde: ${widget.productCode}");
                                        cartController.insertAdditionalAccessories(
                                            cartController.foundAccList[index]["xitemaccessories"],
                                            widget.productCode,
                                            cartController.foundAccList[index]["xqty"],
                                            scaffoldKey
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    cartController.foundAccList[index]["name"],
                                                    style: TextStyle(color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.bold, fontSize: 14),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SmallText(text: cartController.foundAccList[index]["xitemaccessories"], color: Colors.white, size: 14,),
                                                      SmallText(text: cartController.foundAccList[index]["xunit"], color: Colors.white, size: 14,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          /*Container(
                                            width: 170,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                IconButton(

                                                  onPressed: () {
                                                    cartController.updateCartAccessories(cartController.cartAcc[index]["xitem"], widget.productCode, -1);
                                                  },
                                                  alignment: Alignment.center,
                                                  icon: const Icon(
                                                    MdiIcons.minusCircle,
                                                    size: 35,
                                                    color: AppColor.appBarColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 20,),
                                                Text(cartController.cartAcc[index]["xqty"].toString(),
                                                  style: TextStyle(
                                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                                      fontSize: 20),),
                                                const SizedBox(width: 20,),
                                                IconButton(
                                                  onPressed: () {
                                                    cartController.updateCartAccessories(cartController.cartAcc[index]["xitem"], widget.productCode, 1);
                                                  },
                                                  icon: const Icon(
                                                    MdiIcons.plusCircle,
                                                    size: 35,
                                                    color: AppColor.appBarColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )*/
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      })
                    ],
                  ),
          );
        })
    );
  }
}



/*
GridView.builder(
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 2.0,
mainAxisSpacing: 2.0,
childAspectRatio: 1.3),
itemCount: cartController.allAccList.length,
itemBuilder: (context, index) {
return Padding(
padding: const EdgeInsets.all(8.0),
child: Container(
decoration: BoxDecoration(
border: Border(),
borderRadius: BorderRadius.circular(20.0),
color: const Color(0xff7c94b6),
image:  DecorationImage(
fit: BoxFit.cover,
colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
image:  const AssetImage('assets/images/user.png',),
),
),
clipBehavior: Clip.hardEdge,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
primary: const Color(0xff323A48),
),
onPressed: (){
cartController.insertAdditionalAccessories(
cartController.allAccList[index]["xitem"],
widget.productCode,
cartController.allAccList[index]["xqty"] as double,
context
);
},
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
alignment: Alignment.center,
height: 50,
width: double.infinity,
child: Text(
cartController.allAccList[index]["accName"],
style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
),
),
SmallText(
text: cartController.allAccList[index]["xitem"],
size: 14,
color:
AppColor.defWhite,
),
],
),
),
),
);
})*/
