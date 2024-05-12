import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../sales/constant/app_constants.dart';

class Collection_BarChart extends StatelessWidget {
  Future<List<MonthData>> fetchDataFromApi() async {
    final response = await http.get(Uri.parse('http://${AppConstants.baseurl}/GAZI/management_dashboard/collection_barchart.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<MonthData> monthDataList = jsonResponse
          .map((data) => MonthData.fromJson(data))
          .toList()
          .cast<MonthData>();

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
            Text(
              "Collection of last 6 Month",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
                    var reversedData = List.from(snapshot.data!); // Create a copy of the data list
                    reversedData = reversedData.reversed.toList(); // Reverse the order of the list

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
                              'Target \n VS \n Achievement',
                              style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: List.generate(reversedData.length, (index) {
                          final monthData = reversedData[index];
                          final isOddRow = index % 2 == 0; // Check if row index is even or odd
                          final rowColor = isOddRow ? Colors.white : Colors.blueAccent.withOpacity(.1);

                          return DataRow(
                            color: MaterialStateColor.resolveWith((states) => rowColor),
                            cells: [
                              DataCell(
                                Text(
                                  monthData.month,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              DataCell(
                                buildBarChart(double.parse(monthData.target), double.parse(monthData.achivement)),
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
            //                 'Target \n VS \n Achievement',
            //                 style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.bold),
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
            //                   buildBarChart(double.parse(monthData.target), double.parse(monthData.achivement)),
            //                 ),
            //               ],
            //             );
            //           }),
            //         ),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildBarChart(double target, double achievement) {
    final formattedValueTarget = NumberFormat('#,##,###').format(target);
    final formattedValueAchievement = NumberFormat('#,##,###').format(achievement);

    return Container(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 15,
                width: target / 10000000, // Scale down the width for better visualization
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Color(0xff37A2DA), Color(0xff37A2DA)],
                  ),
                ),
                alignment: Alignment.center,

              ),
              Text(
                formattedValueTarget,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 15,
                width: achievement / 10000000, // Scale down the width for better visualization
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Color(0XFFFFD85C), Color(0XFFFFD85C)],
                  ),
                ),
                alignment: Alignment.center,
              ),
              Text(
                formattedValueAchievement,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MonthData {
  final String month;
  final String target;
  final String achivement;

  MonthData({
    required this.month,
    required this.target,
    required this.achivement,
  });

  factory MonthData.fromJson(Map<String, dynamic> json) {
    return MonthData(
      month: json['xmonthname'],
      target: json['target'] ?? '0',
      achivement: json['achivement'] ?? '0',
    );
  }
}
