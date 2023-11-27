// import 'package:flutter/material.dart';
// import 'package:pspot_test/models/shared_methods.dart';
// import '../modules/customer_invoice_details.dart';
// import '../modules/customer_tickets_summary_delete.dart';
// import '../modules/fluid_nav_bar.dart';
// import '/modules/floor_list_control.dart';
// import '../models/locations_model.dart';
// import 'Done_page.dart';
// import 'payment_page.dart';
//
// class ReserveParkingSpot extends StatefulWidget {
//   final int locationId;
//   final int staticCustomerId;
//   final String dateRev;
//   final int period;
//   final String locationName;
//   final String locationLogo;
//   const ReserveParkingSpot({super.key, required this.staticCustomerId, required this.dateRev, required this.locationId, required this.period, required this.locationName, required this.locationLogo});
//
//   @override
//   State<ReserveParkingSpot> createState() => _ReserveParkingSpot();
// }
//
// class _ReserveParkingSpot extends State<ReserveParkingSpot> {
//   List<LocationParkingSpotModelOnServer> spotsList = [];
//   bool showProcessing = true;
//   bool showTable = false;
//   bool showDetails = false;
//   String ticketId = '';
//   int ticketsIndex = 0;
//
//   String spotDes = '';
//   String sectionDes = '';
//   String floorDes = '';
//
//   void initParkingSpot(int locationId, int customerId,
//       String requriredDateAndTime, int requiredPeriod) async {
//     setState(() {
//       showTable = false;
//       showDetails = false;
//       showProcessing = true;
//     });
//     spotsList = [];
//     await getAvailableSpotsByLocation(
//         locationId, customerId, requriredDateAndTime, requiredPeriod).then((
//         value) {
//       setState(() {
//         spotsList = value;
//         showProcessing = false;
//         showTable = true;
//       });
//     });
//   }
//
//   Future<void> reserveSpot(int spotId, int customerId,
//       String ticketsDateAndTime, int requiredPeriod) async {
//     ticketId = '';
//     setState(() {
//       showTable = false;
//       showDetails = false;
//       showProcessing = true;
//     });
//     await reserveParkingSpot(
//         spotId, customerId, ticketsDateAndTime, requiredPeriod).then((value) {
//       setState(() {
//         ticketId = value;
//         showTable = false;
//         showDetails = true;
//         showProcessing = false;
//       });
//     });
//   }
//   var cards;
//
//   int rowsCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     initParkingSpot(widget.locationId, widget.staticCustomerId, widget.dateRev, widget.period);
//   }
//   double subTotal = 0;
//   double taxAmount = 0;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         title: Text('Book Your Tickets To \n${widget.locationName}',
//           style: const TextStyle(fontSize: 15),),
//         backgroundColor: const Color(0xffC4DFDF),),
//
//       body: Container(
//           margin: const EdgeInsets.only(top: 20.0),
//           child: SingleChildScrollView(
//               child: Center(
//                   child: SizedBox(
//                       height: 400,
//                       child: Column(
//                           children: [
//                             Visibility(
//                                 visible: showProcessing,
//                                 child: Center(
//                                   child: Image.asset(
//                                       'assets/images/processing.gif'),
//                                 )),
//                             // Locations
//                             Visibility(
//                               visible: showTable,
//                               child: Container(
//
//                                   height: MediaQuery
//                                       .sizeOf(context)
//                                       .height - 208,
//                                   child: ListView.builder(
//                                     itemCount: spotsList.length,
//                                     scrollDirection: Axis.vertical,
//                                     itemBuilder: (context, index) {
//                                       return Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             if (spotsList[index]
//                                                 .parkingSpotStatus == 'No') {
//                                               AlertDialog alert = AlertDialog(
//                                                 title: const Text(
//                                                     "Sorry, The Spot not Available"),
//                                                 content: const Text(
//                                                     "Please choose Another Spot"),
//                                                 actions: [
//                                                   Center(child: ElevatedButton(
//                                                       onPressed: () {
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                       },
//                                                       child: const Text("OK"),
//                                                       style: ElevatedButton
//                                                           .styleFrom(
//                                                         primary: const Color(
//                                                             0xffC4DFDF),
//                                                       ))
//                                                   )
//                                                 ],
//                                               );
//                                               showDialog(context: context,
//                                                 builder: (
//                                                     BuildContext context) {
//                                                   return alert;
//                                                 },);
//                                               print('no');
//                                             } else {
//                                               setState(() {
//                                                 showDetails = true;
//                                                 showTable = false;
//                                                 ticketsIndex = index;
//                                                 spotDes = spotsList[index].parkingSpotDescription;
//                                                 sectionDes = spotsList[index].sectionName;
//                                                 floorDes = spotsList[index].floorName;
//                                                 ticketsIndex = index;
//                                                 subTotal = spotsList[index].spotCost*widget.period;
//                                                 taxAmount = subTotal * 0.15;
//                                               });
//                                               // Navigator.push(context, MaterialPageRoute(
//                                               //     builder: (context) =>
//                                               //         PaymentPageEdited(staticCustomerId: widget.staticCustomerId, locationLogo: widget.locationLogo,
//                                               //           locationName: widget.locationName, ticketSpotInfo: spotsList[index], resDate: widget.dateRev,
//                                               //           period: widget.period,
//                                               //         )
//                                               // ));
//                                               print('yes');
//                                             }
//                                           },
//                                           child: Container(
//
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Container(
//
//                                                           width: (MediaQuery
//                                                               .of(context)
//                                                               .size
//                                                               .width / 2) - 10,
//                                                           padding: const EdgeInsets
//                                                               .all(8.0),
//                                                           decoration: BoxDecoration(
//                                                               color: const Color(
//                                                                   0xff9DB2B2),
//                                                               border: Border
//                                                                   .all(
//                                                                   color: Colors
//                                                                       .black)
//                                                           ),
//                                                           child: Text(
//                                                               spotsList[index]
//                                                                   .floorName,
//                                                               textAlign: TextAlign
//                                                                   .center)),
//                                                       Container(
//                                                           width: (MediaQuery
//                                                               .of(context)
//                                                               .size
//                                                               .width / 2) - 10,
//                                                           padding: const EdgeInsets
//                                                               .all(8.0),
//                                                           decoration: BoxDecoration(
//                                                               color: const Color(
//                                                                   0xff9DB2B2),
//
//                                                               border: Border
//                                                                   .all(
//                                                                   color: Colors
//                                                                       .black)
//                                                           ),
//                                                           child: Text(
//                                                             spotsList[index]
//                                                                 .sectionName,
//                                                             textAlign: TextAlign
//                                                                 .center,)),
//
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                           width: 40,
//                                                           height: 40,
//                                                           padding: const EdgeInsets
//                                                               .all(8.0),
//                                                           decoration: BoxDecoration(
//                                                               border: Border
//                                                                   .all(
//                                                                   color: Colors
//                                                                       .black)),
//                                                           child:
//                                                           FittedBox(
//                                                               fit: BoxFit.fill,
//                                                               child: spotsList[index]
//                                                                   .parkingSpotStatus ==
//                                                                   'Yes'
//                                                                   ? const Icon(
//                                                                 Icons
//                                                                     .check_circle,
//                                                                 color: Colors
//                                                                     .green,)
//                                                                   : const Icon(
//                                                                 Icons
//                                                                     .not_interested,
//                                                                 color: Colors
//                                                                     .red,)
//                                                           )),
//                                                       Container(
//                                                           width: 40,
//                                                           height: 40,
//                                                           padding: const EdgeInsets
//                                                               .all(8.0),
//                                                           decoration: BoxDecoration(
//                                                               border: Border
//                                                                   .all(
//                                                                   color: Colors
//                                                                       .black)
//                                                           ),
//                                                           child:
//                                                           FittedBox(
//                                                               fit: BoxFit.fill,
//                                                               child: Icon(Icons
//                                                                   .wheelchair_pickup_sharp,
//                                                                 color: spotsList[index]
//                                                                     .isSNSpot ==
//                                                                     'yes'
//                                                                     ? Colors
//                                                                     .black
//                                                                     : Colors
//                                                                     .white,)
//
//                                                           )),
//                                                       Container(
//                                                           width: ((MediaQuery
//                                                               .of(context)
//                                                               .size
//                                                               .width - 80) / 3),
//                                                           height: 40,
//                                                           padding: const EdgeInsets
//                                                               .all(8.0),
//                                                           decoration: BoxDecoration(
//                                                               border: Border
//                                                                   .all(
//                                                                   color: Colors
//                                                                       .black)
//                                                           ),
//                                                           child: Text(
//                                                             spotsList[index]
//                                                                 .parkingSpotDescription,
//                                                             textAlign: TextAlign
//                                                                 .center,)),
//                                                       Container(
//                                                           width: ((MediaQuery
//                                                               .of(context)
//                                                               .size
//                                                               .width - 80) /
//                                                               1.7) + 4,
//                                                           height: 40,
//                                                           padding: const EdgeInsets
//                                                               .all(8.0),
//                                                           decoration: BoxDecoration(
//                                                               border: Border
//                                                                   .all(
//                                                                   color: Colors
//                                                                       .black)
//                                                           ),
//                                                           child: Text(
//                                                             "${spotsList[index]
//                                                                 .spotCost} SR",
//                                                             textAlign: TextAlign
//                                                                 .center,)),
//                                                     ],
//                                                   )
//                                                 ],
//                                               )
//
//                                           ),
//                                         ),
//
//                                       );
//                                     },
//                                   )
//                               ),
//                             ),
//                             Visibility(
//                                 visible: showDetails,
//                                 child:Scaffold(
//                                   appBar: AppBar(
//                                     title:  const Text(
//                                       "Tickets Summary",
//                                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
//                                     backgroundColor: const Color(0xffC4DFDF),
//                                   ),
//                                   body: SingleChildScrollView(
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                               padding: const EdgeInsets.only(top: 20,left: 20,bottom:5),
//                                               child: Text(widget.locationName, style: const TextStyle(color: Colors.blueGrey,fontSize: 30, fontWeight: FontWeight.bold),)),
//
//                                           const Padding(
//                                               padding: EdgeInsets.only(left: 20,),
//                                               child: Text("Reserved Spot Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                             child: Container(
//
//                                               padding: const EdgeInsets.all(20),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey.withOpacity(0.5),
//                                                     spreadRadius: 3,
//                                                     blurRadius: 10,
//                                                     offset: const Offset(0, 3),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Spot Number:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         spotDes,
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Spot Section:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         sectionDes,
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Spot Floor:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         floorDes,
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//
//                                           const Padding(
//                                               padding: EdgeInsets.only(left: 20, top: 20),
//                                               child: Text("Date And Time Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
//
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                             child: Container(
//                                               padding: const EdgeInsets.all(20),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey.withOpacity(0.5),
//                                                     spreadRadius: 3,
//                                                     blurRadius: 10,
//                                                     offset: const Offset(0, 3),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Date:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         widget.dateRev.substring(0,10),
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Start Time:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         widget.dateRev.substring(10),
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Period:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         "${widget.period} Hours",
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           const Padding(
//                                               padding: EdgeInsets.only(left: 20,),
//                                               child: Text("Invoice Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
//
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                             child: Container(
//                                               padding: const EdgeInsets.all(20),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey.withOpacity(0.5),
//                                                     spreadRadius: 3,
//                                                     blurRadius: 10,
//                                                     offset: const Offset(0, 3),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Spot Cost Per Hour:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(spotsList[ticketsIndex].spotCost.toString(),
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Sub Total:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         subTotal.toString(),
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       const Text(
//                                                         "Tax Amount 15%:",
//                                                         style: TextStyle(fontSize: 20),
//                                                       ),
//                                                       Text(
//                                                         "${taxAmount}",
//                                                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ],
//                                                   ),
//
//                                                   const Divider(
//                                                     color: Colors.black,
//                                                   ),
//                                                   Padding(
//                                                     padding: const EdgeInsets.symmetric(
//                                                       vertical: 10,
//                                                     ),
//                                                     child: Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         const Text(
//                                                           "Total:",
//                                                           style: TextStyle(
//                                                             fontSize: 20,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           '${subTotal+taxAmount}',
//                                                           style: const TextStyle(
//                                                             fontSize: 20,
//                                                             fontWeight: FontWeight.bold,
//                                                             color: Colors.blue,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           const Padding(
//                                               padding: EdgeInsets.only(left: 20,),
//                                               child: Text("Payment Method", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                             child: Container(
//                                               padding: const EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey.withOpacity(0.5),
//                                                     spreadRadius: 3,
//                                                     blurRadius: 10,
//                                                     offset: const Offset(0, 3),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   RadioListTile(
//                                                     title: const Text("Debit/credit card"),
//                                                     value: "card",
//                                                     groupValue: cards,
//                                                     onChanged: (val) {
//                                                       setState(() {
//                                                         cards = val;
//                                                       });
//                                                     },
//                                                   ),
//                                                   RadioListTile(
//                                                     title: const Text("Apple Pay"),
//                                                     value: "apple_pay",
//                                                     groupValue: cards,
//                                                     onChanged: (val) {
//                                                       setState(() {
//                                                         cards = val;
//                                                       });
//                                                     },
//                                                   ),
//                                                   RadioListTile(
//                                                     title: const Text("Split in 4, interest-free"),
//                                                     value: "split",
//                                                     groupValue: cards,
//                                                     onChanged: (val) {
//                                                       setState(() {
//                                                         cards = val;
//                                                       });
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//                                             child: Center(
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(bottom: 40),
//                                                 child: ElevatedButton(
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor: const Color(0xffc4dde0),
//                                                     padding: const EdgeInsets.only(left: 80, right: 80, top: 20, bottom: 20),
//                                                   ),
//                                                   onPressed: () {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) =>  DonePage(staticCustomerId: widget.staticCustomerId,),
//                                                       ),
//                                                     );
//                                                   },
//                                                   child: const Text("Pay Now",
//                                                       style:
//                                                       TextStyle(fontSize: 20, color: Colors.white)),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                             )
//                           ]
//                       )
//                   )
//               )
//           )
//       ),
//       bottomNavigationBar: SizedBox(height: 70,
//           child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),
//
//     );
//   }
// }
