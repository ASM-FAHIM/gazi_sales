// import 'package:flutter/material.dart';
//
// class HorizontalBarChart extends StatelessWidget {
//   final List<MonthData> data = [
//     MonthData(month: 'Jan', sink: 20, pipe: 25, door: 15, tanks: 30),
//     MonthData(month: 'Feb', sink: 22, pipe: 28, door: 18, tanks: 35),
//     MonthData(month: 'Mar', sink: 24, pipe: 30, door: 20, tanks: 40),
//     MonthData(month: 'Apr', sink: 26, pipe: 32, door: 22, tanks: 45),
//     MonthData(month: 'May', sink: 28, pipe: 34, door: 24, tanks: 50),
//     MonthData(month: 'Jun', sink: 30, pipe: 36, door: 26, tanks: 55),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     double maxSinkValue =
//     data.map((e) => e.sink).reduce((a, b) => a > b ? a : b).toDouble();
//     double maxPipeValue =
//     data.map((e) => e.pipe).reduce((a, b) => a > b ? a : b).toDouble();
//     double maxDoorValue =
//     data.map((e) => e.door).reduce((a, b) => a > b ? a : b).toDouble();
//     double maxTanksValue =
//     data.map((e) => e.tanks).reduce((a, b) => a > b ? a : b).toDouble();
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns: [
//           DataColumn(label: Text('Month')),
//           DataColumn(label: Text('Gazi Sink')),
//           DataColumn(label: Text('Gazi Pipe')),
//           DataColumn(label: Text('Gazi Door')),
//           DataColumn(label: Text('Gazi Tanks')),
//         ],
//         rows: data.map((monthData) {
//           return DataRow(cells: [
//             DataCell(Text(monthData.month)),
//             DataCell(
//               buildBarChart(double.parse(monthData.sink.toString()), maxSinkValue, monthData.sink),
//             ),
//             DataCell(
//               buildBarChart(double.parse(monthData.pipe.toString()), maxPipeValue, monthData.pipe),
//             ),
//             DataCell(
//               buildBarChart(double.parse(monthData.door.toString()), maxDoorValue, monthData.door),
//             ),
//             DataCell(
//               buildBarChart(double.parse(monthData.tanks.toString()), maxTanksValue, monthData.tanks),
//             ),
//           ]);
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget buildBarChart(double value, double maxValue, int displayValue) {
//     return Container(
//       width: 100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 20,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               FractionallySizedBox(
//                 widthFactor: value / maxValue,
//                 child: Container(
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 4),
//           Text('$displayValue'),
//         ],
//       ),
//     );
//   }
// }
//
// class MonthData {
//   final String month;
//   final int sink;
//   final int pipe;
//   final int door;
//   final int tanks;
//
//   MonthData(
//       {required this.month,
//         required this.sink,
//         required this.pipe,
//         required this.door,
//         required this.tanks});
// }

import 'dart:convert';

import 'package:flutter/material.dart';

// class HorizontalBarChart extends StatelessWidget {
//   final List<MonthData> data = [
//     MonthData(month: 'Jan', sink: 20, pipe: 25, door: 15, tanks: 30),
//     MonthData(month: 'Feb', sink: 22, pipe: 28, door: 18, tanks: 35),
//     MonthData(month: 'Mar', sink: 24, pipe: 30, door: 20, tanks: 40),
//     MonthData(month: 'Apr', sink: 26, pipe: 32, door: 22, tanks: 45),
//     MonthData(month: 'May', sink: 28, pipe: 34, door: 24, tanks: 50),
//     MonthData(month: 'Jun', sink: 30, pipe: 36, door: 26, tanks: 55),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns: [
//           DataColumn(label: Text('Month')),
//           DataColumn(label: Text('Product')),
//           DataColumn(label: Text('Bar')),
//         ],
//         rows: data.expand((monthData) {
//           return [
//             DataRow(cells: [
//               DataCell(Text(monthData.month)),
//               DataCell(Text('Gazi Sink')),
//               DataCell(buildBarChart(monthData.sink)),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('')),
//               DataCell(Text('Gazi Pipe')),
//               DataCell(buildBarChart(monthData.pipe)),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('')),
//               DataCell(Text('Gazi Door')),
//               DataCell(buildBarChart(monthData.door)),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('')),
//               DataCell(Text('Gazi Tanks')),
//               DataCell(buildBarChart(monthData.tanks)),
//             ]),
//           ];
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget buildBarChart(int value) {
//     return Container(
//       width: 100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 20,
//             width: value.toDouble(),
//             color: Colors.blue,
//           ),
//           SizedBox(height: 4),
//           Text('$value'),
//         ],
//       ),
//     );
//   }
// }
//
// class MonthData {
//   final String month;
//   final int sink;
//   final int pipe;
//   final int door;
//   final int tanks;
//
//   MonthData({
//     required this.month,
//     required this.sink,
//     required this.pipe,
//     required this.door,
//     required this.tanks,
//   });
// }



//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Monthly Gazi Data'),
//         ),
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: FutureBuilder<List<MonthData>>(
//               future: fetchDataFromApi(), // Fetch data from API
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return HorizontalBarChart(data: snapshot.data!);
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<List<MonthData>> fetchDataFromApi() async {
//     final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_HERE'));
//
//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((data) => MonthData.fromJson(data))
//           .toList()
//           .cast<MonthData>();
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   }
// }
//
// class HorizontalBarChart extends StatelessWidget {
//   final List<MonthData> data;
//
//   HorizontalBarChart({required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns: [
//           DataColumn(label: Text('Month')),
//           DataColumn(label: Text('Product')),
//           DataColumn(label: Text('Bar')),
//         ],
//         rows: data.expand((monthData) {
//           return [
//             DataRow(cells: [
//               DataCell(Text(monthData.month)),
//               DataCell(Text('Gazi Sink')),
//               DataCell(buildBarChart(monthData.sink)),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('')),
//               DataCell(Text('Gazi Pipe')),
//               DataCell(buildBarChart(monthData.pipe)),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('')),
//               DataCell(Text('Gazi Door')),
//               DataCell(buildBarChart(monthData.door)),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('')),
//               DataCell(Text('Gazi Tanks')),
//               DataCell(buildBarChart(monthData.tanks)),
//             ]),
//           ];
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget buildBarChart(int value) {
//     return Container(
//       width: 100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 20,
//             width: value.toDouble(),
//             color: Colors.blue,
//           ),
//           SizedBox(height: 4),
//           Text('$value'),
//         ],
//       ),
//     );
//   }
// }
//
// class MonthData {
//   final String month;
//   final int sink;
//   final int pipe;
//   final int door;
//   final int tanks;
//
//   MonthData({
//     required this.month,
//     required this.sink,
//     required this.pipe,
//     required this.door,
//     required this.tanks,
//   });
//
//   factory MonthData.fromJson(Map<String, dynamic> json) {
//     return MonthData(
//       month: json['month'],
//       sink: json['sink'],
//       pipe: json['pipe'],
//       door: json['door'],
//       tanks: json['tanks'],
//     );
//   }
// }

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//
// class HorizontalBarChart extends StatelessWidget {
//
//
//   Future<List<MonthData>> fetchDataFromApi() async {
//     final response = await http.get(Uri.parse('http://103.150.48.70:6116/GAZI/management_dashboard/mr_barchart.php'));
//
//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((data) => MonthData.fromJson(data))
//           .toList()
//           .cast<MonthData>();
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<MonthData>>(
//       future: fetchDataFromApi(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columns: [
//                 DataColumn(label: Text('Month')),
//                 DataColumn(label: Text('Product')),
//                 DataColumn(label: Text('Bar')),
//               ],
//               rows: snapshot.data!.map((monthData) {
//                 return DataRow(cells: [
//                   DataCell(Text(monthData.month)),
//                   DataCell(Text(monthData.business)),
//                   DataCell(buildBarChart(monthData.value.toDouble())),
//                 ]);
//               }).toList(),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   Widget buildBarChart(double value) {
//     return Container(
//       width: 100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 20,
//             width: value,
//             color: Colors.blue,
//           ),
//           SizedBox(height: 4),
//           Text('$value'),
//         ],
//       ),
//     );
//   }
// }
//
// class MonthData {
//   final String month;
//   final String business;
//   final double value;
//
//   MonthData({
//     required this.month,
//     required this.business,
//     required this.value,
//   });
//
//   factory MonthData.fromJson(Map<String, dynamic> json) {
//     final String month = json['xmonthname'];
//     final String business = json['zorg'];
//     final double value = double.parse(json['MR']);
//     return MonthData(month: month, business: business, value: value);
//   }
// }

//
// class HorizontalBarChart extends StatelessWidget {
//   Future<List<MonthData>> fetchDataFromApi() async {
//     final response = await http.get(Uri.parse('http://103.150.48.70:6116/GAZI/management_dashboard/mr_barchart.php'));
//
//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = json.decode(response.body);
//       List<MonthData> monthDataList = jsonResponse
//           .map((data) => MonthData.fromJson(data))
//           .toList()
//           .cast<MonthData>();
//
//       // Calculate the maximum value
//       double maxValue = monthDataList.map((data) => data.value).reduce((a, b) => a > b ? a : b);
//
//       // Update the values to be percentage of the maximum value
//       for (var data in monthDataList) {
//         data.valuePercentage = (data.value / maxValue) * 100;
//       }
//
//       return monthDataList;
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<MonthData>>(
//       future: fetchDataFromApi(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columns: [
//                 DataColumn(label: Text('Month')),
//                 DataColumn(label: Text('Product')),
//                 DataColumn(label: Text('Bar')),
//               ],
//               rows: snapshot.data!.map((monthData) {
//                 return DataRow(cells: [
//                   DataCell(Text(monthData.month)),
//                   DataCell(Text(monthData.business)),
//                   DataCell(buildBarChart(monthData.valuePercentage, monthData.value)),
//                 ]);
//               }).toList(),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   Widget buildBarChart(double valuePercentage, double value) {
//     return Container(
//       width: 100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 20,
//             width: valuePercentage,
//             color: Colors.blue,
//           ),
//           SizedBox(height: 4),
//           Text('$value'),
//         ],
//       ),
//     );
//   }
// }
//
// class MonthData {
//   final String month;
//   final String business;
//   final double value;
//   double valuePercentage; // New field to store the percentage value
//
//   MonthData({
//     required this.month,
//     required this.business,
//     required this.value,
//     required this.valuePercentage,
//   });
//
//   factory MonthData.fromJson(Map<String, dynamic> json) {
//     final String month = json['xmonthname'];
//     final String business = json['zorg'];
//     final double value = double.parse(json['MR']);
//     return MonthData(
//       month: month,
//       business: business,
//       value: value,
//       valuePercentage: 0.0, // Default value, will be updated later
//     );
//   }
// }


class BarChart extends StatelessWidget {
  Future<List<MonthData>> fetchDataFromApi() async {
    final response = await http.get(Uri.parse('http://103.150.48.70:6116/GAZI/management_dashboard/mr_barchart.php'));

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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.green,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FutureBuilder<List<MonthData>>(
          future: fetchDataFromApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Month')),
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('Bar')),
                  ],
                  rows: snapshot.data!.map((monthData) {
                    return DataRow(cells: [
                      DataCell(Text(monthData.month)),
                      DataCell(Text(monthData.business)),
                      DataCell(buildBarChart(monthData.valuePercentage, monthData.value)),
                    ]);
                  }).toList(),
                ),
              );
            }
          },
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
          Row(
            children: [
              Container(
                height: 20,
                width: valuePercentage,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text('${valuePercentage.toStringAsFixed(2)}%'),
            ],
          ),
          SizedBox(height: 4),
          Text('$formattedValue'),
        ],
      ),
    );
  }
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