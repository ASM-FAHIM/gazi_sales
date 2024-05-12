import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constant/app_constants.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';

class WeeklySoSummary extends StatefulWidget {
  WeeklySoSummary({required this.zbusiness, required this.zid, required this.xposition});

  final String zid;
  final String zbusiness;
  final String xposition;

  @override
  _WeeklySoSummaryState createState() => _WeeklySoSummaryState();
}

class _WeeklySoSummaryState extends State<WeeklySoSummary> {
  List<dynamic> responseData = [];

 // List<dynamic> data = json.decode(jsonString);
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://${AppConstants.baseurl}/GAZI/SalesForce/reports/dailySO.php?zid=${widget.zid}&xposition=${widget.xposition}'));

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
    // Initialize sums for each column
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
      totalPendingQty += double.tryParse(rowData['xpendingqty'].toString()) ?? 0;
      totalPendingVal += double.tryParse(rowData['pending_val'].toString()) ?? 0;
      totalPreclosedQty += double.tryParse(rowData['xpreclosedqty'].toString()) ?? 0;
    }

    DataColumn _getRightAlignedColumn(String label) {
      return DataColumn(
        label: Align(
          alignment: Alignment.centerRight,
          child: Text(label),
        ),
        numeric: true, // This will align the cell values to the right
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: BigText(
          overflow: TextOverflow.ellipsis,
          text: "SO Summary Last 30 Days",
          color: AppColor.defWhite,
          size: 20,
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
                      DataCell(Align(alignment: Alignment.centerRight ,child: Text(totalSOQty.toStringAsFixed(2)))),
                      DataCell(Align(alignment: Alignment.centerRight ,child: Text(totalSOVal.toStringAsFixed(2)))),
                      DataCell(Align(alignment: Alignment.centerRight ,child: Text(totalDCQty.toStringAsFixed(2)))),
                      DataCell(Align(alignment: Alignment.centerRight ,child: Text(totalDCVal.toStringAsFixed(2)))),
                      DataCell(Align(alignment: Alignment.centerRight ,child: Text(totalPendingQty.toStringAsFixed(2)))),
                      DataCell(Align(alignment: Alignment.centerRight ,child: Text(totalPendingVal.toStringAsFixed(2)))),




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
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  child: AlertDialog(
                                    title: Text('Details: ${rowData['xsonumber']}'),
                                    content: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columnSpacing: 10,
                                          horizontalMargin: 5,
                                          /*columns: const [
                                            DataColumn(label: Text('Item')),
                                            DataColumn(label: Text('Description')),
                                            //                 // DataColumn(label: Text('Customer')),
                                            //                 // DataColumn(label: Text('Type')),
                                            DataColumn(label: Text('SO Qty')),
                                            DataColumn(label: Text('SO Val')),
                                            DataColumn(label: Text('DC Qty')),
                                            DataColumn(label: Text('DC Val')),
                                            DataColumn(label: Text('Pending Qty')),
                                            DataColumn(label: Text('Pending Val')),
                                            // DataColumn(label: Text('Preclosed Qty')),
                                          ],*/
                                          columns: const [
                                            DataColumn(label: Text('Item')),
                                            DataColumn(label: Text('Description')),
                                            DataColumn(
                                              label: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text('SO Qty'),
                                              ),
                                              numeric: true,
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
                                            // DataColumn(label: Text('Preclosed Qty')),
                                          ],
                                          rows: List<DataRow>.generate(
                                            responseData[index]['xitem'].length,
                                                (itemIndex) {
                                              final rowData = responseData[index]['xitem'][itemIndex];
                                              return DataRow(
                                                cells: [
                                                  DataCell(SizedBox(width: 100, child: Text(rowData['xitem']))),
                                                  DataCell(SizedBox(width: 200, child: Text(rowData['xdesc']))),
                                                  // DataCell(SizedBox(width: 200, child: Text("${rowData['xcus']}, ${rowData['xorg']}"))),
                                                  // DataCell(SizedBox(width: 50, child: Text(rowData['xpnature']))),
                                                  DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xsoqty'].toString()))),
                                                  DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xsoval'].toString()))),
                                                  DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xdcqty'].toString()))),
                                                  DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xdcval'].toString()))),
                                                  DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xpending'].toString()))),
                                                  DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xpendingval'].toString()))),

                                                  // DataCell(Text(rowData['xpreclosedqty'].toString())),
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
                                  ),
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
                    DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xsoqty'].toString()))),
                    DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xsoval'].toString()))),
                    DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xdcqty'].toString()))),
                    DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xdcval'].toString()))),
                    DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xpending'].toString()))),
                    DataCell(Align(alignment: Alignment.centerRight ,child: Text(rowData['xpendingval'].toString()))),




                  ],
                );
              },
            ),
          ),
        ),
      ),



    );
  }


}
