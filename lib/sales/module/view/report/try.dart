// import 'package:flutter/material.dart';
//
// class Double_Column extends StatelessWidget {
//   const Double_Column();
//
//   @override
//   Widget build(BuildContext context) {
//     final double rowHeight = 28.0; // Define the row height based on font size
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Double Column"),
//       ),
//       body: SafeArea(
//         child: Container(
//           color: Colors.white,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Row(
//               children: [
//                 // Fixed first column
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Container(
//                     width: 240, // Width of the first column
//                     child: DataTable(
//                       columnSpacing: 2,
//                       horizontalMargin: 5,
//                       dataRowHeight: rowHeight,
//                       columns: [
//                         DataColumn(
//                           label: Text('Item code'),
//                         ),
//                         DataColumn(
//                           label: Text('Item name'),
//                         ),
//                         // Added DataColumn for Column B
//                       ],
//                       rows: List<DataRow>.generate(
//                         200,
//                             (index) => DataRow(
//                           cells: [
//                             DataCell(
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   height: rowHeight,
//                                   child: Text(report.monthlySoDetailsList[index].xitem),
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   height: rowHeight,
//                                   child: Text(report.monthlySoDetailsList[index].xdesc),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Scrollable columns
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: DataTable(
//                       columnSpacing: 2,
//                       horizontalMargin: 5,
//                       dataRowHeight: rowHeight,
//                       columns: [
//                         DataColumn(
//                           label: Text('So qty'),
//                         ),
//                         DataColumn(
//                           label: Text('So vl'),
//                         ),
//                         DataColumn(
//                           label: Text('Dc qty'),
//                         ),
//                         DataColumn(
//                           label: Text('Dc vl'),
//                         ),
//                       ],
//                       rows: List<DataRow>.generate(
//                         200,
//                             (index) => DataRow(
//                           cells: [
//                             DataCell(
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   height: rowHeight,
//                                   child: Text(report.monthlySoDetailsList[index].soQty),
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   height: rowHeight,
//                                   child: Text(report.monthlySoDetailsList[index].dcQty),
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Align(
//                                 alignment: Alignment
//                                     .centerRight, // Aligning to top right side
//                                 child: Container(
//                                   height: rowHeight,
//                                   child: Text(report.monthlySoDetailsList[index].soQty), // Formatting to two decimal places
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Align(
//                                 alignment: Alignment
//                                     .centerRight, // Aligning to top right side
//                                 child: Container(
//                                   height: rowHeight,
//                                   child: Text(report.monthlySoDetailsList[index].dcQty), // Formatting to two decimal places
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
