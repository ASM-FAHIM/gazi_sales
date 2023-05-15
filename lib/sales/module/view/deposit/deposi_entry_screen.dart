import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/deposit_controller.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import 'entry_form.dart';

class DepositEntryScreen extends StatefulWidget {
  const DepositEntryScreen({Key? key}) : super(key: key);

  @override
  State<DepositEntryScreen> createState() => _DepositEntryScreenState();
}

class _DepositEntryScreenState extends State<DepositEntryScreen> {
  DepositController depositController = Get.put(DepositController());
  TextEditingController name = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    depositController.getDealerList();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Deposit entry",
          color: AppColor.defWhite,
          size: 25,
        ),
        /*actions: [
        Container(
          width: Dimensions.height70 + Dimensions.height45,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder( //<-- SEE HERE
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder( //<-- SEE HERE
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            dropdownColor: AppColor.defWhite,
            items: <String>[
              "Tank",
              "Toy",
            ].map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {
              depositController.selectedOption.value = value.toString();
            },
            hint: Obx(() => Text(
              depositController.selectedOption.value,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            )),
            isExpanded: true, // to make the dropdown button span the full width of the container
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ),
        )
      ],*/
      ),
      body: Obx((){
        return depositController.isLoading.value
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
                controller: name,
                decoration: const InputDecoration(
                    hintText: 'Search by name',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search)
                ),
                onChanged: (value) => depositController.search(value),),
              Expanded(
                child: ListView.builder(
                    itemCount: depositController.filteredDeals.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: SizedBox(
                          height: Dimensions.height50 + Dimensions.height20,
                          child: ListTile(
                            onTap: () {
                              // go to Mechanic screen
                              Get.to(() => DepositFormScreen(
                                tso: depositController.filteredDeals[index]["xtso"],
                                cusId: depositController.filteredDeals[index]["xcus"],
                                cusName: depositController.filteredDeals[index]["xorg"],
                                territory: depositController.filteredDeals[index]["xterritory"],
                                zone: depositController.filteredDeals[index]["xzone"] ?? ' ',
                                zm: depositController.filteredDeals[index]["xzm"] ?? ' ',
                                division: depositController.filteredDeals[index]["xdivision"] ?? ' ',
                                dm: depositController.filteredDeals[index]["dm"] ?? ' ',
                              ));
                              //Get.to(() => QrScreen());
                            },
                            tileColor: AppColor.appBarColor,
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: depositController.filteredDeals[index]["xorg"],
                                  size: 14,
                                  color: AppColor.defWhite,
                                )
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SmallText(
                                          text: depositController.filteredDeals[index]["xcus"],
                                          size: 10,
                                        ),
                                        Container(
                                          height: 50,
                                          width: Dimensions.height150,
                                          child:  SmallText(
                                            text: depositController.filteredDeals[index]["xphone"],
                                            size: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 60,
                                      width: Dimensions.height150,
                                      child: SmallText(
                                        text: depositController.filteredDeals[index]["xmadd"],
                                        size: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
