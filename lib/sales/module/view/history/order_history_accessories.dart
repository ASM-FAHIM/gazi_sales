import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazi_sales_app/sales/module/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';

class OrderHistoryAccessoriesScreen extends StatefulWidget {
  String cartId;
  String productID;
  OrderHistoryAccessoriesScreen({Key? key, required this.cartId, required this.productID}) : super(key: key);

  @override
  State<OrderHistoryAccessoriesScreen> createState() => _OrderHistoryAccessoriesScreenState();
}

class _OrderHistoryAccessoriesScreenState extends State<OrderHistoryAccessoriesScreen> {
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getCarHisAccList(widget.cartId, widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: BigText(text: 'Accessories History', color: AppColor.defWhite, size: 25,),

        ),
        body: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => cartController.isAccLoad.value
                  ? Center(child: CircularProgressIndicator(),)
                  : Expanded(
                  child: ListView.builder(
                      itemCount: cartController.listCartAccessoriesDetails.length,
                      itemBuilder: (context, index) {
                        var cartHisAccList = cartController.listCartAccessoriesDetails[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Card(
                            elevation: 2,
                            color: AppColor.defWhite,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              height: Dimensions.height120,
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(text: '${cartHisAccList['xdesc']}', size: 14,),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      BigText(text: '${cartHisAccList['xitem']}', size: 14,),
                                      if('${cartHisAccList['yes_no']}' == 'No')...[
                                        SmallText(text: ' (Product)', color: Colors.red,)
                                      ]else...[
                                        SmallText(text: ' (Accessories)', color: Colors.red,)
                                      ],
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColor.defRed,),
                                            onPressed: (){
                                              showDialog(context: context, builder: (BuildContext context){
                                                return ReusableAlert(
                                                  cartController: cartController,
                                                  cartID: widget.cartId,
                                                  productID: widget.productID,
                                                  accCode: cartHisAccList['xitem'],
                                                  qty: '${cartHisAccList['xqty']}',
                                                  xorg: cartHisAccList['xdesc'],
                                                  zID: '${cartHisAccList['zid']}',
                                                );
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SmallText(text: 'Edit', size: 15,color: Colors.white,),
                                                SizedBox(width: 10,),
                                                Icon(MdiIcons.bookEdit,color: Colors.white, size: 20, )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SmallText(text: '${cartHisAccList['xqty']} X', size: 14,),
                                      SmallText(text: ' ${cartHisAccList['xrate'].toStringAsFixed(2)} = ', size: 14,),
                                      SmallText(text: '${cartHisAccList['subTotal'].toStringAsFixed(2)}', size: 14, color: AppColor.defRed,),
                                      const Icon(MdiIcons.currencyBdt, size: 14, color: AppColor.defRed,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableAlert extends StatelessWidget {
  ReusableAlert({
    Key? key,
    required this.cartController,
    required this.cartID,
    required this.productID,
    required this.qty,
    required this.xorg,
    required this.accCode,
    required this.zID,

  }) : super(key: key);

  final CartController cartController;
  final String cartID;
  final String productID;
  final String qty;
  final String xorg;
  final String accCode;
  final String zID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Update Item',
        style: GoogleFonts.urbanist(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black54),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              accCode,
              style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w800,
                  color: Colors.black54),
            ),
            Text(
              xorg,
              style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w800,
                  color: Colors.black54),
            ),
            Text(
              'Ordered quantity: $qty',
              style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w800,
                  color: Colors.black54),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 45,
                width: 100,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'-')),
                    FilteringTextInputFormatter.deny(RegExp(r'\.')),
                    FilteringTextInputFormatter.deny(RegExp(r',')),
                    FilteringTextInputFormatter.deny(RegExp(r'\+')),
                    FilteringTextInputFormatter.deny(RegExp(r'\*')),
                    FilteringTextInputFormatter.deny(RegExp(r'/')),
                    FilteringTextInputFormatter.deny(RegExp(r'=')),
                    FilteringTextInputFormatter.deny(RegExp(r'%')),
                    FilteringTextInputFormatter.deny(RegExp(r' ')),
                  ],
                  textAlign: TextAlign.center,
                  controller: cartController.accQty,
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) async{
                    if(cartController.accQty.text.isEmpty){
                      Navigator.pop(context);
                    }else{
                      await cartController.updateFromAccHisScreen(accCode, cartID, cartController.accQty.text, zID, productID);
                      Navigator.pop(context);
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.green,),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    border: OutlineInputBorder(),
                    hintText: "Enter quantity",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 15,fontWeight: FontWeight.w600),
                  ),
                )),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'No',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text(
            'Yes',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async{
            if(cartController.accQty.text.isEmpty){
              Navigator.pop(context);
            }else{
              await cartController.updateFromAccHisScreen(accCode, cartID, cartController.accQty.text, zID, productID);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
