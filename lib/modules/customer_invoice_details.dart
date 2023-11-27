import 'package:flutter/material.dart';

import '../models/customer_tickets_model.dart';

class CustomerInvoicesDetailsControl extends StatefulWidget {
  final CustomerInvoiceDetails invoiceDetailsInfo;
  const CustomerInvoicesDetailsControl({
    Key? key,
    required this.invoiceDetailsInfo,
    required int staticCustomerId,
  }) : super(key: key);

  @override
  State<CustomerInvoicesDetailsControl> createState() =>
      _CustomerInvoicesDetailsControlState();
}

class _CustomerInvoicesDetailsControlState
    extends State<CustomerInvoicesDetailsControl> {
  CustomerInvoiceDetails? invoiceDetailsInfo;
var cards;
  @override
  Widget build(BuildContext context) {
    invoiceDetailsInfo = widget.invoiceDetailsInfo;
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          "Tickets Summary",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: const Color(0xffC4DFDF),
        // leading:
        // IconButton(
        //     onPressed:  (){  Navigator.push(context, MaterialPageRoute(
        //         builder: (context) => ReserveParkingSpot(
        //           staticCustomerId: widget.staticCustomerId,
        //           locationId: widget.locationID,
        //           dateRev: widget.resDate ,
        //           period: widget.period,
        //           locationName: widget.locationName,
        //           locationLogo: widget.locationLogo,)));},
        //     icon: const Icon(Icons.arrow_back)),
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
                      padding: const EdgeInsets.only(top: 20,left: 20,bottom:5),
                      child: Text(invoiceDetailsInfo!.locationName, style: const TextStyle(color: Colors.blueGrey,fontSize: 30, fontWeight: FontWeight.bold),)),

                  const Padding(
                      padding: EdgeInsets.only(left: 20,),
                      child: Text("Reserved Spot Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),

                  const Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text("Date And Time Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                invoiceDetailsInfo!.invoiceDateTime.substring(0,10),
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                                invoiceDetailsInfo!.invoiceDateTime.substring(10),
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 20,),
                      child: Text("Invoice Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),

                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                Text(invoiceDetailsInfo!.parkingSpotCostPerHour.toString(),
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
