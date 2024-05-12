import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/data_table_widget.dart';
import '../../../widget/table_title_widget.dart';
import '../../controller/report_controller.dart';

class MonthlySODetailsReport extends StatefulWidget {
  String xCus;
  String cusName;
  String soNum;

  MonthlySODetailsReport(
      {required this.xCus,
      required this.cusName,
      required this.soNum,
      Key? key})
      : super(key: key);

  @override
  State<MonthlySODetailsReport> createState() => _MonthlySODetailsReportState();
}

class _MonthlySODetailsReportState extends State<MonthlySODetailsReport> {
  ReportController report = Get.put(ReportController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchMonthlySoDetailsList(widget.xCus, widget.soNum);
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
                report.monthlySoDetailsList.clear();
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              )),
          title: BigText(
            overflow: TextOverflow.ellipsis,
            text: widget.cusName,
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Obx(() {
          return report.soDelFetched.value
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
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Dimensions.height50,
                alignment: Alignment.center,
                child: Text(widget.soNum,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          // Fixed first column
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: 240, // Width of the first column
                              child: DataTable(
                                columnSpacing: 2,
                                horizontalMargin: 5,
                                dataRowHeight: 40.0,
                                columns: [
                                  DataColumn(
                                    label: Text('Item code'),
                                  ),
                                  DataColumn(
                                    label: Text('Item name'),
                                  ),
                                  // Added DataColumn for Column B
                                ],
                                rows: List<DataRow>.generate(
                                  report.monthlySoDetailsList.length, // Use length here
                                      (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 80,
                                            height: 28.0,
                                            child: Text(report.monthlySoDetailsList[index].xitem),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            //width: 80,
                                            height: 60.0,
                                            child: Text(report.monthlySoDetailsList[index].xdesc),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Scrollable columns
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 2,
                                horizontalMargin: 5,
                                dataRowHeight: 40.0,
                                dividerThickness: 1.0, // Set divider thickness
                                // dividerColor: Colors.blue,
                                columns: [
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('So qty'),
                                    ),
                                  ),

                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('So vl'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Dc qty'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Dc vl'),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  report.monthlySoDetailsList.length, // Use length here
                                      (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 28.0,
                                              child: Text(report.monthlySoDetailsList[index].soQty),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 28.0,
                                              child: Text(report.monthlySoDetailsList[index].dcQty),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 28.0,
                                              child: Text(report.monthlySoDetailsList[index].soQty),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 28.0,
                                              child: Text(report.monthlySoDetailsList[index].dcQty),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),


        // Obx(() {
        //   return report.soDelFetched.value
        //       ? Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Container(
        //                 margin: const EdgeInsets.all(10.0),
        //                 child: const CircularProgressIndicator(
        //                   color: AppColor.appBarColor,
        //                 ),
        //               ),
        //               const Text('Loading...')
        //             ],
        //           ),
        //         )
        //       : Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Container(
        //               height: Dimensions.height50,
        //               alignment: Alignment.center,
        //               child: Text(widget.soNum,
        //                   style: const TextStyle(
        //                       decoration: TextDecoration.underline,
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.bold)),
        //             ),
        //             Expanded(
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   color: Colors.white,
        //                   height: MediaQuery.of(context).size.height,
        //                   width: MediaQuery.of(context).size.width,
        //                   child: SingleChildScrollView(
        //                     scrollDirection: Axis.vertical,
        //                     child: Row(
        //                       children: [
        //                         // Fixed first column
        //                         SingleChildScrollView(
        //                           scrollDirection: Axis.horizontal,
        //                           child: Container(
        //                             width: 240, // Width of the first column
        //                             child: DataTable(
        //                               columnSpacing: 2,
        //                               horizontalMargin: 5,
        //                               dataRowHeight: 28.0,
        //                               columns: [
        //                                 DataColumn(
        //                                   label: Text('Item code'),
        //                                 ),
        //                                 DataColumn(
        //                                   label: Text('Item name'),
        //                                 ),
        //                                 // Added DataColumn for Column B
        //                               ],
        //                               rows: List<DataRow>.generate(
        //                                 200,
        //                                     (index) => DataRow(
        //                                   cells: [
        //                                     DataCell(
        //                                       Align(
        //                                         alignment: Alignment.centerLeft,
        //                                         child: Container(
        //                                           height: 28.0,
        //                                           child: Text(report.monthlySoDetailsList[index].xitem),
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     DataCell(
        //                                       Align(
        //                                         alignment: Alignment.centerLeft,
        //                                         child: Container(
        //                                           height: 28.0,
        //                                           child: Text(report.monthlySoDetailsList[index].xdesc),
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //
        //                         // Scrollable columns
        //                         Expanded(
        //                           child: SingleChildScrollView(
        //                             scrollDirection: Axis.horizontal,
        //                             child: DataTable(
        //                               columnSpacing: 2,
        //                               horizontalMargin: 5,
        //                               dataRowHeight: 28.0,
        //                               columns: [
        //                                 DataColumn(
        //                                   label: Text('So qty'),
        //                                 ),
        //                                 DataColumn(
        //                                   label: Text('So vl'),
        //                                 ),
        //                                 DataColumn(
        //                                   label: Text('Dc qty'),
        //                                 ),
        //                                 DataColumn(
        //                                   label: Text('Dc vl'),
        //                                 ),
        //                               ],
        //                               rows: List<DataRow>.generate(
        //                                 200,
        //                                     (index) => DataRow(
        //                                   cells: [
        //                                     DataCell(
        //                                       Align(
        //                                         alignment: Alignment.centerLeft,
        //                                         child: Container(
        //                                           height: 28.0,
        //                                           child: Text(report.monthlySoDetailsList[index].soQty),
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     DataCell(
        //                                       Align(
        //                                         alignment: Alignment.centerLeft,
        //                                         child: Container(
        //                                           height: 28.0,
        //                                           child: Text(report.monthlySoDetailsList[index].dcQty),
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     DataCell(
        //                                       Align(
        //                                         alignment: Alignment
        //                                             .centerRight, // Aligning to top right side
        //                                         child: Container(
        //                                           height: 28.0,
        //                                           child: Text(report.monthlySoDetailsList[index].soQty), // Formatting to two decimal places
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     DataCell(
        //                                       Align(
        //                                         alignment: Alignment
        //                                             .centerRight, // Aligning to top right side
        //                                         child: Container(
        //                                           height: 28.0,
        //                                           child: Text(report.monthlySoDetailsList[index].dcQty), // Formatting to two decimal places
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //
        //
        //                 // ListView(
        //                 //   children: [
        //                 //     _tableTitle(context),
        //                 //     ListView.builder(
        //                 //         physics: const NeverScrollableScrollPhysics(),
        //                 //         shrinkWrap: true,
        //                 //         itemCount: report.monthlySoDetailsList.length,
        //                 //         itemBuilder: (context, index) {
        //                 //           return _dataTable(index, context);
        //                 //         }),
        //                 //   ],
        //                 // ),
        //               ),
        //             ),
        //           ],
        //         );
        // }),
      ),
    );
  }

  // Widget _dataTable(int index, BuildContext context) {
  //   final width = MediaQuery.of(context).size.width - 20;
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           DataTableWidget(
  //             width / 5,
  //             report.monthlySoDetailsList[index].xitem,
  //             shouldColorTop: true,
  //           ),
  //           Expanded(
  //             child: SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Row(
  //                 children: [
  //                   DataTableWidget(
  //                     width / 2,
  //                     report.monthlySoDetailsList[index].xdesc,
  //                     shouldColorTop: true,
  //                     shouldColorLeft: true,
  //                   ),
  //                   DataTableWidget(
  //                     width / 6.5,
  //                     report.monthlySoDetailsList[index].soQty,
  //                     shouldColorTop: true,
  //                     shouldColorLeft: true,
  //                   ),
  //                   DataTableWidget(
  //                     width / 6.5,
  //                     report.monthlySoDetailsList[index].dcQty,
  //                     shouldColorTop: true,
  //                     shouldColorLeft: true,
  //                   ),DataTableWidget(
  //                     width / 6.5,
  //                     report.monthlySoDetailsList[index].soQty,
  //                     shouldColorTop: true,
  //                     shouldColorLeft: true,
  //                   ),
  //                   DataTableWidget(
  //                     width / 6.5,
  //                     report.monthlySoDetailsList[index].dcQty,
  //                     shouldColorTop: true,
  //                     shouldColorLeft: true,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _tableTitle(BuildContext context) {
  //   final width = MediaQuery.of(context).size.width - 20;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           TableTitle(width / 5, 'Item code', shouldOffRight: false),
  //
  //           Expanded(
  //             child: SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Row(
  //                 children: [
  //                   TableTitle(width / 2, 'Item name'),
  //                   TableTitle(width / 6.5, 'So qty'),
  //                   TableTitle(width / 6.5, 'So vl'),
  //                   TableTitle(width / 6.5, 'Dc qty'),
  //                   TableTitle(width / 6.5, 'Dc vl'),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }


// Widget _dataTable(int index, BuildContext context) {
  //   final width = MediaQuery.of(context).size.width - 20;
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           DataTableWidget(
  //             width / 5,
  //             report.monthlySoDetailsList[index].xitem,
  //             shouldColorTop: true,
  //           ),
  //
  //           DataTableWidget(width / 2, report.monthlySoDetailsList[index].xdesc,
  //               shouldColorTop: true, shouldColorLeft: true),
  //           DataTableWidget(
  //               width / 6.5, report.monthlySoDetailsList[index].soQty,
  //               shouldColorTop: true, shouldColorLeft: true),
  //           DataTableWidget(
  //               width / 6.5, report.monthlySoDetailsList[index].dcQty,
  //               shouldColorTop: true, shouldColorLeft: true),
  //         ],
  //       )
  //     ],
  //   );
  // }
  //
  // Widget _tableTitle(BuildContext context) {
  //   final width = MediaQuery.of(context).size.width - 20;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           TableTitle(width / 5, 'Item code', shouldOffRight: false),
  //           TableTitle(width / 2, 'Item name'),
  //           TableTitle(width / 6.5, 'So qty'),
  //           TableTitle(width / 6.5, 'Dc qty'),
  //         ],
  //       )
  //     ],
  //   );
  // }
}
