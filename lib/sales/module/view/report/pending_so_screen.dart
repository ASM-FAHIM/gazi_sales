import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/report_controller.dart';
import 'package:gazi_sales_app/sales/module/view/report/pending_so_details_screen.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/app_constants.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PendingSOReport extends StatefulWidget {
  String xCus;
  String cusName;
  String zid;
  String xposition;


  PendingSOReport({required this.xCus, required this.cusName,required this.zid,required this.xposition, Key? key})
      : super(key: key);

  @override
  State<PendingSOReport> createState() => _PendingSOReportState();
}

class _PendingSOReportState extends State<PendingSOReport> {
  // ReportController report = Get.find<ReportController>();
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   report.fetchPendingSoList(widget.xCus);
  // }


  List<dynamic> responseData = [];

  // List<dynamic> data = json.decode(jsonString);
  Future<void> fetchData() async {

    print("http://${AppConstants.baseurl}/GAZI/SalesForce/reports/soQtyreport.php?zid=${widget.zid}&xposition=${widget.xposition}&xcus=${widget.xCus}");

    final response = await http.get(Uri.parse('http://${AppConstants.baseurl}/GAZI/SalesForce/reports/soQtyreport.php?zid=${widget.zid}&xposition=${widget.xposition}&xcus=${widget.xCus}'));

    if (response.statusCode == 200) {
      setState(() {
        responseData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.xCus}');

    double totalSOQty = 0;
    double totalSOVal = 0;
    double totalDCQty = 0;
    double totalDCVal = 0;
    double totalPendingQty = 0;
    double totalPendingVal = 0;
    double totalPreclosedQty = 0;

    // Calculate the sums
    for (var rowData in responseData) {
      totalSOQty += double.tryParse(rowData['xsoqty'].toString()) ?? 0;
      totalSOVal += double.tryParse(rowData['xsoval'].toString()) ?? 0;
      totalDCQty += double.tryParse(rowData['xdcqty'].toString()) ?? 0;
      totalDCVal += double.tryParse(rowData['xdcval'].toString()) ?? 0;
      totalPendingQty += double.tryParse(rowData['xpending'].toString()) ?? 0;
      totalPendingVal += double.tryParse(rowData['xpendingval'].toString()) ?? 0;
      totalPreclosedQty += double.tryParse(rowData['xpreclosedqty'].toString()) ?? 0;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          leading: GestureDetector(
              onTap: () {
                Get.back();
                // report.pendingList.clear();
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

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 10,
              horizontalMargin: 5,
              columns: const [
                DataColumn(label: Text('SO Number')),
                DataColumn(label: Text('Date')),
                //                 // DataColumn(label: Text('Customer')),
                //                 // DataColumn(label: Text('Type')),
                DataColumn(label: Text('Customer Name')),
                DataColumn(label: Text('Type')),
                DataColumn(
                  label: Align(
                    alignment: Alignment.centerRight,
                    child: Text('SO Qty'),
                  ),
                  numeric: true, // This will align the cell values to the right
                ),
                DataColumn(
                  label: Align(
                    alignment: Alignment.centerRight,
                    child: Text('SO Val'),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Align(
                    alignment: Alignment.centerRight,
                    child: Text('DC Qty'),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Align(
                    alignment: Alignment.centerRight,
                    child: Text('DC Val'),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Pending Qty'),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Pending Val'),
                  ),
                  numeric: true,
                ),

              ],
              rows: List<DataRow>.generate(
                responseData.length + 1, // +1 to add a final row for sums
                    (index) {
                  // Check if it's the last row for sums
                  if (index == responseData.length) {
                    return DataRow(
                      cells: [
                        DataCell(Text('Total')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text(totalSOQty.toStringAsFixed(2))),
                        DataCell(Text(totalSOVal.toStringAsFixed(2))),
                        DataCell(Text(totalDCQty.toStringAsFixed(2))),
                        DataCell(Text(totalDCVal.toStringAsFixed(2))),
                        DataCell(Text(totalPendingQty.toStringAsFixed(2))),
                        DataCell(Text(totalPendingVal.toStringAsFixed(2))),


                      ],
                    );
                  }
                  final rowData = responseData[index];
                  return DataRow(
                    cells: [
                      DataCell(
                          GestureDetector(
                            onTap: (){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Details: ${rowData['xsonumber']}'),
                                    content: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columnSpacing: 10,
                                          horizontalMargin: 5,
                                          columns: const [
                                            DataColumn(label: Text('Item')),
                                            DataColumn(label: Text('Description')),
                                            DataColumn(
                                              label: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text('SO Qty'),
                                              ),
                                              numeric: true, // This will align the cell values to the right
                                            ),
                                            DataColumn(
                                              label: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text('SO Val'),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text('DC Qty'),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text('DC Val'),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text('Pending Qty'),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text('Pending Val'),
                                              ),
                                              numeric: true,
                                            ),
                                          ],
                                          rows: List<DataRow>.generate(
                                            responseData[index]['xitem'].length,
                                                (itemIndex) {
                                              final rowData = responseData[index]['xitem'][itemIndex];
                                              return DataRow(
                                                cells: [
                                                  DataCell(SizedBox(width: 100, child: Text(rowData['xitem']))),
                                                  DataCell(SizedBox(width: 200, child: Text(rowData['xdesc']))),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(rowData['xsoqty'].toString()),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(rowData['xsoval'].toString()),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(rowData['xdcqty'].toString()),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(rowData['xdcval'].toString()),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(rowData['xpending'].toString()),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(rowData['xpendingval'].toString()),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );


                            },
                            child: SizedBox(
                                width: 130,
                                child: Text(rowData['xsonumber'])
                            ),
                          )
                      ),
                      DataCell(SizedBox(width: 60, child: Text(rowData['xdate']))),

                      DataCell(Text(rowData['xorg'].toString(),)),
                      DataCell(Text(rowData['xpnature'].toString())),
                      DataCell(Text(rowData['xsoqty'].toString(),textAlign: TextAlign.right)),
                      DataCell(Text(rowData['xsoval'].toString(),textAlign: TextAlign.right)),
                      DataCell(Text(rowData['xdcqty'].toString(),textAlign: TextAlign.right)),
                      DataCell(Text(rowData['xdcval'].toString(),textAlign: TextAlign.right)),
                      DataCell(Text(rowData['xpending'].toString(),textAlign: TextAlign.right)),
                      DataCell(Text(rowData['xpendingval'].toString(),textAlign: TextAlign.right)),



                    ],
                  );
                },
              ),
            ),
          ),
        ),




      ),
    );
  }

}
