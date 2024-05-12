import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../sales/constant/app_constants.dart';

class MR_BarChart extends StatelessWidget {
  Future<List<MonthData>> fetchDataFromApi() async {
    final response = await http.get(Uri.parse('http://${AppConstants.baseurl}/GAZI/management_dashboard/mr_barchart.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<MonthData> monthDataList = jsonResponse
          .map((data) => MonthData.fromJson(data))
          .toList()
          .cast<MonthData>();

      // Calculate the maximum value
      double maxValue = monthDataList.map((data) => data.value).reduce((a, b) => a > b ? a : b);

      // Update the values to be percentage of the maximum value
      for (var data in monthDataList) {
        data.valuePercentage = (data.value / maxValue) * 100;
      }

      return monthDataList;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [

            Text("MR of last 6 Month",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),

            FutureBuilder<List<MonthData>>(
              future: fetchDataFromApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Initialize previousMonth variable outside the List.generate method
                  String? previousMonth;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                      columns: [
                        DataColumn(
                          label: Text(
                            'Month',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Product',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Bar',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: List.generate(snapshot.data!.length, (index) {
                        final monthData = snapshot.data![index];
                        final isOddRow = index % 2 == 0; // Check if row index is even or odd
                        final rowColor = isOddRow ? Colors.white : Colors.blueAccent.withOpacity(.1);

                        // Check if the current month differs from the previous one
                        final currentMonth = monthData.month;
                        final displayMonth = currentMonth != previousMonth ? currentMonth : '';
                        previousMonth = currentMonth;

                        return DataRow(
                          color: MaterialStateColor.resolveWith((states) => rowColor),
                          cells: [
                            DataCell(
                              Text(
                                displayMonth,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            DataCell(
                              Text(
                                monthData.business,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            DataCell(
                              buildBarChart(monthData.valuePercentage, monthData.value),
                            ),
                          ],
                        );
                      }),
                    ),
                  );
                }
              },
            ),


            // FutureBuilder<List<MonthData>>(
            //   future: fetchDataFromApi(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       return SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: DataTable(
            //           headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
            //           columns: [
            //             DataColumn(
            //               label: Text(
            //                 'Month',
            //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             DataColumn(
            //               label: Text(
            //                 'Product',
            //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             DataColumn(
            //               label: Text(
            //                 'Bar',
            //                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           ],
            //           rows: List.generate(snapshot.data!.length, (index) {
            //             final monthData = snapshot.data![index];
            //             final isOddRow = index % 2 == 0; // Check if row index is even or odd
            //             final rowColor = isOddRow ? Colors.white : Colors.blueAccent.withOpacity(.1);
            //
            //             return DataRow(
            //               color: MaterialStateColor.resolveWith((states) => rowColor),
            //               cells: [
            //                 DataCell(
            //                   Text(
            //                     monthData.month,
            //                     style: TextStyle(color: Colors.black),
            //                   ),
            //                 ),
            //                 DataCell(
            //                   Text(
            //                     monthData.business,
            //                     style: TextStyle(color: Colors.black),
            //                   ),
            //                 ),
            //                 DataCell(
            //                   buildBarChart(monthData.valuePercentage, monthData.value),
            //                 ),
            //               ],
            //             );
            //           }),
            //         ),
            //       );
            //
            //
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildBarChart(double valuePercentage, double value) {
    final formattedValue = NumberFormat('#,##,###').format(value);
    return Container(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.3),
                ),// Grey background
              ),
              Container(
                height: 20,
                width: valuePercentage,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Color(0xff20FEFC), Color(0xff0895EB), Color(0xff20FEFC)],
                    // begin: Alignment.centerLeft,
                    // end: Alignment.centerRight,
                  ),
                ),
              ),


              Positioned(
                right: 8,
                child: Text(
                  '${valuePercentage.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            '৳ $formattedValue',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(20),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.blueGrey.withOpacity(0.5),
  //             spreadRadius: 1,
  //             blurRadius: 2,
  //             offset: Offset(0, 3), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         children: [
  //
  //           Text("MR of last 6 Month",
  //             style: TextStyle(
  //                 color: Colors.blue,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 25
  //             ),
  //           ),
  //
  //           FutureBuilder<List<MonthData>>(
  //             future: fetchDataFromApi(),
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 return CircularProgressIndicator();
  //               } else if (snapshot.hasError) {
  //                 return Text('Error: ${snapshot.error}');
  //               } else {
  //                 return SingleChildScrollView(
  //                   scrollDirection: Axis.horizontal,
  //                   child: DataTable(
  //                     headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
  //                     columns: [
  //                       DataColumn(
  //                         label: Text(
  //                           'Month',
  //                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       DataColumn(
  //                         label: Text(
  //                           'Product',
  //                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       DataColumn(
  //                         label: Text(
  //                           'Bar',
  //                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ],
  //                     rows: List.generate(snapshot.data!.length, (index) {
  //                       final monthData = snapshot.data![index];
  //                       final isOddRow = index % 2 == 0; // Check if row index is even or odd
  //                       final rowColor = isOddRow ? Colors.white : Colors.blueAccent.withOpacity(.1);
  //
  //                       return DataRow(
  //                         color: MaterialStateColor.resolveWith((states) => rowColor),
  //                         cells: [
  //                           DataCell(
  //                             Text(
  //                               monthData.month,
  //                               style: TextStyle(color: Colors.blue),
  //                             ),
  //                           ),
  //                           DataCell(
  //                             Text(
  //                               monthData.business,
  //                               style: TextStyle(color: Colors.blue),
  //                             ),
  //                           ),
  //                           DataCell(
  //                             buildBarChart(monthData.valuePercentage, monthData.value),
  //                           ),
  //                         ],
  //                       );
  //                     }),
  //                   ),
  //                 );
  //
  //
  //               }
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget buildBarChart(double valuePercentage, double value) {
  //   final formattedValue = NumberFormat('#,##,###').format(value);
  //   return Container(
  //     width: 150,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 20,
  //               width: valuePercentage,
  //               color: Colors.blue,
  //             ),
  //             SizedBox(width: 8),
  //             Text('${valuePercentage.toStringAsFixed(2)}%',
  //               style: TextStyle(
  //                   color: Colors.blue
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 4),
  //         Text('$formattedValue',
  //           style: TextStyle(
  //               color: Colors.blue
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class MonthData {
  final String month;
  final String business;
  final double value;
  double valuePercentage; // New field to store the percentage value

  MonthData({
    required this.month,
    required this.business,
    required this.value,
    required this.valuePercentage,
  });

  factory MonthData.fromJson(Map<String, dynamic> json) {
    final String month = json['xmonthname'];
    final String business = json['zorg'];
    final double value = double.parse(json['MR']);
    return MonthData(
      month: month,
      business: business,
      value: value,
      valuePercentage: 0.0, // Default value, will be updated later
    );
  }
}