import 'package:flutter/material.dart';
import '/modules/fluid_nav_bar.dart';

import '../models/customer_invoice_model.dart';
import '../models/shared_methods.dart';
import '../screen/invoices.dart';

class CustomerInvoicesDetailsControl extends StatefulWidget {
  final CustomerInvoiceDetails invoiceDetailsInfo;
  final int staticCustomerId;
  const CustomerInvoicesDetailsControl({Key? key, required this.invoiceDetailsInfo, required this.staticCustomerId,}) : super(key: key);

  @override
  State<CustomerInvoicesDetailsControl> createState() =>
      _CustomerInvoicesDetailsControlState();
}

class _CustomerInvoicesDetailsControlState extends State<CustomerInvoicesDetailsControl> {
  CustomerInvoiceDetails? invoiceDetailsInfo;
  var cards;

  Future<String> cancelRes() async {
    String status = '';
    await cancelReservation(widget.invoiceDetailsInfo.invoiceNo).then((value) {
      setState(() {
        status = value;
      });
    });

    return status;
  }

  @override
  Widget build(BuildContext context) {
    invoiceDetailsInfo = widget.invoiceDetailsInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tickets Summary",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: const Color(0xffC4DFDF),
        leading:
        IconButton(
            onPressed:  (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => FluidNavBar(staticCustomerId: widget.staticCustomerId)));},
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, bottom: 5),
                      child: Text(invoiceDetailsInfo!.locationName,
                        style: const TextStyle(color: Colors.blueGrey,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),)),
                  const Padding(
                      padding: EdgeInsets.only(left: 20,),
                      child: Text("Reservation Statues", style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),)),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Status:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.status,
                                style:  TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,
                                    color: invoiceDetailsInfo!.status == 'Confirmed '? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 20,),
                      child: Text("Reserved Spot Details", style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Container(

                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Spot Number:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.parkingSpotNumber,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Spot Section:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.parkingSectionDescription,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Spot Floor:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.parkingFloorDescriptions,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),

                  const Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text("Date And Time Details", style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),)),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.invoiceDateTime.substring(
                                    0, 10),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Start Time:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.invoiceDateTime.substring(
                                    10),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Period:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "${invoiceDetailsInfo!.ticketPeriod} Hours",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 20,),
                      child: Text("Invoice Details", style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),)),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Spot Cost Per Hour:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(invoiceDetailsInfo!.parkingSpotCostPerHour
                                  .toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Sub Total:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.subTotal.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tax Amount 15%:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                invoiceDetailsInfo!.taxAmount.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          const Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${invoiceDetailsInfo!.totalCost} SR',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),

                              ],

                            ),

                          ),

                        ],

                      ),

                    ),

                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton.icon(
                        onPressed: () {
                         if (invoiceDetailsInfo!.status == 'Confirmed '){
                           AlertDialog alert = AlertDialog(
                             // title: const Text(
                             //     "Are You Sure You Want To Cancel Your Reservation?"),
                             content: const Text(
                               "Are You Sure You Want To Cancel Your Reservation?",
                               // textAlign: TextAlign.center,
                               style: TextStyle(
                                   fontSize: 17, fontWeight: FontWeight.bold),
                             ),
                             actions: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   ElevatedButton(
                                     onPressed: () {
                                       Navigator.of(context).pop();
                                     },
                                     style: ElevatedButton.styleFrom(
                                       backgroundColor: const Color(0xffC4DFDF),
                                     ),
                                     child: const Text("No",
                                       style: TextStyle(color: Colors.white),),
                                   ),
                                   const SizedBox(width: 5),
                                   ElevatedButton(
                                     onPressed: () async {
                                       await cancelRes().then((value) {
                                         if (value == 'not allowed') {
                                           AlertDialog alert = AlertDialog(
                                             title: const Text(
                                                 "You Cannot Cancel"),
                                             content: const Text(
                                                 "Sorry, But You Need to Cancel before 24 Hours Then Your Reservation "),
                                             actions: [
                                               Center(child: ElevatedButton(
                                                   onPressed: () {
                                                     Navigator.of(context)
                                                         .pop();
                                                   },
                                                   style: ElevatedButton
                                                       .styleFrom(
                                                     backgroundColor: const Color(
                                                         0xffC4DFDF),
                                                   ),
                                                   child: const Text(
                                                     "OK", style: TextStyle(
                                                       color: Colors.white),))
                                               )
                                             ],
                                           );
                                           showDialog(context: context,
                                             builder: (BuildContext context) {
                                               return alert;
                                             },
                                           );
                                         } else if (value == 'ok') {
                                           AlertDialog alert = AlertDialog(
                                             content: const Text(
                                               "Your Reservation Has Been Cancelled Successfully",
                                               style: TextStyle(fontSize: 17,
                                                   fontWeight: FontWeight
                                                       .bold),),
                                             actions: [
                                               Center(
                                                   child: ElevatedButton(
                                                       onPressed: () {
                                                         Navigator.push(context,
                                                             MaterialPageRoute(
                                                                 builder: (
                                                                     context) =>
                                                                     FluidNavBar(
                                                                       staticCustomerId: widget
                                                                           .staticCustomerId,)));
                                                       },
                                                       child: const Text("OK", style: TextStyle(
                                                           color: Colors.white),),
                                                       style: ElevatedButton
                                                           .styleFrom(
                                                         backgroundColor: const Color(
                                                             0xffC4DFDF),
                                                       ))
                                               )
                                             ],
                                           );
                                           showDialog(context: context,
                                             builder: (BuildContext context) {
                                               return alert;
                                             },
                                           );
                                         }
                                       });
                                     },
                                     style: ElevatedButton.styleFrom(
                                       backgroundColor: Colors.orange,
                                     ),
                                     child: const Text("CANCEL Reservation",
                                       style: TextStyle(color: Colors.white,
                                           fontWeight: FontWeight.bold),),
                                   ),
                                 ],
                               ),
                             ],
                           );
                           showDialog(
                             context: context,
                             builder: (BuildContext context) {
                               return alert;
                             },
                           );
                         }


                        },
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          invoiceDetailsInfo!.status == 'Confirmed '?
                          "Cancel Reservation":"Reservation cancelled",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: invoiceDetailsInfo!.status == 'Confirmed '? Colors.orange : Colors.red,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
