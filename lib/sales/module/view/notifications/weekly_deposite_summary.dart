import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../controller/report_controller.dart';
import 'package:http/http.dart' as http;

class WeeklyDepositSummary extends StatefulWidget {
  WeeklyDepositSummary({required this.zbusiness, required this.zid, required this.xposition});

  String zid;
  String zbusiness;
  String xposition;


  @override
  State<WeeklyDepositSummary> createState() => _WeeklyDepositSummaryState();
}

class _WeeklyDepositSummaryState extends State<WeeklyDepositSummary> {


  bool data_available = true;

  int length = 0;

  List<dynamic> item = [];
  //  Future<List<GamingPackageList>>? getallgamespackagelist;
  Future<List<dynamic>>  dailyDeposit() async {
    final response = await http.get(Uri.parse('http://${AppConstants.baseurl}/GAZI/SalesForce/reports/dailyDeposit.php?zid=${widget.zid}&staff=${widget.xposition}'),);

    print("http://${AppConstants.baseurl}/GAZI/SalesForce/reports/dailyDeposit.php?zid=${widget.zid}&staff=${widget.xposition}");

    print(response.body);

    if(response.statusCode == 404){
      setState(() {
        data_available = false;
      });
    }

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        length = data.length;
        item = data;
      });
      for (var i = 0; i < data.length; i++) {
        data[i]['serial'] = i + 1;
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  void initState() {
    // TODO: implement initState

    print(widget.xposition);
    super.initState();
    dailyDeposit();
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
              )),
          title: BigText(
            overflow: TextOverflow.ellipsis,
            text: "Deposit Summary Last 30 Days",
            color: AppColor.defWhite,
            size: 20,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height, // Set the height of the container
          width: MediaQuery.of(context).size.width,   // Set the width of the container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          // Fixed first column
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Container(
                          //     width: 225, // Width of the first column
                          //     child: DataTable(
                          //       columnSpacing: 2,
                          //       horizontalMargin: 5,
                          //       dataRowHeight: 40.0,
                          //       columns: [
                          //         DataColumn(
                          //           label: Text('Customer'),
                          //         ),
                          //         // Added DataColumn for Column B
                          //       ],
                          //
                          //       rows: List<DataRow>.generate(
                          //         length, // Use length here
                          //             (index) => DataRow(
                          //           cells: [
                          //             // DataCell(
                          //             //   Align(
                          //             //     alignment: Alignment.centerLeft,
                          //             //     child: Container(
                          //             //       width: 80,
                          //             //       height: 60.0,
                          //             //       child: Text(item[index]['xdepositnum']),
                          //             //     ),
                          //             //   ),
                          //             // ),
                          //             DataCell(
                          //               Align(
                          //                 alignment: Alignment.centerLeft,
                          //                 child: Container(
                          //                   //width: 80,
                          //                   height: 60.0,
                          //                   child: Column(
                          //                     crossAxisAlignment: CrossAxisAlignment.start,
                          //                     children: [
                          //                       Text(item[index]['xcus']),
                          //                       Text(item[index]['cusname']), // Display the 'cusname' value
                          //                          // Display the 'xcus' value
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          // Scrollable columns
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                             /* child: DataTable(
                                columnSpacing: 4,
                                horizontalMargin: 5,
                                dataRowHeight: 60.0,
                                dividerThickness: 1.0,
                                columns: [
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Customer'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Date'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Type'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Amount'),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Status'),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  length + 1, // +1 to add a final row for total sum
                                      (index) {
                                        if (index == length) { // Check if it's the last row for the total sum
                                          double totalAmount = 0.0;
                                          for (var i = 0; i < length; i++) {
                                            totalAmount += double.tryParse(item[i]['xamount'].toString()) ?? 0.0;
                                          }
                                          return DataRow(
                                            cells: [
                                              DataCell(Text('Total')),
                                              DataCell(Text('')), // Placeholder for the 'Date' column
                                              DataCell(Text('')), // Placeholder for the 'Type' column
                                              DataCell(Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(totalAmount.toStringAsFixed(2)), // Display total sum here
                                                ),
                                              )),
                                              DataCell(Text('')), // Placeholder for the 'Status' column
                                            ],
                                          );
                                        }

                                        // Regular data rows
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                height: 28.0,
                                                // Combine the text values or choose one as needed.
                                                child: Text("${item[index]['xcus']} - ${item[index]['cusname']}"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                height: 28.0,
                                                child: Text(item[index]['xdate']),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                height: 28.0,
                                                child: Text(item[index]['xarnature']),
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
                                                child: Text(item[index]['xamount']),
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
                                                child: Text(item[index]['xstatus']),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),*/
                              child: DataTable(
                                columnSpacing: 4,
                                horizontalMargin: 5,
                                dataRowHeight: 60.0,
                                dividerThickness: 1.0,
                                columns: [
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Customer'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Date'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Type'),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Amount'),
                                      ),
                                    ),
                                    numeric: true, // This will align the cell values to the right
                                  ),
                                  DataColumn(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Status'),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  length + 1, // +1 to add a final row for total sum
                                      (index) {
                                    if (index == length) {
                                      // Check if it's the last row for the total sum
                                      double totalAmount = 0.0;
                                      for (var i = 0; i < length; i++) {
                                        totalAmount += double.tryParse(item[i]['xamount'].toString()) ?? 0.0;
                                      }
                                      return DataRow(
                                        cells: [
                                          DataCell(Text('Total')),
                                          DataCell(Text('')), // Placeholder for the 'Date' column
                                          DataCell(Text('')), // Placeholder for the 'Type' column
                                          DataCell(Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(totalAmount.toStringAsFixed(2)), // Display total sum here
                                            ),
                                          )),
                                          DataCell(Text('')), // Placeholder for the 'Status' column
                                        ],
                                      );
                                    }

                                    // Regular data rows
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                height: 28.0,
                                                // Combine the text values or choose one as needed.
                                                child: Text("${item[index]['xcus']} - ${item[index]['cusname']}"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                height: 28.0,
                                                child: Text(item[index]['xdate']),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                height: 28.0,
                                                child: Text(item[index]['xarnature']),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 28.0,
                                              child: Text(item[index]['xamount']),
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
                                                child: Text(item[index]['xstatus']),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
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
    );
  }
}