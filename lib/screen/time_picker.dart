// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../models/locations_model.dart';
//
// class MyDateTimePicker extends StatefulWidget {
//
//   final int staticCustomerId;
//   const MyDateTimePicker(int locationId, {Key? key,  required this.staticCustomerId}) : super(key: key);
//
//   @override
//   State<MyDateTimePicker> createState() => _MyDateTimePickerState();
//
// }
//
// class _MyDateTimePickerState extends State<MyDateTimePicker> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }
//
//   void _submitDateTime() {
//     final formattedDate = DateFormat.yMd().format(selectedDate);
//     final formattedTime = selectedTime.format(context);
//
//     // You can use the selected date and time as needed, for example, send to server or display.
//     print('Selected Date: $formattedDate');
//     print('Selected Time: $formattedTime');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery
//           .of(context)
//           .size
//           .width - 30,
//       height: MediaQuery
//           .of(context)
//           .size
//           .height - 200,
//       child: Center(
//         child: GestureDetector(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Selected Date: ${DateFormat.yMd().format(selectedDate)}',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xffC4DFDF),
//
//                   foregroundColor: Colors.white, // foreground (text) color
//                 ),
//                 onPressed: () => _selectDate(context),
//                 child: Text('Select Date'),
//               ),
//               Container(
//                 child: RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       const TextSpan(
//                         text: "Parking Spot Section: ",
//                         style: TextStyle(color: Colors.blueGrey,),
//                       ),
//                       TextSpan(
//                         text: 'Selected Time:',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       TextSpan(
//                         text: selectedTime.format(context),
//                         style: TextStyle(fontSize: 18, color: Colors.orange),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xffC4DFDF),
//                   // background (button) color
//                   foregroundColor: Colors.white, // foreground (text) color
//                 ),
//                 onPressed: () => _selectTime(context),
//                 child: Text('Select Time'),
//               ),
//
//               // ElevatedButton(
//               //   style: ElevatedButton.styleFrom(
//               //     backgroundColor: Color(0xffC4DFDF),
//               //     // background (button) color
//               //     foregroundColor: Colors.white, // foreground (text) color
//               //   ),
//               //   onPressed: _submitDateTime,
//               //   child: Text('Submit Date and Time'),
//               // ),
//             ],
//           ),
//         ),
//       ),
//
//     );
//   }
// }