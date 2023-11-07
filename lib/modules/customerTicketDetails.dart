import 'package:flutter/material.dart';

import '../models/customer_tickets_model.dart';

class CustomerTicketsDetailsControl extends StatefulWidget {
  final CustomerTicketDetails ticketsDetailsInfo;
  const CustomerTicketsDetailsControl({Key? key, required this.ticketsDetailsInfo}) : super(key: key);

  @override
  State<CustomerTicketsDetailsControl> createState() => _CustomerTicketsDetailsControlState();
}

class _CustomerTicketsDetailsControlState extends State<CustomerTicketsDetailsControl> {
  CustomerTicketDetails? ticketsDetailsInfo;


  @override
  Widget build(BuildContext context) {
    ticketsDetailsInfo = widget.ticketsDetailsInfo;
    String invoiceNo = ticketsDetailsInfo!.invoiceNo.toString();

    // String parkingSpotNo = ticketsDetailsInfo!.parkingSpotNumber;
    return GestureDetector(
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    width: 70,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                          ticketsDetailsInfo!.locationLogo
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 180,
                        child: Text(ticketsDetailsInfo!.locationName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),),

                      ),
                      SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 180,
                          child: Text('Invoice Number: $invoiceNo',
                            textAlign: TextAlign.left,)

                      ),
                    ],
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Container(

                    margin: const EdgeInsets.only(top: 20.0),
                    // Adjust the top margin as needed
                    child: Row(
                        children: [
                          const Icon(Icons.car_rental,
                              color: Colors.amber, size: 20),
                          const SizedBox(width: 20,),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Parking Spot Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors
                                          .black),
                                ),
                                TextSpan(
                                  text:
                                  'hh',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff93A7A7)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),

                ),
              ],
            ),

            // const Padding(padding: EdgeInsets.all(5.0),
            //
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         child: Text("data"),
            //       ),
            //     ],
            //   ),)
          ],
        ),

    );
  }
}
